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
  const hasOptions =
    /- \*\*([A-E])\.\*\*/i.test(markdown) ||
    /- \(([A-E])\)/i.test(markdown) ||
    /^[A-E]\.\s+/im.test(markdown);

  if (!hasOptions) {
    return { introText: markdown, questions: [] };
  }

  // Normalize line endings
  const lines = markdown.replace(/\r\n/g, '\n').split('\n');

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
        currentBlock.endIndex = i;
        currentBlock.options.push({ key, text });
      }
    } else {
      if (currentBlock) {
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
  let introEndIndex = -1;

  for (let b = 0; b < optionBlocks.length; b++) {
    const block = optionBlocks[b];
    const prevBlock = b > 0 ? optionBlocks[b - 1] : null;

    // The lines leading up to this option block
    const stemStart = prevBlock ? prevBlock.endIndex + 1 : 0;
    const stemLines = lines.slice(stemStart, block.startIndex);

    let stem = '';
    let explanationForPrev = '';

    if (b === 0) {
      // In Question 1:
      // Check if there is an initial header/metadata (e.g. # Quiz _ 1, > [!NOTE], etc.)
      // The scenario text is right above the options
      let scenarioStartIndex = 0;
      for (let s = 0; s < stemLines.length; s++) {
        const line = stemLines[s].trim();
        // Skip markdown titles, badges, and percentage lines
        if (
          line.startsWith('#') ||
          line.startsWith('>') ||
          line.toLowerCase().includes('overview') ||
          line.toLowerCase().includes('diet ii') ||
          line.toLowerCase().includes('linkedin') ||
          /^\d+%$/.test(line)
        ) {
          scenarioStartIndex = s + 1;
        }
      }

      if (scenarioStartIndex > 0 && scenarioStartIndex < stemLines.length) {
        introEndIndex = scenarioStartIndex;
        stem = stemLines.slice(scenarioStartIndex).join('\n').trim();
      } else {
        stem = stemLines.join('\n').trim();
      }
    } else {
      // In between two option blocks:
      // The text after the previous block's options starts with that question's explanation,
      // and ends with the NEXT question's clinical stem.
      // Search from the end backwards for question separators or question marks
      let splitIndex = -1;

      // Look backwards for "## Question X"
      for (let s = stemLines.length - 1; s >= 0; s--) {
        if (/##\s*Question\s*\d+/i.test(stemLines[s])) {
          // The scenario usually begins right before or right after this header
          // If the line before has a question mark or sentence, check
          splitIndex = Math.max(0, s - 3);
          break;
        }
      }

      // If no question header found, find the last question mark '?'
      if (splitIndex < 0) {
        for (let s = stemLines.length - 1; s >= 0; s--) {
          if (stemLines[s].includes('?')) {
            splitIndex = Math.max(0, s - 4);
            break;
          }
        }
      }

      // Fallback: 60% explanation, 40% next stem
      if (splitIndex < 0) {
        splitIndex = Math.floor(stemLines.length * 0.6);
      }

      explanationForPrev = stemLines.slice(0, splitIndex).join('\n').trim();
      stem = stemLines.slice(splitIndex).join('\n').trim();

      if (questions.length > 0 && explanationForPrev) {
        questions[questions.length - 1].explanation = explanationForPrev;
      }
    }

    // Clean up headers like "## Question X of Y" from stem
    const cleanedStem = stem
      .replace(/##\s*Question\s*\d+\s*(?:of\s*\d+)?/gi, '')
      .replace(/^>.*$/gm, '')
      .trim();

    let explanation = '';
    if (b === optionBlocks.length - 1) {
      explanation = lines.slice(block.endIndex + 1).join('\n').trim();
    }

    // Determine correct answer
    let correctKey = 'A';
    const answerPattern = /(?:correct\s+(?:answer|option)|answer\s*is|answer:?)\s*[:*-]?\s*([A-E])\b/i;
    const matchAns = (explanation + ' ' + cleanedStem).match(answerPattern);

    if (matchAns) {
      correctKey = matchAns[1].toUpperCase();
    } else {
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
