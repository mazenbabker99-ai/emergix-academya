import { useEffect, useMemo, useState } from 'react';
import {
  AlertCircle,
  ArrowLeft,
  ArrowRight,
  Award,
  BookOpen,
  Check,
  CheckCircle2,
  Clock,
  ExternalLink,
  Flag,
  HelpCircle,
  Play,
  RefreshCw,
  Sparkles,
  Timer,
  X,
  XCircle,
} from 'lucide-react';
import type { ParsedQuestion } from './parseQuestions';

interface InteractiveQuizProps {
  quizTitle: string;
  questions: ParsedQuestion[];
  onComplete?: (score: { total: number; correct: number; percentage: number }) => void;
  nextLessonHref?: string;
  nextLessonTitle?: string;
}

export function InteractiveQuiz({
  quizTitle,
  questions,
  onComplete,
  nextLessonHref,
  nextLessonTitle,
}: InteractiveQuizProps) {
  // Mode: 'tutor' = instant feedback, 'exam' = exam conditions, feedback at end
  const [mode, setMode] = useState<'tutor' | 'exam'>('tutor');
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, string>>({});
  const [flaggedQuestions, setFlaggedQuestions] = useState<Set<number>>(new Set());
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [elapsedSeconds, setElapsedSeconds] = useState(0);
  const [reviewFilter, setReviewFilter] = useState<'all' | 'incorrect' | 'flagged'>('all');

  // Timer
  useEffect(() => {
    if (isSubmitted) return;
    const interval = setInterval(() => {
      setElapsedSeconds((s) => s + 1);
    }, 1000);
    return () => clearInterval(interval);
  }, [isSubmitted]);

  const currentQ = questions[currentIndex];
  const totalQuestions = questions.length;

  // Score statistics
  const scoreStats = useMemo(() => {
    let correct = 0;
    let incorrect = 0;
    let unanswered = 0;

    questions.forEach((q, idx) => {
      const selected = selectedAnswers[idx];
      if (!selected) {
        unanswered++;
      } else if (selected === q.correctKey) {
        correct++;
      } else {
        incorrect++;
      }
    });

    const percentage = totalQuestions > 0 ? Math.round((correct / totalQuestions) * 100) : 0;
    const isPassed = percentage >= 70; // MRCEM standard pass mark

    return {
      correct,
      incorrect,
      unanswered,
      total: totalQuestions,
      percentage,
      isPassed,
    };
  }, [questions, selectedAnswers, totalQuestions]);

  const formatTime = (secs: number) => {
    const m = Math.floor(secs / 60);
    const s = secs % 60;
    return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
  };

  const handleSelectOption = (key: string) => {
    if (isSubmitted && mode === 'exam') return;
    setSelectedAnswers((prev) => ({
      ...prev,
      [currentIndex]: key,
    }));
  };

  const toggleFlag = (index: number) => {
    setFlaggedQuestions((prev) => {
      const next = new Set(prev);
      if (next.has(index)) next.delete(index);
      else next.add(index);
      return next;
    });
  };

  const handleFinishQuiz = () => {
    setIsSubmitted(true);
    if (onComplete) {
      onComplete({
        total: totalQuestions,
        correct: scoreStats.correct,
        percentage: scoreStats.percentage,
      });
    }
  };

  const handleResetQuiz = () => {
    setSelectedAnswers({});
    setFlaggedQuestions(new Set());
    setIsSubmitted(false);
    setCurrentIndex(0);
    setElapsedSeconds(0);
  };

  if (questions.length === 0) {
    return null;
  }

  // Filtered review questions
  const filteredQuestions = questions
    .map((q, idx) => ({ q, idx }))
    .filter(({ q, idx }) => {
      if (reviewFilter === 'incorrect') {
        const sel = selectedAnswers[idx];
        return sel && sel !== q.correctKey;
      }
      if (reviewFilter === 'flagged') {
        return flaggedQuestions.has(idx);
      }
      return true;
    });

  // SUBMITTED RESULTS SUMMARY VIEW
  if (isSubmitted) {
    return (
      <div className="interactive-quiz-container" style={{ margin: '30px 0 50px' }}>
        <div
          style={{
            background: '#ffffff',
            borderRadius: '16px',
            border: '1px solid #dbe7f3',
            boxShadow: '0 10px 30px rgba(10, 35, 66, 0.08)',
            overflow: 'hidden',
          }}
        >
          {/* Header Banner */}
          <div
            style={{
              background: scoreStats.isPassed
                ? 'linear-gradient(135deg, #065f46 0%, #047857 100%)'
                : 'linear-gradient(135deg, #0a2342 0%, #0066cc 100%)',
              color: '#ffffff',
              padding: '36px 28px',
              textAlign: 'center',
            }}
          >
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 6,
                background: 'rgba(255,255,255,0.2)',
                padding: '4px 14px',
                borderRadius: '20px',
                fontSize: '.78rem',
                fontWeight: 700,
                textTransform: 'uppercase',
                letterSpacing: '.08em',
                marginBottom: 14,
              }}
            >
              {scoreStats.isPassed ? <Award size={16} /> : <BookOpen size={16} />}
              MRCEM SBA Evaluation Report
            </span>

            <h2 style={{ fontSize: '2rem', fontWeight: 800, margin: '0 0 10px', color: '#fff' }}>
              {quizTitle}
            </h2>

            <p style={{ margin: 0, opacity: 0.9, fontSize: '.95rem', maxWidth: '600px', marginInline: 'auto' }}>
              {scoreStats.isPassed
                ? 'Excellent work! Your score meets the Royal College of Emergency Medicine pass standard.'
                : 'Good attempt. Review the detailed explanations and high-yield pearls below to master these concepts.'}
            </p>

            {/* Score Ring / Circular Gauge */}
            <div
              style={{
                marginTop: 26,
                display: 'inline-flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                width: '130px',
                height: '130px',
                borderRadius: '50%',
                background: '#ffffff',
                color: scoreStats.isPassed ? '#047857' : '#0066cc',
                boxShadow: '0 6px 20px rgba(0,0,0,0.15)',
              }}
            >
              <span style={{ fontSize: '2.4rem', fontWeight: 900, lineHeight: 1 }}>
                {scoreStats.percentage}%
              </span>
              <span style={{ fontSize: '.72rem', fontWeight: 700, color: '#64748b', textTransform: 'uppercase', marginTop: 4 }}>
                {scoreStats.isPassed ? 'PASSED' : 'BENCHMARK: 70%'}
              </span>
            </div>
          </div>

          {/* Stats Bar */}
          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fit, minmax(130px, 1fr))',
              gap: 12,
              padding: '24px 28px',
              background: '#f8fafc',
              borderBottom: '1px solid #e2e8f0',
            }}
          >
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '.76rem', color: '#64748b', fontWeight: 600, textTransform: 'uppercase' }}>
                Total Questions
              </div>
              <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#0f172a' }}>
                {scoreStats.total}
              </div>
            </div>

            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '.76rem', color: '#16a34a', fontWeight: 600, textTransform: 'uppercase' }}>
                Correct
              </div>
              <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#16a34a' }}>
                {scoreStats.correct}
              </div>
            </div>

            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '.76rem', color: '#dc2626', fontWeight: 600, textTransform: 'uppercase' }}>
                Incorrect
              </div>
              <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#dc2626' }}>
                {scoreStats.incorrect}
              </div>
            </div>

            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '.76rem', color: '#64748b', fontWeight: 600, textTransform: 'uppercase' }}>
                Time Elapsed
              </div>
              <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#0f172a' }}>
                {formatTime(elapsedSeconds)}
              </div>
            </div>
          </div>

          {/* Action Bar */}
          <div
            style={{
              padding: '20px 28px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              flexWrap: 'wrap',
              gap: 12,
              borderBottom: '1px solid #edf2f7',
            }}
          >
            <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
              <button
                type="button"
                onClick={() => setReviewFilter('all')}
                style={{
                  padding: '6px 14px',
                  borderRadius: '20px',
                  fontSize: '.82rem',
                  fontWeight: 600,
                  cursor: 'pointer',
                  border: reviewFilter === 'all' ? '2px solid #0066cc' : '1px solid #cbd5e1',
                  background: reviewFilter === 'all' ? '#eff6ff' : '#ffffff',
                  color: reviewFilter === 'all' ? '#0066cc' : '#475569',
                }}
              >
                All Questions ({questions.length})
              </button>

              <button
                type="button"
                onClick={() => setReviewFilter('incorrect')}
                style={{
                  padding: '6px 14px',
                  borderRadius: '20px',
                  fontSize: '.82rem',
                  fontWeight: 600,
                  cursor: 'pointer',
                  border: reviewFilter === 'incorrect' ? '2px solid #dc2626' : '1px solid #cbd5e1',
                  background: reviewFilter === 'incorrect' ? '#fef2f2' : '#ffffff',
                  color: reviewFilter === 'incorrect' ? '#dc2626' : '#475569',
                }}
              >
                Incorrect Only ({scoreStats.incorrect})
              </button>

              {flaggedQuestions.size > 0 && (
                <button
                  type="button"
                  onClick={() => setReviewFilter('flagged')}
                  style={{
                    padding: '6px 14px',
                    borderRadius: '20px',
                    fontSize: '.82rem',
                    fontWeight: 600,
                    cursor: 'pointer',
                    border: reviewFilter === 'flagged' ? '2px solid #d97706' : '1px solid #cbd5e1',
                    background: reviewFilter === 'flagged' ? '#fffbeb' : '#ffffff',
                    color: reviewFilter === 'flagged' ? '#d97706' : '#475569',
                  }}
                >
                  Flagged ({flaggedQuestions.size})
                </button>
              )}
            </div>

            <div style={{ display: 'flex', gap: 10 }}>
              <button
                type="button"
                onClick={handleResetQuiz}
                className="btn btn-outline"
                style={{ fontSize: '.84rem', display: 'inline-flex', alignItems: 'center', gap: 6 }}
              >
                <RefreshCw size={14} /> Retake Quiz
              </button>

              {nextLessonHref && (
                <a
                  href={nextLessonHref}
                  className="btn btn-primary"
                  style={{ fontSize: '.84rem', display: 'inline-flex', alignItems: 'center', gap: 6 }}
                >
                  Next Lesson <ArrowRight size={14} />
                </a>
              )}
            </div>
          </div>

          {/* Question Breakdown List */}
          <div style={{ padding: '24px 28px', display: 'grid', gap: 24 }}>
            {filteredQuestions.length === 0 ? (
              <div style={{ textAlign: 'center', padding: '36px 20px', color: '#64748b' }}>
                <CheckCircle2 size={36} color="#16a34a" style={{ margin: '0 auto 10px' }} />
                <h3>No questions in this filter</h3>
                <p>You answered all other questions accurately.</p>
              </div>
            ) : (
              filteredQuestions.map(({ q, idx }) => {
                const userChoice = selectedAnswers[idx];
                const isCorrect = userChoice === q.correctKey;
                return (
                  <article
                    key={q.id}
                    style={{
                      border: '1px solid #e2e8f0',
                      borderRadius: '12px',
                      padding: '20px 22px',
                      background: '#ffffff',
                    }}
                  >
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 10 }}>
                      <span style={{ fontSize: '.78rem', fontWeight: 800, color: '#0066cc', textTransform: 'uppercase' }}>
                        Question {idx + 1} of {totalQuestions}
                      </span>
                      <span
                        style={{
                          fontSize: '.74rem',
                          fontWeight: 700,
                          padding: '3px 10px',
                          borderRadius: '12px',
                          background: isCorrect ? '#dcfce7' : '#fee2e2',
                          color: isCorrect ? '#15803d' : '#b91c1c',
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: 4,
                        }}
                      >
                        {isCorrect ? <Check size={13} /> : <X size={13} />}
                        {isCorrect ? 'Correct' : userChoice ? 'Incorrect' : 'Unanswered'}
                      </span>
                    </div>

                    <h4 style={{ fontSize: '1rem', color: '#0f172a', lineHeight: 1.5, margin: '0 0 16px' }}>
                      {q.stem}
                    </h4>

                    {/* Options list */}
                    <div style={{ display: 'grid', gap: 8, marginBottom: 16 }}>
                      {q.options.map((opt) => {
                        const isChosen = userChoice === opt.key;
                        const isRight = opt.key === q.correctKey;
                        let border = '#e2e8f0';
                        let bg = '#ffffff';
                        let color = '#334155';

                        if (isRight) {
                          border = '#16a34a';
                          bg = '#f0fdf4';
                          color = '#15803d';
                        } else if (isChosen && !isRight) {
                          border = '#dc2626';
                          bg = '#fef2f2';
                          color = '#b91c1c';
                        }

                        return (
                          <div
                            key={opt.key}
                            style={{
                              border: `1.5px solid ${border}`,
                              background: bg,
                              color,
                              padding: '10px 14px',
                              borderRadius: '8px',
                              display: 'flex',
                              alignItems: 'center',
                              justifyContent: 'space-between',
                              fontSize: '.88rem',
                            }}
                          >
                            <span style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                              <strong style={{ minWidth: '22px' }}>{opt.key}.</strong>
                              <span>{opt.text}</span>
                            </span>
                            {isRight && (
                              <span style={{ fontSize: '.72rem', fontWeight: 800, color: '#16a34a', textTransform: 'uppercase' }}>
                                Correct Answer
                              </span>
                            )}
                            {isChosen && !isRight && (
                              <span style={{ fontSize: '.72rem', fontWeight: 800, color: '#dc2626', textTransform: 'uppercase' }}>
                                Your Answer
                              </span>
                            )}
                          </div>
                        );
                      })}
                    </div>

                    {/* Detailed Explanation */}
                    {q.explanation && (
                      <div
                        style={{
                          background: '#f8fafc',
                          border: '1px solid #cbd5e1',
                          borderRadius: '8px',
                          padding: '14px 16px',
                          fontSize: '.86rem',
                          color: '#334155',
                          lineHeight: 1.6,
                        }}
                      >
                        <strong style={{ display: 'flex', alignItems: 'center', gap: 6, color: '#0369a1', marginBottom: 6 }}>
                          <Sparkles size={15} /> Clinical Rationale & Teaching Points:
                        </strong>
                        <div style={{ whiteSpace: 'pre-line' }}>{q.explanation}</div>
                      </div>
                    )}
                  </article>
                );
              })
            )}
          </div>
        </div>
      </div>
    );
  }

  // ACTIVE INTERACTIVE QUESTION SOLVER VIEW
  const selectedKey = selectedAnswers[currentIndex];
  const isAnswered = selectedKey !== undefined;
  const isCorrect = selectedKey === currentQ.correctKey;
  const isFlagged = flaggedQuestions.has(currentIndex);

  return (
    <div className="interactive-quiz-container" style={{ margin: '28px 0 45px' }}>
      <div
        style={{
          background: '#ffffff',
          borderRadius: '16px',
          border: '1px solid #dbe7f3',
          boxShadow: '0 8px 24px rgba(10, 35, 66, 0.06)',
          overflow: 'hidden',
        }}
      >
        {/* Top Control Bar */}
        <div
          style={{
            background: '#0a2342',
            color: '#ffffff',
            padding: '16px 22px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            gap: 16,
            flexWrap: 'wrap',
          }}
        >
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <span style={{ background: '#0066cc', padding: '4px 10px', borderRadius: '8px', fontSize: '.74rem', fontWeight: 700 }}>
              MRCEM SBA
            </span>
            <span style={{ fontSize: '.92rem', fontWeight: 700, color: '#f1f5f9' }}>
              Question {currentIndex + 1} of {totalQuestions}
            </span>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
            {/* Mode Selector */}
            <div
              style={{
                background: 'rgba(255,255,255,0.12)',
                borderRadius: '20px',
                padding: '3px',
                display: 'inline-flex',
                fontSize: '.75rem',
              }}
            >
              <button
                type="button"
                onClick={() => setMode('tutor')}
                style={{
                  border: 0,
                  background: mode === 'tutor' ? '#0066cc' : 'transparent',
                  color: '#ffffff',
                  padding: '3px 10px',
                  borderRadius: '16px',
                  cursor: 'pointer',
                  fontWeight: mode === 'tutor' ? 700 : 500,
                }}
                title="Immediate explanation after selecting an answer"
              >
                Tutor Mode
              </button>
              <button
                type="button"
                onClick={() => setMode('exam')}
                style={{
                  border: 0,
                  background: mode === 'exam' ? '#0066cc' : 'transparent',
                  color: '#ffffff',
                  padding: '3px 10px',
                  borderRadius: '16px',
                  cursor: 'pointer',
                  fontWeight: mode === 'exam' ? 700 : 500,
                }}
                title="Exam simulation — calculate score at the end"
              >
                Exam Mode
              </button>
            </div>

            {/* Timer */}
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 5,
                fontSize: '.82rem',
                color: '#93c5fd',
                fontWeight: 600,
              }}
            >
              <Timer size={15} /> {formatTime(elapsedSeconds)}
            </span>

            {/* Flag question */}
            <button
              type="button"
              onClick={() => toggleFlag(currentIndex)}
              style={{
                border: 0,
                background: isFlagged ? '#f59e0b' : 'rgba(255,255,255,0.15)',
                color: '#ffffff',
                padding: '5px 10px',
                borderRadius: '8px',
                cursor: 'pointer',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 5,
                fontSize: '.78rem',
                fontWeight: 600,
              }}
              title="Flag this question for review"
            >
              <Flag size={13} /> {isFlagged ? 'Flagged' : 'Flag'}
            </button>
          </div>
        </div>

        {/* Progress bar */}
        <div style={{ height: '4px', background: '#e2e8f0', width: '100%' }}>
          <div
            style={{
              height: '100%',
              background: '#0066cc',
              width: `${Math.round(((currentIndex + 1) / totalQuestions) * 100)}%`,
              transition: 'width .2s ease',
            }}
          />
        </div>

        {/* Question Area */}
        <div style={{ padding: '28px clamp(18px, 4vw, 36px)' }}>
          {/* Stem / Clinical scenario */}
          <div
            style={{
              fontSize: '1.08rem',
              fontWeight: 600,
              color: '#0a2342',
              lineHeight: 1.65,
              marginBottom: 24,
              letterSpacing: '-0.01em',
            }}
          >
            {currentQ.stem}
          </div>

          {/* Options (A, B, C, D, E) */}
          <div style={{ display: 'grid', gap: 10, marginBottom: 28 }} role="radiogroup">
            {currentQ.options.map((opt) => {
              const isSelected = selectedKey === opt.key;
              const isRight = opt.key === currentQ.correctKey;
              const showTutorResult = mode === 'tutor' && isAnswered;

              let borderColor = '#cbd5e1';
              let bgColor = '#ffffff';
              let textColor = '#1e293b';

              if (showTutorResult) {
                if (isRight) {
                  borderColor = '#16a34a';
                  bgColor = '#f0fdf4';
                  textColor = '#15803d';
                } else if (isSelected && !isRight) {
                  borderColor = '#dc2626';
                  bgColor = '#fef2f2';
                  textColor = '#b91c1c';
                }
              } else if (isSelected) {
                borderColor = '#0066cc';
                bgColor = '#eff6ff';
                textColor = '#0066cc';
              }

              return (
                <label
                  key={opt.key}
                  onClick={() => handleSelectOption(opt.key)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    gap: 14,
                    padding: '14px 18px',
                    borderRadius: '10px',
                    border: `2px solid ${borderColor}`,
                    background: bgColor,
                    cursor: 'pointer',
                    transition: 'all .15s ease',
                    userSelect: 'none',
                  }}
                  className="interactive-quiz-option"
                >
                  <span style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                    <span
                      style={{
                        width: '28px',
                        height: '28px',
                        borderRadius: '50%',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        fontWeight: 800,
                        fontSize: '.82rem',
                        background: isSelected
                          ? showTutorResult
                            ? isRight
                              ? '#16a34a'
                              : '#dc2626'
                            : '#0066cc'
                          : '#e2e8f0',
                        color: isSelected ? '#ffffff' : '#475569',
                      }}
                    >
                      {opt.key}
                    </span>
                    <span style={{ fontSize: '.95rem', fontWeight: isSelected ? 700 : 500, color: textColor }}>
                      {opt.text}
                    </span>
                  </span>

                  {showTutorResult && (
                    <span>
                      {isRight && <CheckCircle2 size={20} color="#16a34a" />}
                      {isSelected && !isRight && <XCircle size={20} color="#dc2626" />}
                    </span>
                  )}
                </label>
              );
            })}
          </div>

          {/* Immediate Tutor Feedback / Rationale */}
          {mode === 'tutor' && isAnswered && (
            <div
              style={{
                marginTop: 20,
                padding: '20px 22px',
                borderRadius: '12px',
                background: isCorrect ? '#f0fdf4' : '#fff7ed',
                border: isCorrect ? '1px solid #86efac' : '1px solid #fdba74',
                color: '#1f2937',
              }}
            >
              <div
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: 8,
                  fontSize: '.94rem',
                  fontWeight: 800,
                  color: isCorrect ? '#15803d' : '#c2410c',
                  marginBottom: 8,
                }}
              >
                {isCorrect ? <CheckCircle2 size={19} /> : <AlertCircle size={19} />}
                {isCorrect ? 'Correct Answer! Outstanding' : `Incorrect. The correct answer is Option ${currentQ.correctKey}`}
              </div>

              {currentQ.explanation && (
                <div style={{ fontSize: '.9rem', lineHeight: 1.65, marginTop: 8 }}>
                  <strong style={{ color: '#0f172a' }}>Clinical Explanation:</strong>
                  <div style={{ whiteSpace: 'pre-line', marginTop: 4 }}>{currentQ.explanation}</div>
                </div>
              )}
            </div>
          )}

          {/* Question Jump Navigation Matrix */}
          <div
            style={{
              marginTop: 32,
              paddingTop: 24,
              borderTop: '1px solid #e2e8f0',
              display: 'flex',
              flexDirection: 'column',
              gap: 16,
            }}
          >
            {/* Quick jump circles */}
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, alignItems: 'center' }}>
              <span style={{ fontSize: '.76rem', fontWeight: 700, color: '#64748b', marginRight: 4 }}>
                Questions:
              </span>
              {questions.map((_, i) => {
                const answered = selectedAnswers[i] !== undefined;
                const isCur = i === currentIndex;
                const flagged = flaggedQuestions.has(i);

                let bg = '#f1f5f9';
                let col = '#475569';
                let border = '1px solid #cbd5e1';

                if (isCur) {
                  border = '2px solid #0066cc';
                  bg = '#eff6ff';
                  col = '#0066cc';
                } else if (answered) {
                  bg = '#0066cc';
                  col = '#ffffff';
                  border = '1px solid #0066cc';
                }

                return (
                  <button
                    key={i}
                    type="button"
                    onClick={() => setCurrentIndex(i)}
                    style={{
                      width: '30px',
                      height: '30px',
                      borderRadius: '8px',
                      border,
                      background: bg,
                      color: col,
                      fontWeight: 700,
                      fontSize: '.75rem',
                      cursor: 'pointer',
                      position: 'relative',
                    }}
                    title={`Jump to Question ${i + 1}`}
                  >
                    {i + 1}
                    {flagged && (
                      <span
                        style={{
                          position: 'absolute',
                          top: -3,
                          right: -3,
                          width: '8px',
                          height: '8px',
                          borderRadius: '50%',
                          background: '#f59e0b',
                        }}
                      />
                    )}
                  </button>
                );
              })}
            </div>

            {/* Bottom buttons: Prev, Next, Submit */}
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                flexWrap: 'wrap',
                gap: 12,
              }}
            >
              <button
                type="button"
                onClick={() => setCurrentIndex((c) => Math.max(0, c - 1))}
                disabled={currentIndex === 0}
                className="btn btn-outline"
                style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: 6,
                  opacity: currentIndex === 0 ? 0.4 : 1,
                  fontSize: '.85rem',
                }}
              >
                <ArrowLeft size={15} /> Previous Question
              </button>

              <div style={{ display: 'flex', gap: 10 }}>
                {currentIndex < totalQuestions - 1 ? (
                  <button
                    type="button"
                    onClick={() => setCurrentIndex((c) => Math.min(totalQuestions - 1, c + 1))}
                    className="btn btn-primary"
                    style={{ display: 'inline-flex', alignItems: 'center', gap: 6, fontSize: '.85rem' }}
                  >
                    Next Question <ArrowRight size={15} />
                  </button>
                ) : (
                  <button
                    type="button"
                    onClick={handleFinishQuiz}
                    className="btn btn-primary"
                    style={{
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 6,
                      background: '#16a34a',
                      fontSize: '.85rem',
                    }}
                  >
                    <CheckCircle2 size={16} /> Submit Quiz & Calculate Score
                  </button>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
