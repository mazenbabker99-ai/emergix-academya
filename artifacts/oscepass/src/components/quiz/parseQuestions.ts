export interface ParsedOption {
  key: string; // 'A' | 'B' | 'C' | 'D' | 'E'
  text: string;
}

export interface ParsedQuestion {
  id: string;
  questionNumber: number;
  stem: string;
  options: ParsedOption[];
  correctKey: string;
  explanation: string;
  keyPoints?: string[];
}

// ─── constants ────────────────────────────────────────────────────────────────

/** Matches option lines: "- **A.** text", "A. text", "A) text" */
const OPTION_LINE_RE = /^(?:[-*]\s+)?(?:\*\*)?([A-E])[.)]\s*(?:\*\*\s*)?(.+)$/i;

/** Lines to strip as noise from PDF extraction */
const NOISE_LINE_RE =
  /^(?:\d+%$|(?:overview|comments|linkedin|facebook|twitter|instagram|youtube|mrcem\s+primary|diet\s+ii|0%\s*complete|mark\s+as\s+complete|previous\s*next|restart\s*quiz|your\s+score|the\s+average)\b)/i;

/** "## Question N of M" header */
const QHEADER_RE = /^##\s*Question\s+(\d+)\s+of\s+(\d+)\s*$/i;

/** Lines that end a clinical stem (end with ? or :) */
const STEM_ENDER_RE = /[?:]\s*$/;

// ─── main parser ──────────────────────────────────────────────────────────────

/**
 * Robust SBA parser for MRCEM-style PDFs.
 *
 * The raw body format (from the PDFs) looks like:
 *
 *   [STEM Q1, possibly ending with ':']
 *   ## Question 1 of 15        ← options header (N of TOTAL_QUESTIONS)
 *   - A. ...
 *   - E. ...
 *   ## Question 1 of 16        ← explanation header (same N, different denominator)
 *   [EXPLANATION Q1]
 *   [STEM Q2]
 *   ## Question 2 of 15
 *   - A. ...
 *   ...
 *
 * Strategy:
 *  1. Parse the body into "segments" delimited by ## Question headers.
 *  2. A segment with options (A-E lines) = option block.
 *  3. The text *before* the first option block = intro.
 *  4. For each option block:
 *     - STEM  = text between the *previous* option block's end and this block's header,
 *               taking the *last* clinical paragraph (ending with ? or :).
 *     - OPTIONS = A-E lines in the block.
 *     - EXPLANATION = text from after the options to the next option block header,
 *               excluding the next question's stem.
 */
export function parseSbaQuestions(markdown: string): {
  introText: string;
  questions: ParsedQuestion[];
} {
  if (!markdown || typeof markdown !== 'string') {
    return { introText: '', questions: [] };
  }

  const rawLines = markdown.replace(/\r\n/g, '\n').split('\n');

  // ── 1. Classify lines ─────────────────────────────────────────────────────
  type Line = {
    raw: string;
    t: string;         // trimmed
    isNoise: boolean;
    isHeader: boolean; // ## Question N of M
    headerN: number;
    headerM: number;
    isOption: boolean;
    optKey: string;
    optText: string;
  };

  const L: Line[] = rawLines.map((raw) => {
    const t = raw.trim();
    const hm = t.match(QHEADER_RE);
    const om = t.match(OPTION_LINE_RE);
    return {
      raw,
      t,
      isNoise: NOISE_LINE_RE.test(t),
      isHeader: !!hm,
      headerN: hm ? +hm[1] : 0,
      headerM: hm ? +hm[2] : 0,
      isOption: !!om && !hm,
      optKey: om ? om[1].toUpperCase() : '',
      optText: om ? om[2].replace(/^\*+/, '').replace(/\*+$/, '').trim() : '',
    };
  });

  // ── 2. Find option blocks (A-E clusters, anchored to headers) ─────────────
  // An "option block" starts right after a ## Question N of M header
  // and contains at least 2 distinct A-E lines.
  interface Block {
    headerLine: number;  // index of the ## Question header
    firstOpt: number;    // index of first option line
    lastOpt: number;     // index of last option line
    options: ParsedOption[];
    qNum: number;
  }

  const blocks: Block[] = [];

  let i = 0;
  while (i < L.length) {
    if (L[i].isHeader) {
      const hIdx = i;
      const headerN = L[i].headerN;
      // Collect options in a window of up to 20 lines after the header
      const opts: ParsedOption[] = [];
      let firstOpt = -1;
      let lastOpt = -1;
      let j = i + 1;
      while (j < L.length && j < i + 25) {
        if (L[j].isOption) {
          if (firstOpt < 0) firstOpt = j;
          lastOpt = j;
          // Avoid duplicates
          if (!opts.find((o) => o.key === L[j].optKey)) {
            opts.push({ key: L[j].optKey, text: L[j].optText });
          }
        } else if (L[j].isHeader) {
          break; // next header = stop
        }
        j++;
      }

      // Only add if we have ≥ 2 distinct options
      if (opts.length >= 2) {
        // Sort A→E
        const sorted = [...opts].sort((a, b) => a.key.charCodeAt(0) - b.key.charCodeAt(0));
        blocks.push({
          headerLine: hIdx,
          firstOpt,
          lastOpt: lastOpt >= 0 ? lastOpt : j - 1,
          options: sorted,
          qNum: headerN,
        });
        i = lastOpt >= 0 ? lastOpt + 1 : j;
        continue;
      }
    }
    i++;
  }

  if (blocks.length === 0) {
    // Try legacy mode: find any A-E clusters without headers
    return parseLegacyMode(L, markdown);
  }

  // ── 3. Build questions ────────────────────────────────────────────────────
  const questions: ParsedQuestion[] = [];

  for (let b = 0; b < blocks.length; b++) {
    const block = blocks[b];
    const prevBlockLastLine = b === 0 ? 0 : blocks[b - 1].lastOpt + 1;
    const nextBlockHeaderLine = b + 1 < blocks.length ? blocks[b + 1].headerLine : L.length;

    // ─── STEM ──────────────────────────────────────────────────────────────
    // Lines from prevBlockLastLine to block.headerLine (exclusive)
    const betweenLines: string[] = [];
    for (let k = prevBlockLastLine; k < block.headerLine; k++) {
      const lt = L[k];
      if (!lt.t || lt.isNoise || lt.isHeader) continue;
      // Skip blockquote lines (they're instructions/tips, not stems)
      if (lt.t.startsWith('>')) continue;
      // Skip title/header lines
      if (lt.t.startsWith('#')) continue;
      betweenLines.push(lt.t);
    }

    // ─── Find where stem starts in betweenLines ───────────────────────────
    // Stem starters: clinical vignette patterns
    const STEM_STARTER_RE =
      /^(?:A\s+\d+|An?\s+\d+|A\s+(?:patient|doctor|nurse|student|male|female|man|woman|child|boy|girl|neonate|pregnant|elderly)|You\s+are|Which\s+of\s+the\s+following|While\s+you|During|A\s+\d+-year)/i;

    // Walk backwards to find the LAST stem-starter line
    let stemStartIdx = -1;
    for (let s = betweenLines.length - 1; s >= 0; s--) {
      if (STEM_STARTER_RE.test(betweenLines[s])) {
        stemStartIdx = s;
        break;
      }
    }

    // If found a stem starter, take from stemStartIdx to end
    // Everything before stemStartIdx = explanation of previous question
    let stemRaw = '';
    if (stemStartIdx >= 0) {
      stemRaw = betweenLines.slice(stemStartIdx).join(' ');
      if (b > 0 && questions.length > 0 && stemStartIdx > 0) {
        const expAddition = betweenLines.slice(0, stemStartIdx).join('\n').trim();
        if (expAddition) {
          const prev = questions[questions.length - 1];
          prev.explanation = prev.explanation
            ? prev.explanation + '\n' + expAddition
            : expAddition;
        }
      }
    } else {
      // Fallback: look for last line ending with ? or :
      let stemEnd = betweenLines.length - 1;
      for (let s = betweenLines.length - 1; s >= 0; s--) {
        if (STEM_ENDER_RE.test(betweenLines[s])) {
          stemEnd = s;
          break;
        }
      }
      const stemFrom = Math.max(0, stemEnd - 14);
      stemRaw = betweenLines.slice(stemFrom, stemEnd + 1).join(' ');
      if (b > 0 && questions.length > 0 && stemFrom > 0) {
        const expAddition = betweenLines.slice(0, stemFrom).join('\n').trim();
        if (expAddition) {
          const prev = questions[questions.length - 1];
          prev.explanation = prev.explanation
            ? prev.explanation + '\n' + expAddition
            : expAddition;
        }
      }
    }

    const stem = cleanText(stemRaw);

    // ─── EXPLANATION ───────────────────────────────────────────────────────
    // Lines from block.lastOpt+1 to nextBlockHeaderLine
    const expLines: string[] = [];
    for (let k = block.lastOpt + 1; k < nextBlockHeaderLine; k++) {
      const lt = L[k];
      if (!lt.t || lt.isNoise || lt.isHeader) continue;
      expLines.push(lt.t);
    }

    // Trim next stem from end of explanation:
    // Find the last STEM_ENDER and cut there
    let expCut = expLines.length;
    for (let s = expLines.length - 1; s >= 0; s--) {
      if (STEM_ENDER_RE.test(expLines[s])) {
        expCut = s; // cut before this line (belongs to next stem)
        break;
      }
    }
    const expText = expLines.slice(0, Math.min(expCut, 20)).join('\n').trim();

    // ─── CORRECT KEY ───────────────────────────────────────────────────────
    const correctKey = detectCorrectKey(block.options, expText + ' ' + stemRaw);

    questions.push({
      id: `q-${b + 1}`,
      questionNumber: b + 1,
      stem: stem || `Clinical scenario for Question ${b + 1}`,
      options: block.options,
      correctKey,
      explanation: expText,
    });
  }

  // ── 4. Final explanation pass ──────────────────────────────────────────────
  for (const q of questions) {
    if (q.explanation) {
      const better = detectCorrectKey(q.options, q.explanation);
      if (better) q.correctKey = better;
    }
  }

  // ── 5. Intro text ─────────────────────────────────────────────────────────
  const firstHeaderLine = blocks[0]?.headerLine ?? 0;
  const introLines: string[] = [];
  for (let k = 0; k < firstHeaderLine; k++) {
    const lt = L[k];
    if (!lt.t || lt.isNoise) continue;
    // Keep NOTE/TIP blocks as intro
    introLines.push(lt.t);
  }
  const introText = introLines
    .join('\n')
    .replace(/^#[^#\n].*\n?/m, '') // strip title line
    .trim();

  return { introText, questions };
}

// ─── legacy mode (no ## Question headers) ────────────────────────────────────

function parseLegacyMode(
  L: { t: string; isNoise: boolean; isOption: boolean; optKey: string; optText: string }[],
  _markdown: string,
): { introText: string; questions: ParsedQuestion[] } {
  // Fall back: find A-E clusters
  const blocks: { start: number; end: number; options: ParsedOption[] }[] = [];
  let i = 0;
  while (i < L.length) {
    if (L[i].isOption) {
      const opts: ParsedOption[] = [{ key: L[i].optKey, text: L[i].optText }];
      const start = i;
      let last = i;
      let j = i + 1;
      while (j < L.length && j < i + 10) {
        if (L[j].isOption) {
          if (!opts.find((o) => o.key === L[j].optKey))
            opts.push({ key: L[j].optKey, text: L[j].optText });
          last = j;
        }
        j++;
      }
      if (opts.length >= 2) {
        blocks.push({
          start,
          end: last,
          options: opts.sort((a, b) => a.key.charCodeAt(0) - b.key.charCodeAt(0)),
        });
        i = last + 1;
        continue;
      }
    }
    i++;
  }

  if (blocks.length === 0) return { introText: '', questions: [] };

  const questions: ParsedQuestion[] = blocks.map((block, b) => {
    const prevEnd = b === 0 ? 0 : blocks[b - 1].end + 1;
    const stemLines = L.slice(prevEnd, block.start)
      .filter((l) => l.t && !l.isNoise)
      .map((l) => l.t)
      .slice(-10);
    const nextStart = b + 1 < blocks.length ? blocks[b + 1].start : L.length;
    const expLines = L.slice(block.end + 1, Math.min(nextStart, block.end + 20))
      .filter((l) => l.t && !l.isNoise)
      .map((l) => l.t);
    const stem = cleanText(stemLines.join(' '));
    const exp = expLines.join('\n').trim();
    return {
      id: `q-${b + 1}`,
      questionNumber: b + 1,
      stem: stem || `Question ${b + 1}`,
      options: block.options,
      correctKey: detectCorrectKey(block.options, exp),
      explanation: exp,
    };
  });

  return { introText: '', questions };
}

// ─── helpers ─────────────────────────────────────────────────────────────────

function cleanText(raw: string): string {
  return raw
    .replace(/##\s*Question\s*\d+\s*(?:of\s*\d+)?/gi, '')
    .replace(/^#+\s+.*/gm, '')           // strip markdown headers
    .replace(/^[>]+\s*\*?\*?[^*\n]*\*?\*?\s*/gm, '') // strip blockquotes
    .replace(/\[\s*!(?:NOTE|TIP|IMPORTANT|WARNING|CAUTION)\s*\]/gi, '')
    .replace(/\*\*Instructions?:?\*\*[^\n]*/gi, '')
    .replace(/Single best answer scenario[^\n]*/gi, '')
    .replace(/\s{2,}/g, ' ')
    .trim();
}

/**
 * Detects the correct answer key using:
 * 1. Explicit "correct answer is X" / "answer: X" pattern
 * 2. "(RECALL)" flag after an option or in explanation
 * 3. Full option text present verbatim in explanation
 * 4. Keyword overlap scoring
 */
function detectCorrectKey(options: ParsedOption[], context: string): string {
  const ctx = context.toLowerCase();

  // 1. Explicit match
  const explicit = context.match(
    /(?:correct\s+(?:answer|option)|answer\s*(?:is|:)|the\s+answer\s+is|rcem\s+key:?)\s*[:\-*]?\s*([A-E])\b/i,
  );
  if (explicit) return explicit[1].toUpperCase();

  // 2. Full phrase match
  for (const opt of options) {
    const phrase = opt.text.toLowerCase().replace(/[^a-z0-9 ]/g, '').trim();
    if (phrase.length > 5 && ctx.includes(phrase)) {
      return opt.key;
    }
  }

  // 3. Keyword overlap
  let best = options[0]?.key ?? 'A';
  let bestScore = -1;
  for (const opt of options) {
    const words = opt.text
      .toLowerCase()
      .replace(/[^a-z0-9 ]/g, '')
      .split(/\s+/)
      .filter((w) => w.length > 3);
    let score = 0;
    for (const w of words) {
      const re = new RegExp(`\\b${w}\\b`, 'gi');
      score += (ctx.match(re) || []).length;
    }
    if (score > bestScore) {
      bestScore = score;
      best = opt.key;
    }
  }
  return best;
}
