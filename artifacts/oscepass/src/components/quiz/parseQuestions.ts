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

// ─── Constants & Regexes ──────────────────────────────────────────────────────

const OPTION_LINE_RE = /^(?:[-*]\s+)?(?:\*\*)?([A-E])[.)]\s*(?:\*\*\s*)?(.+)$/i;
const QHEADER_RE = /^##+\s*Question\s+(\d+)(?:\s+of\s+(\d+))?/i;
const NOISE_LINE_RE =
  /^(?:\d+%$|(?:overview|comments|linkedin|facebook|twitter|instagram|youtube|mrcem\s+primary|diet\s+ii|0%\s*complete|mark\s+as\s+complete|previous\s*next|restart\s*quiz|your\s+score|the\s+average)\b)/i;

/** Recognizes the start of a clinical scenario / question stem */
const CLINICAL_STEM_STARTER_RE =
  /(?:A\s+\d+|An?\s+\d+|A\s+(?:patient|doctor|nurse|student|male|female|man|woman|child|boy|girl|neonate|pregnant|elderly)|You\s+(?:are|prescribe|ask|note|suspect|have)|Which\s+of\s+the\s+following|What\s+is\s+the|Whilst\s+|During\s+)[^?:]+[?:]/gi;

// ─── Helpers ──────────────────────────────────────────────────────────────────

function stemWord(w: string): string {
  return (w || '').toLowerCase().replace(/(?:ing|ed|es|s)$/, '');
}

function norm(str: string): string {
  return (str || '')
    .toLowerCase()
    .replace(/[–—−]/g, '-')
    .replace(/\b([a-z])\s*\/\s*([a-z0-9])/gi, '$1/$2')
    .replace(/\b([tclds])\s*[-/]?\s*(\d+)\b/gi, '$1$2')
    .replace(/\b([tclds]\d+)\s*[-/]\s*([tclds]?\d+)\b/gi, '$1$2')
    .replace(/\b[-–]ve\b/gi, 'negative')
    .replace(/\b[+–]ve\b/gi, 'positive')
    .replace(/[^a-z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function cleanText(raw: string): string {
  return raw
    .replace(/##+\s*Question\s*\d+\s*(?:of\s*\d+)?/gi, '')
    .replace(/^#+\s+.*/gm, '') // strip markdown headers
    .replace(/^[>]+\s*\*?\*?[^*\n]*\*?\*?\s*/gm, '') // strip blockquotes
    .replace(/\[\s*!(?:NOTE|TIP|IMPORTANT|WARNING|CAUTION)\s*\]/gi, '')
    .replace(/\*\*Instructions?:?\*\*[^\n]*/gi, '')
    .replace(/Single best answer scenario[^\n]*/gi, '')
    .replace(/\s{2,}/g, ' ')
    .trim();
}

// ─── Main SBA Parser ──────────────────────────────────────────────────────────

/**
 * High-precision SBA Parser for MRCEM Medical Question Banks.
 * Accurately extracts options (A-E), isolates clinical stems from rationales,
 * and determines the true correct answer key with high clinical fidelity.
 */
export function parseSbaQuestions(markdown: string): {
  introText: string;
  questions: ParsedQuestion[];
} {
  if (!markdown || typeof markdown !== 'string') {
    return { introText: '', questions: [] };
  }

  const rawLines = markdown.replace(/\r\n/g, '\n').split('\n');

  // Strategy 1: Check if markdown contains structured question blocks (## Question X)
  const hasQuestionHeaders = /^##+\s*Question\s+\d+/im.test(markdown);

  if (hasQuestionHeaders) {
    const parts = markdown.split(/(?=^##+\s*Question\s+\d+)/gim);
    const questions: ParsedQuestion[] = [];
    let introText = '';

    for (let p = 0; p < parts.length; p++) {
      const part = parts[p].trim();
      if (!/^##+\s*Question\s+\d+/i.test(part)) {
        introText += (introText ? '\n' : '') + part;
        continue;
      }

      const lines = part.split('\n');
      const headerLine = lines[0];
      const qNumMatch = headerLine.match(/Question\s+(\d+)/i);
      const questionNumber = qNumMatch ? parseInt(qNumMatch[1], 10) : questions.length + 1;

      const options: ParsedOption[] = [];
      const stemLines: string[] = [];
      const explLines: string[] = [];
      let foundOptions = false;

      for (let i = 1; i < lines.length; i++) {
        const line = lines[i].trim();
        if (NOISE_LINE_RE.test(line)) continue;

        const optMatch = line.match(OPTION_LINE_RE);
        if (optMatch) {
          foundOptions = true;
          const key = optMatch[1].toUpperCase();
          const text = optMatch[2].replace(/^\*+/, '').replace(/\*+$/, '').trim();
          if (!options.find((o) => o.key === key)) {
            options.push({ key, text });
          }
        } else if (!foundOptions) {
          if (line) stemLines.push(line);
        } else {
          if (line) explLines.push(line);
        }
      }

      if (options.length < 2) continue;
      options.sort((a, b) => a.key.charCodeAt(0) - b.key.charCodeAt(0));

      const explText = explLines.join('\n');
      const stemText = stemLines.join(' ');
      const correctKey = detectCorrectAnswer(options, explText, stemText, part);

      const cleanExpl = explLines
        .filter((l) => !/^(?:\*\*)?(?:correct\s+(?:answer|option)|rcem\s+key|answer\s*(?:is|:))/i.test(l.trim()))
        .map((l) => l.replace(/^(?:\*\*)?Explanation:\s*(?:\*\*)?/i, ''))
        .join(' ')
        .trim();

      questions.push({
        id: `q-${questionNumber}`,
        questionNumber,
        stem: cleanText(stemText) || `Question ${questionNumber}`,
        options,
        correctKey,
        explanation: cleanExpl || explText || 'Refer to clinical guidelines and question rationale.',
      });
    }

    if (questions.length > 0) {
      return { introText: cleanText(introText), questions };
    }
  }

  // Strategy 2: Group option lines into sets (A through E) for legacy formats
  interface OptionSet {
    options: ParsedOption[];
    firstLine: number;
    lastLine: number;
  }

  const optionSets: OptionSet[] = [];
  let currentSet: ParsedOption[] = [];
  let firstOptLine = -1;
  let lastOptLine = -1;

  for (let i = 0; i < rawLines.length; i++) {
    const t = rawLines[i].trim();
    const om = t.match(OPTION_LINE_RE);
    if (om) {
      const key = om[1].toUpperCase();
      const text = om[2].replace(/^\*+/, '').replace(/\*+$/, '').trim();
      if (key === 'A' && currentSet.length >= 3) {
        optionSets.push({ options: currentSet, firstLine: firstOptLine, lastLine: lastOptLine });
        currentSet = [];
      }
      if (currentSet.length === 0) firstOptLine = i;
      lastOptLine = i;
      if (!currentSet.find((o) => o.key === key)) {
        currentSet.push({ key, text });
      }
    }
  }
  if (currentSet.length >= 2) {
    optionSets.push({ options: currentSet, firstLine: firstOptLine, lastLine: lastOptLine });
  }

  if (optionSets.length === 0) {
    return { introText: cleanText(markdown), questions: [] };
  }

  // Build questions strictly keeping stem before options and explanation after options
  const questions: ParsedQuestion[] = [];

  for (let b = 0; b < optionSets.length; b++) {
    const set = optionSets[b];
    set.options.sort((a, b) => a.key.charCodeAt(0) - b.key.charCodeAt(0));

    const prevLastLine = b === 0 ? 0 : optionSets[b - 1].lastLine + 1;
    const curFirstLine = set.firstLine;
    const curLastLine = set.lastLine + 1;
    const nextFirstLine = b + 1 < optionSets.length ? optionSets[b + 1].firstLine : rawLines.length;

    // Stem is strictly from text BEFORE options
    const stemLines: string[] = [];
    for (let k = prevLastLine; k < curFirstLine; k++) {
      const t = rawLines[k].trim();
      if (!t || NOISE_LINE_RE.test(t) || QHEADER_RE.test(t) || OPTION_LINE_RE.test(t)) continue;
      if (t.startsWith('>') || t.startsWith('#')) continue;
      stemLines.push(t);
    }

    // Explanation is from text AFTER options
    const explLines: string[] = [];
    for (let k = curLastLine; k < nextFirstLine; k++) {
      const t = rawLines[k].trim();
      if (!t || NOISE_LINE_RE.test(t) || QHEADER_RE.test(t) || OPTION_LINE_RE.test(t)) continue;
      if (t.startsWith('>') || t.startsWith('#')) continue;
      explLines.push(t);
    }

    const stemText = stemLines.join(' ');
    const explText = explLines.join(' ');
    const fullText = `${stemText} ${explText}`;

    const correctKey = detectCorrectAnswer(set.options, explText, stemText, fullText);

    questions.push({
      id: `q-${b + 1}`,
      questionNumber: b + 1,
      stem: cleanText(stemText) || `Question ${b + 1}`,
      options: set.options,
      correctKey,
      explanation: cleanText(explText) || stemText,
    });
  }

  // Intro text from top of document
  const firstOptLineIdx = optionSets[0]?.firstLine ?? 0;
  const introLines: string[] = [];
  for (let k = 0; k < firstOptLineIdx; k++) {
    const t = rawLines[k].trim();
    if (!t || NOISE_LINE_RE.test(t) || QHEADER_RE.test(t) || OPTION_LINE_RE.test(t)) continue;
    introLines.push(t);
  }
  const introText = introLines.join('\n').replace(/^#[^#\n].*\n?/m, '').trim();

  return { introText, questions };
}

// ─── Serializer ───────────────────────────────────────────────────────────────

/**
 * Converts structured questions back into clean, standard Markdown for saving.
 */
export function serializeQuestionsToMarkdown(title: string, questions: ParsedQuestion[], introText?: string): string {
  let md = `# ${title || 'Quiz'}\n\n`;
  if (introText) {
    md += `> [!NOTE]\n> **Instructions:** ${introText}\n\n`;
  } else {
    md += `> [!NOTE]\n> **Instructions:** Single best answer scenario. Read the clinical presentation carefully before reviewing the detailed rationale.\n\n`;
  }

  questions.forEach((q, idx) => {
    const qNum = q.questionNumber || idx + 1;
    md += `## Question ${qNum} of ${questions.length}\n\n`;
    md += `${(q.stem || '').trim()}\n\n`;
    (q.options || []).forEach((opt) => {
      md += `- **${opt.key}.** ${(opt.text || '').trim()}\n`;
    });
    md += `\n**Correct Answer:** ${q.correctKey || 'A'}\n`;
    md += `**Explanation:**\n${(q.explanation || '').trim()}\n\n`;
  });

  return md.trim();
}

// ─── Answer Key Detection Engine ──────────────────────────────────────────────

/**
 * 5-tier intelligent detector for SBA correct answers:
 * 1. Explicit letter marker (e.g. "Answer: B", "**Correct Answer:** C")
 * 2. Explicit text marker (e.g. "Rcem key: soyabean")
 * 3. Exact multi-word phrase or medical landmark / spinal level match (e.g. "T10 = level of Umbilicus", "T4/T5")
 * 4. Medical acronym expansion (e.g. "ADH" -> Antidiuretic hormone)
 * 5. Stemmed keyword overlap & unique keyword scoring
 */
function detectCorrectAnswer(
  options: ParsedOption[],
  explanation: string,
  stem: string,
  fullContext: string,
): string {
  const normExp = norm(explanation);
  const normCtx = norm(fullContext);
  const rawCtx = fullContext.toLowerCase();

  // Tier 1: Explicit answer letter marker
  const explicit = rawCtx.match(
    /(?:rcem\s+key|correct\s+(?:answer|option)|answer\s*(?:is|:)|the\s+answer\s+is)[*:\-\s]+([A-E])\b/i,
  );
  if (explicit) return explicit[1].toUpperCase();

  // Tier 2: Explicit text marker (e.g. "rcem key: soyabean")
  const expTextMatch = rawCtx.match(
    /(?:rcem\s+key|correct\s+(?:answer|option)|the\s+answer\s+is)[*:\-\s]+([a-z0-9\s–—\-]{3,40})/i,
  );
  if (expTextMatch) {
    const target = norm(expTextMatch[1]);
    for (const opt of options) {
      const nOpt = norm(opt.text);
      if (nOpt.length > 2 && (target.includes(nOpt) || nOpt.includes(target))) {
        return opt.key;
      }
    }
  }

  // Tier 3: Exact multi-word phrase or spinal landmark / level match
  const exactMatches: { key: string; len: number; text: string }[] = [];
  for (const opt of options) {
    const nOpt = norm(opt.text);
    if (nOpt.length >= 2) {
      const isLevel = /^[tclds]\d+$/i.test(nOpt);
      if (isLevel) {
        const levelRe = new RegExp(
          `(?:\\b${nOpt}\\s*[:=]|[:=]\\s*${nOpt}\\b|\\b${nOpt}\\b\\s*\\([a-z0-9\\s]+\\))`,
          'i',
        );
        if (levelRe.test(rawCtx)) {
          exactMatches.push({ key: opt.key, len: 15, text: opt.text });
        }
      } else if (nOpt.length >= 4) {
        const re = new RegExp(`\\b${nOpt.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')}\\b`, 'i');
        if (re.test(normExp) || re.test(normCtx)) {
          exactMatches.push({ key: opt.key, len: nOpt.length, text: opt.text });
        }
      }
    }
  }

  if (exactMatches.length === 1) {
    return exactMatches[0].key;
  }
  if (exactMatches.length > 1) {
    exactMatches.sort((a, b) => b.len - a.len);
    return exactMatches[0].key;
  }

  // Tier 4: Medical acronym expansions with strict word boundaries
  const ACRONYMS: Record<string, string> = {
    adh: 'antidiuretic hormone vasopressin',
    no: 'nitric oxide',
  };
  for (const [acro, expanded] of Object.entries(ACRONYMS)) {
    if (new RegExp(`\\b${acro}\\b`, 'i').test(rawCtx)) {
      for (const opt of options) {
        const nOpt = norm(opt.text);
        if (nOpt.length >= 3 && expanded.includes(nOpt)) {
          return opt.key;
        }
      }
    }
  }

  // Tier 5: Stemmed keyword overlap & unique keyword scoring
  const stemWords = new Set(norm(stem).split(' ').map(stemWord).filter((w) => w.length > 3));
  const expWords = normCtx.split(' ').map(stemWord);
  let bestKey = options[0]?.key || 'A';
  let bestScore = -1;

  for (const opt of options) {
    const words = norm(opt.text)
      .split(' ')
      .map(stemWord)
      .filter((w) => w.length >= 3 && !stemWords.has(w));
    let score = 0;
    for (const w of words) {
      const count = expWords.filter((ew) => ew === w).length;
      score += count * (w.length > 5 ? 2 : 1);
    }
    if (score > bestScore) {
      bestScore = score;
      bestKey = opt.key;
    }
  }

  return bestKey;
}
