import type { ParsedQuestion } from './parseQuestions';

/**
 * @deprecated
 * generateTopicQuiz.ts is intentionally left as an empty stub.
 *
 * Quiz questions are now sourced exclusively from the lesson body markdown
 * via `parseSbaQuestions()` in parseQuestions.ts.
 *
 * This function always returns an empty array so that no generic / off-topic
 * questions are displayed. If a lesson has no embedded SBA questions, the
 * quiz launch card is hidden entirely in LessonPage.tsx.
 */
export function getLessonTopicQuiz(_lessonTitle: string, _lessonBody: string): ParsedQuestion[] {
  return [];
}
