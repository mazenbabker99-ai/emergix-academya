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

/**
 * Parses markdown containing Single Best Answer (SBA) questions into structured questions.
 * Handles patterns from MRCEM question banks, e.g.:
 * - Clinical vignette
 * - "## Question X of Y" or "## Question X"
 * - Options list: "- **A.** ...", "- **B.** ..."
 * - Rationales, high-yield pearls, and recall notes
 */
export function parseSbaQuestions(markdown: string): {
  introText: string;
  questions: ParsedQuestion[];
} {
  if (!markdown || typeof markdown !== 'string') {
    return { introText: '', questions: [] };
  }

  // Check if text has any SBA-style options (- **A.** or similar)
  const hasOptions = /- \*\*([A-E])\.\*\*/i.test(markdown) || /- \(([A-E])\)/i.test(markdown);
  if (!hasOptions) {
    return { introText: markdown, questions: [] };
  }

  // Normalize line endings
  const lines = markdown.replace(/\r\n/g, '\n').split('\n');

  // Find all option indices
  interface OptionLine {
    lineIndex: number;
    key: string;
    text: string;
  }

  const optionRegex = /^(?:[-*]\s+)?(?:\*\*)?([A-E])[\.)]\s*(?:\*\*)?\s*(.+)$/i;

  // Group continuous option lines into question blocks
  const optionBlocks: {
    startIndex: number;
    endIndex: number;
    options: ParsedOption[];
  }[] = [];

  let currentBlock: { startIndex: number; endIndex: number; options: ParsedOption[] } | null = null;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();
    const match = line.match(optionRegex);

    if (match) {
      const key = match[1].toUpperCase();
      const text = match[2].replace(/^\*\*/, '').replace(/\*\*$/, '').trim();

      if (!currentBlock) {
        currentBlock = {
          startIndex: i,
          endIndex: i,
          options: [{ key, text }],
        };
      } else {
        // If this option key is sequential or continuing
        currentBlock.endIndex = i;
        currentBlock.options.push({ key, text });
      }
    } else {
      if (currentBlock) {
        // Only accept blocks with at least 2 options (A, B, ...)
        if (currentBlock.options.length >= 2) {
          optionBlocks.push(currentBlock);
        }
        currentBlock = null;
      }
    }
  }

  if (currentBlock && currentBlock.options.length >= 2) {
    optionBlocks.push(currentBlock);
  }

  if (optionBlocks.length === 0) {
    return { introText: markdown, questions: [] };
  }

  const questions: ParsedQuestion[] = [];
  let introEndIndex = 0;

  for (let b = 0; b < optionBlocks.length; b++) {
    const block = optionBlocks[b];
    const prevBlock = b > 0 ? optionBlocks[b - 1] : null;

    // Stem is between the previous block's end (or start of doc) and this block's start
    const stemStart = prevBlock ? prevBlock.endIndex + 1 : 0;
    const stemLines = lines.slice(stemStart, block.startIndex);

    // If this is the first question, check if there's general intro text before it
    let stem = '';
    let explanationForPrev = '';

    if (b === 0) {
      // Find where intro ends and question stem begins
      // A question stem usually begins after the intro or under a Question header
      const qHeaderIdx = stemLines.findIndex((l) => /##\s*Question\s*\d+/i.test(l));
      if (qHeaderIdx > 0) {
        introEndIndex = qHeaderIdx;
        stem = stemLines.slice(qHeaderIdx).join('\n').trim();
      } else {
        stem = stemLines.join('\n').trim();
      }
    } else {
      // In between two option blocks:
      // The first part belongs to the PREVIOUS question's explanation!
      // The second part (leading up to this question's options) is THIS question's stem.
      // Often separated by a "## Question X" header or a new scenario.
      const qHeaderIdx = stemLines.findIndex((l) => /##\s*Question\s*\d+/i.test(l));
      if (qHeaderIdx >= 0) {
        explanationForPrev = stemLines.slice(0, qHeaderIdx).join('\n').trim();
        stem = stemLines.slice(qHeaderIdx).join('\n').trim();
      } else {
        // Split roughly half or look for question mark
        const lastQMark = stemLines.findLastIndex((l) => l.includes('?'));
        if (lastQMark >= 0) {
          // Look backwards a few lines for the scenario
          const scenarioStart = Math.max(0, lastQMark - 4);
          explanationForPrev = stemLines.slice(0, scenarioStart).join('\n').trim();
          stem = stemLines.slice(scenarioStart).join('\n').trim();
        } else {
          // 60% explanation, 40% next stem
          const splitPoint = Math.floor(stemLines.length * 0.6);
          explanationForPrev = stemLines.slice(0, splitPoint).join('\n').trim();
          stem = stemLines.slice(splitPoint).join('\n').trim();
        }
      }

      if (questions.length > 0 && explanationForPrev) {
        questions[questions.length - 1].explanation = explanationForPrev;
      }
    }

    // Clean up question header from stem
    const cleanedStem = stem
      .replace(/##\s*Question\s*\d+\s*(?:of\s*\d+)?/gi, '')
      .replace(/^>.*$/gm, '')
      .trim();

    // Clean explanation for the last block if it's the last question
    let explanation = '';
    if (b === optionBlocks.length - 1) {
      explanation = lines.slice(block.endIndex + 1).join('\n').trim();
    }

    // Determine correct answer
    // 1. Look for explicit "Correct answer: X" or "Answer: X" in explanation or stem
    let correctKey = 'A';
    const answerPattern = /(?:correct\s+(?:answer|option)|answer\s*is|answer:?)\s*[:*-]?\s*([A-E])\b/i;
    const matchAns = (explanation + ' ' + cleanedStem).match(answerPattern);

    if (matchAns) {
      correctKey = matchAns[1].toUpperCase();
    } else {
      // 2. Score each option against the explanation text
      let maxScore = 0;
      let bestKey = block.options[0]?.key || 'A';

      for (const opt of block.options) {
        const optWords = opt.text
          .toLowerCase()
          .replace(/[^a-z0-9\s]/g, '')
          .split(/\s+/)
          .filter((w) => w.length > 3);

        if (optWords.length === 0) continue;

        let score = 0;
        const expLower = explanation.toLowerCase();

        for (const word of optWords) {
          if (expLower.includes(word)) {
            score += 2;
          }
        }

        // Exact match of full option text in explanation
        if (expLower.includes(opt.text.toLowerCase().trim())) {
          score += 10;
        }

        if (score > maxScore) {
          maxScore = score;
          bestKey = opt.key;
        }
      }

      correctKey = bestKey;
    }

    questions.push({
      id: `q-${b + 1}`,
      questionNumber: b + 1,
      stem: cleanedStem || `Scenario and clinical details for Question ${b + 1}`,
      options: block.options,
      correctKey,
      explanation: explanation || 'Clinical rationale and high-yield examination pearls.',
    });
  }

  // Refine correct answers once all explanations are set
  for (const q of questions) {
    if (!q.explanation) continue;
    const expLower = q.explanation.toLowerCase();
    for (const opt of q.options) {
      const optClean = opt.text.toLowerCase().trim();
      if (optClean.length > 4 && expLower.includes(optClean)) {
        q.correctKey = opt.key;
        break;
      }
    }
  }

  const introText = introEndIndex > 0 ? lines.slice(0, introEndIndex).join('\n').trim() : '';

  return {
    introText,
    questions,
  };
}
