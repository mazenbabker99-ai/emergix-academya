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
const QHEADER_RE = /^##\s*Question\s+(\d+)\s+of\s+(\d+)\s*$/i;
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
    .replace(/##\s*Question\s*\d+\s*(?:of\s*\d+)?/gi, '')
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

  // 1. Group option lines into sets (A through E)
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
      // If key 'A' is found and we already have options for a question, start a new set
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

  // 2. Build questions by parsing surrounding clinical stem & explanation
  const questions: ParsedQuestion[] = [];

  for (let b = 0; b < optionSets.length; b++) {
    const set = optionSets[b];
    // Sort options A -> E
    set.options.sort((a, b) => a.key.charCodeAt(0) - b.key.charCodeAt(0));

    const prevLastLine = b === 0 ? 0 : optionSets[b - 1].lastLine + 1;
    const nextFirstLine = b + 1 < optionSets.length ? optionSets[b + 1].firstLine : rawLines.length;

    // Collect non-noise text between previous and next option sets
    const candidateLines: string[] = [];
    for (let k = prevLastLine; k < nextFirstLine; k++) {
      const t = rawLines[k].trim();
      if (!t || NOISE_LINE_RE.test(t) || QHEADER_RE.test(t) || OPTION_LINE_RE.test(t)) continue;
      if (t.startsWith('>') || t.startsWith('#')) continue;
      candidateLines.push(t);
    }

    const fullText = candidateLines.join(' ');
    let stem = '';
    let explanation = '';

    // Clinical stem detection: find matches starting with typical clinical triggers
    const stemMatches = fullText.match(CLINICAL_STEM_STARTER_RE);
    if (stemMatches && stemMatches.length > 0) {
      // Pick the last clinical question sentence before or around the options
      stem = cleanText(stemMatches[stemMatches.length - 1]);
      explanation = cleanText(fullText.replace(stem, ''));
    } else {
      // Fallback: look for any sentence ending with ? or :
      const qMatches = fullText.match(/(?:[A-Z][^?]*\?|[A-Z][^:]*:)/g);
      if (qMatches && qMatches.length > 0) {
        stem = cleanText(qMatches[qMatches.length - 1]);
        explanation = cleanText(fullText.replace(stem, ''));
      } else {
        stem = cleanText(fullText.slice(0, 220));
        explanation = cleanText(fullText.slice(220));
      }
    }

    const correctKey = detectCorrectAnswer(set.options, explanation, stem, fullText);

    questions.push({
      id: `q-${b + 1}`,
      questionNumber: b + 1,
      stem: stem || `Question ${b + 1}`,
      options: set.options,
      correctKey,
      explanation: explanation || fullText,
    });
  }

  // 3. Intro text from top of document
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

// ─── Answer Key Detection Engine ──────────────────────────────────────────────

/**
 * 5-tier intelligent detector for SBA correct answers:
 * 1. Explicit letter marker (e.g. "Answer: B", "Rcem key: C")
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
    /(?:rcem\s+key|correct\s+(?:answer|option)|answer\s*(?:is|:)|the\s+answer\s+is)\s*[:\-*]?\s*([A-E])\b/i,
  );
  if (explicit) return explicit[1].toUpperCase();

  // Tier 2: Explicit text marker (e.g. "rcem key: soyabean")
  const expTextMatch = rawCtx.match(
    /(?:rcem\s+key|correct\s+(?:answer|option)|the\s+answer\s+is)\s*[:\-*]?\s*([a-z0-9\s–—\-]{3,40})/i,
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
        const re = new RegExp(`\\b${nOpt.replace(/\s+/g, '\\s+')}\\b`, 'i');
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
