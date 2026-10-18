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
  Eye,
  Flag,
  HelpCircle,
  Lightbulb,
  Maximize2,
  Minimize2,
  Play,
  PlayCircle,
  RefreshCw,
  RotateCcw,
  Sparkles,
  Strikethrough,
  Timer,
  X,
  XCircle,
  Zap,
} from 'lucide-react';
import type { ParsedQuestion } from './parseQuestions';

interface InteractiveQuizProps {
  quizTitle: string;
  questions: ParsedQuestion[];
  onComplete?: (score: { total: number; correct: number; percentage: number }) => void;
  nextLessonHref?: string;
  nextLessonTitle?: string;
  /** Called when the user clicks "Exit Exam" from within the quiz (e.g. to close the overlay) */
  onExitExam?: () => void;
  /** Auto-start without showing the lobby setup screen */
  autoStart?: boolean;
}

export function InteractiveQuiz({
  quizTitle,
  questions,
  onComplete,
  nextLessonHref,
  nextLessonTitle,
  onExitExam,
  autoStart = false,
}: InteractiveQuizProps) {
  // Exam states
  const [isStarted, setIsStarted] = useState(autoStart);
  // Mode: 'tutor' = instant feedback, 'exam' = exam conditions, feedback at end
  const [mode, setMode] = useState<'tutor' | 'exam'>('tutor');
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, string>>({});
  const [flaggedQuestions, setFlaggedQuestions] = useState<Set<number>>(new Set());
  // Strikethrough elimination: questionIndex -> Set of option keys (e.g. 'A', 'C')
  const [eliminatedOptions, setEliminatedOptions] = useState<Record<number, Set<string>>>({});
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [elapsedSeconds, setElapsedSeconds] = useState(0);
  const [reviewFilter, setReviewFilter] = useState<'all' | 'incorrect' | 'flagged'>('all');
  const [isFullScreen, setIsFullScreen] = useState(false);

  // Timer: runs only once started and until submitted
  useEffect(() => {
    if (!isStarted || isSubmitted) return;
    const interval = setInterval(() => {
      setElapsedSeconds((s) => s + 1);
    }, 1000);
    return () => clearInterval(interval);
  }, [isStarted, isSubmitted]);

  const totalQuestions = questions ? questions.length : 0;
  const safeIndex = Math.max(0, Math.min(currentIndex, Math.max(0, totalQuestions - 1)));
  const currentQ = questions && questions[safeIndex] ? questions[safeIndex] : null;

  // Score statistics
  const scoreStats = useMemo(() => {
    if (!questions || questions.length === 0) {
      return { correct: 0, incorrect: 0, unanswered: 0, total: 0, percentage: 0, isPassed: false };
    }

    let correct = 0;
    let incorrect = 0;
    let unanswered = 0;

    questions.forEach((q, idx) => {
      if (!q) return;
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
      [safeIndex]: key,
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

  const toggleEliminate = (e: React.MouseEvent, key: string) => {
    e.stopPropagation();
    setEliminatedOptions((prev) => {
      const currentSet = new Set(prev[safeIndex] || []);
      if (currentSet.has(key)) {
        currentSet.delete(key);
      } else {
        currentSet.add(key);
      }
      return {
        ...prev,
        [safeIndex]: currentSet,
      };
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
    setEliminatedOptions({});
    setIsSubmitted(false);
    setCurrentIndex(0);
    setElapsedSeconds(0);
    setIsStarted(true);
  };

  if (!questions || questions.length === 0 || !currentQ) {
    return (
      <div style={{ textAlign: 'center', padding: '40px 20px', color: '#64748b' }}>
        <p>No questions currently available for this quiz.</p>
      </div>
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SCREEN 1: PRE-EXAM LOBBY / SETUP (Amboss / UWorld style)
  // ──────────────────────────────────────────────────────────────────────────
  if (!isStarted) {
    const estimatedMinutes = Math.max(5, Math.round(totalQuestions * 1.5));

    return (
      <div className="interactive-quiz-lobby" style={{ margin: '24px 0 40px' }}>
        <div
          style={{
            background: '#ffffff',
            borderRadius: '20px',
            border: '1px solid #dbe7f3',
            boxShadow: '0 12px 40px rgba(10, 35, 66, 0.08)',
            overflow: 'hidden',
          }}
        >
          {/* Header Banner */}
          <div
            style={{
              background: 'linear-gradient(135deg, #0a2342 0%, #0066cc 100%)',
              color: '#ffffff',
              padding: '40px 32px',
              textAlign: 'center',
              position: 'relative',
            }}
          >
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 6,
                background: 'rgba(255,255,255,0.18)',
                color: '#ffffff',
                padding: '5px 16px',
                borderRadius: '20px',
                fontSize: '.78rem',
                fontWeight: 800,
                textTransform: 'uppercase',
                letterSpacing: '.08em',
                marginBottom: 16,
              }}
            >
              <Award size={14} /> Royal College SBA Examination Simulation
            </span>

            <h1 style={{ fontSize: 'clamp(1.6rem, 3.5vw, 2.3rem)', fontWeight: 850, color: '#ffffff', margin: '0 0 12px', letterSpacing: '-0.02em' }}>
              {quizTitle}
            </h1>

            <p style={{ color: 'rgba(255,255,255,0.85)', fontSize: '1rem', margin: '0 auto', maxWidth: '620px', lineHeight: 1.6 }}>
              Practice single best answer (SBA) questions aligned with the Royal College curriculum. Choose your practice mode below to begin.
            </p>

            {/* Metrics Grid */}
            <div
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(130px, 1fr))',
                gap: 12,
                marginTop: 28,
                maxWidth: '680px',
                marginInline: 'auto',
              }}
            >
              {[
                { label: 'Total Questions', val: `${totalQuestions} Questions` },
                { label: 'Target Pass Mark', val: '70% Benchmark' },
                { label: 'Estimated Time', val: `~${estimatedMinutes} Minutes` },
                { label: 'Format', val: 'Single Best Answer' },
              ].map(({ label, val }) => (
                <div
                  key={label}
                  style={{
                    background: 'rgba(255,255,255,0.12)',
                    backdropFilter: 'blur(8px)',
                    borderRadius: '12px',
                    padding: '12px 14px',
                    border: '1px solid rgba(255,255,255,0.18)',
                  }}
                >
                  <div style={{ fontSize: '.72rem', textTransform: 'uppercase', letterSpacing: '.05em', color: 'rgba(255,255,255,0.75)', fontWeight: 700 }}>
                    {label}
                  </div>
                  <div style={{ fontSize: '1.05rem', fontWeight: 800, color: '#ffffff', marginTop: 4 }}>
                    {val}
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Mode Selection Section */}
          <div style={{ padding: '36px clamp(20px, 4vw, 40px)' }}>
            <h3 style={{ fontSize: '1.2rem', fontWeight: 800, color: '#0a2342', margin: '0 0 18px', textAlign: 'center' }}>
              Select Your Practice Mode:
            </h3>

            <div
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
                gap: 18,
                marginBottom: 32,
              }}
            >
              {/* Tutor Mode Card */}
              <div
                onClick={() => setMode('tutor')}
                style={{
                  border: mode === 'tutor' ? '2.5px solid #0066cc' : '1.5px solid #cbd5e1',
                  background: mode === 'tutor' ? '#f0f7ff' : '#ffffff',
                  borderRadius: '16px',
                  padding: '24px 22px',
                  cursor: 'pointer',
                  transition: 'all .2s ease',
                  position: 'relative',
                  boxShadow: mode === 'tutor' ? '0 8px 24px rgba(0, 102, 204, 0.12)' : 'none',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
                  <span
                    style={{
                      background: mode === 'tutor' ? '#0066cc' : '#e2e8f0',
                      color: mode === 'tutor' ? '#ffffff' : '#475569',
                      padding: '4px 12px',
                      borderRadius: '20px',
                      fontSize: '.75rem',
                      fontWeight: 800,
                      textTransform: 'uppercase',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 6,
                    }}
                  >
                    <BookOpen size={13} /> Recommended for Revision
                  </span>
                  <div
                    style={{
                      width: '20px',
                      height: '20px',
                      borderRadius: '50%',
                      border: mode === 'tutor' ? '6px solid #0066cc' : '2px solid #cbd5e1',
                      background: '#ffffff',
                    }}
                  />
                </div>

                <h4 style={{ fontSize: '1.25rem', fontWeight: 800, color: '#0a2342', margin: '0 0 8px' }}>
                  🎓 Tutor Mode
                </h4>
                <p style={{ fontSize: '.92rem', color: '#475569', margin: 0, lineHeight: 1.6 }}>
                  Immediate clinical rationales, explanation breakdowns, and high-yield examiner pearls appear right after selecting each answer.
                </p>
              </div>

              {/* Exam Mode Card */}
              <div
                onClick={() => setMode('exam')}
                style={{
                  border: mode === 'exam' ? '2.5px solid #0066cc' : '1.5px solid #cbd5e1',
                  background: mode === 'exam' ? '#f0f7ff' : '#ffffff',
                  borderRadius: '16px',
                  padding: '24px 22px',
                  cursor: 'pointer',
                  transition: 'all .2s ease',
                  position: 'relative',
                  boxShadow: mode === 'exam' ? '0 8px 24px rgba(0, 102, 204, 0.12)' : 'none',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
                  <span
                    style={{
                      background: mode === 'exam' ? '#0a2342' : '#e2e8f0',
                      color: mode === 'exam' ? '#ffffff' : '#475569',
                      padding: '4px 12px',
                      borderRadius: '20px',
                      fontSize: '.75rem',
                      fontWeight: 800,
                      textTransform: 'uppercase',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 6,
                    }}
                  >
                    <Timer size={13} /> Strict Exam Conditions
                  </span>
                  <div
                    style={{
                      width: '20px',
                      height: '20px',
                      borderRadius: '50%',
                      border: mode === 'exam' ? '6px solid #0066cc' : '2px solid #cbd5e1',
                      background: '#ffffff',
                    }}
                  />
                </div>

                <h4 style={{ fontSize: '1.25rem', fontWeight: 800, color: '#0a2342', margin: '0 0 8px' }}>
                  ⏱️ Timed Exam Mode
                </h4>
                <p style={{ fontSize: '.92rem', color: '#475569', margin: 0, lineHeight: 1.6 }}>
                  Timed Royal College simulation without immediate feedback. Full score analysis, percentage ranking, and question review are provided at the end.
                </p>
              </div>
            </div>

            {/* Launch Button */}
            <div style={{ textAlign: 'center' }}>
              <button
                type="button"
                onClick={() => setIsStarted(true)}
                style={{
                  background: 'linear-gradient(135deg, #0066cc 0%, #0a2342 100%)',
                  color: '#ffffff',
                  border: 'none',
                  padding: '16px 48px',
                  borderRadius: '14px',
                  fontSize: '1.1rem',
                  fontWeight: 850,
                  cursor: 'pointer',
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: 12,
                  boxShadow: '0 6px 20px rgba(0, 102, 204, 0.35)',
                  transition: 'transform .15s ease, box-shadow .15s ease',
                  letterSpacing: '-0.01em',
                }}
                onMouseOver={(e) => {
                  (e.currentTarget as HTMLButtonElement).style.transform = 'translateY(-2px)';
                  (e.currentTarget as HTMLButtonElement).style.boxShadow = '0 10px 28px rgba(0, 102, 204, 0.45)';
                }}
                onMouseOut={(e) => {
                  (e.currentTarget as HTMLButtonElement).style.transform = 'translateY(0)';
                  (e.currentTarget as HTMLButtonElement).style.boxShadow = '0 6px 20px rgba(0, 102, 204, 0.35)';
                }}
              >
                <PlayCircle size={24} />
                Begin Examination Now ({mode === 'tutor' ? 'Tutor Mode' : 'Exam Simulation'})
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Filtered review questions for results screen
  const filteredQuestions = questions
    .map((q, idx) => ({ q, idx }))
    .filter(({ q, idx }) => {
      if (!q) return false;
      if (reviewFilter === 'incorrect') {
        const sel = selectedAnswers[idx];
        return sel && sel !== q.correctKey;
      }
      if (reviewFilter === 'flagged') {
        return flaggedQuestions.has(idx);
      }
      return true;
    });

  // ──────────────────────────────────────────────────────────────────────────
  // SCREEN 2: SUBMITTED RESULTS SUMMARY VIEW
  // ──────────────────────────────────────────────────────────────────────────
  if (isSubmitted) {
    return (
      <div className="interactive-quiz-container" style={{ margin: '24px 0 50px' }}>
        <div
          style={{
            background: '#ffffff',
            borderRadius: '20px',
            border: '1px solid #dbe7f3',
            boxShadow: '0 12px 40px rgba(10, 35, 66, 0.08)',
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
              padding: '38px 28px',
              textAlign: 'center',
            }}
          >
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 6,
                background: 'rgba(255,255,255,0.2)',
                padding: '5px 16px',
                borderRadius: '20px',
                fontSize: '.78rem',
                fontWeight: 800,
                textTransform: 'uppercase',
                letterSpacing: '.08em',
                marginBottom: 14,
              }}
            >
              {scoreStats.isPassed ? <Award size={16} /> : <BookOpen size={16} />}
              MRCEM Examination Performance Report
            </span>

            <h2 style={{ fontSize: '2rem', fontWeight: 850, margin: '0 0 10px', color: '#fff' }}>
              {quizTitle}
            </h2>

            <p style={{ margin: 0, opacity: 0.9, fontSize: '1rem', maxWidth: '620px', marginInline: 'auto' }}>
              {scoreStats.isPassed
                ? 'Outstanding performance! Your score satisfies the Royal College pass standard (70%).'
                : 'Good attempt. Review the clinical explanations below to consolidate your high-yield knowledge.'}
            </p>

            {/* Score Ring / Circular Gauge */}
            <div
              style={{
                marginTop: 26,
                display: 'inline-flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                width: '140px',
                height: '140px',
                borderRadius: '50%',
                background: '#ffffff',
                color: scoreStats.isPassed ? '#047857' : '#0066cc',
                boxShadow: '0 8px 24px rgba(0,0,0,0.2)',
              }}
            >
              <span style={{ fontSize: '2.5rem', fontWeight: 900, lineHeight: 1 }}>
                {scoreStats.percentage}%
              </span>
              <span style={{ fontSize: '.74rem', fontWeight: 800, color: '#64748b', textTransform: 'uppercase', marginTop: 4 }}>
                {scoreStats.isPassed ? 'PASSED' : 'TARGET: 70%'}
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
              <div style={{ fontSize: '.76rem', color: '#64748b', fontWeight: 700, textTransform: 'uppercase' }}>
                Total Questions
              </div>
              <div style={{ fontSize: '1.45rem', fontWeight: 850, color: '#0f172a' }}>
                {scoreStats.total}
              </div>
            </div>

            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '.76rem', color: '#16a34a', fontWeight: 700, textTransform: 'uppercase' }}>
                Correct
              </div>
              <div style={{ fontSize: '1.45rem', fontWeight: 850, color: '#16a34a' }}>
                {scoreStats.correct}
              </div>
            </div>

            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '.76rem', color: '#dc2626', fontWeight: 700, textTransform: 'uppercase' }}>
                Incorrect
              </div>
              <div style={{ fontSize: '1.45rem', fontWeight: 850, color: '#dc2626' }}>
                {scoreStats.incorrect}
              </div>
            </div>

            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '.76rem', color: '#64748b', fontWeight: 700, textTransform: 'uppercase' }}>
                Time Elapsed
              </div>
              <div style={{ fontSize: '1.45rem', fontWeight: 850, color: '#0f172a' }}>
                {formatTime(elapsedSeconds)}
              </div>
            </div>
          </div>

          {/* Action & Filter Bar */}
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
                  padding: '7px 16px',
                  borderRadius: '20px',
                  fontSize: '.84rem',
                  fontWeight: 700,
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
                  padding: '7px 16px',
                  borderRadius: '20px',
                  fontSize: '.84rem',
                  fontWeight: 700,
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
                    padding: '7px 16px',
                    borderRadius: '20px',
                    fontSize: '.84rem',
                    fontWeight: 700,
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

            <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
              {onExitExam && (
                <button
                  type="button"
                  onClick={onExitExam}
                  className="btn btn-outline"
                  style={{ fontSize: '.84rem', display: 'inline-flex', alignItems: 'center', gap: 6 }}
                >
                  <ArrowLeft size={14} /> Back to Course
                </button>
              )}
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
          <div style={{ padding: '28px clamp(20px, 4vw, 36px)', display: 'grid', gap: 24 }}>
            {filteredQuestions.length === 0 ? (
              <div style={{ textAlign: 'center', padding: '40px 20px', color: '#64748b' }}>
                <CheckCircle2 size={40} color="#16a34a" style={{ margin: '0 auto 12px' }} />
                <h3>No questions in this filter</h3>
                <p>You answered all other questions accurately.</p>
              </div>
            ) : (
              filteredQuestions.map(({ q, idx }) => {
                const userChoice = selectedAnswers[idx];
                const isItemCorrect = userChoice === q.correctKey;
                const opts = q.options || [];

                return (
                  <article
                    key={q.id || `res-${idx}`}
                    style={{
                      border: '1.5px solid #e2e8f0',
                      borderRadius: '14px',
                      padding: '24px 26px',
                      background: '#ffffff',
                      boxShadow: '0 2px 8px rgba(0,0,0,0.02)',
                    }}
                  >
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
                      <span style={{ fontSize: '.8rem', fontWeight: 800, color: '#0066cc', textTransform: 'uppercase' }}>
                        Question {idx + 1} of {totalQuestions}
                      </span>
                      <span
                        style={{
                          fontSize: '.76rem',
                          fontWeight: 750,
                          padding: '4px 12px',
                          borderRadius: '14px',
                          background: isItemCorrect ? '#dcfce7' : '#fee2e2',
                          color: isItemCorrect ? '#15803d' : '#b91c1c',
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: 5,
                        }}
                      >
                        {isItemCorrect ? <Check size={14} /> : <X size={14} />}
                        {isItemCorrect ? 'Correct' : userChoice ? 'Incorrect' : 'Unanswered'}
                      </span>
                    </div>

                    <h4 style={{ fontSize: '1.08rem', color: '#0f172a', lineHeight: 1.6, margin: '0 0 18px', fontWeight: 650 }}>
                      {q.stem}
                    </h4>

                    {/* Options list */}
                    <div style={{ display: 'grid', gap: 10, marginBottom: 18 }}>
                      {opts.map((opt) => {
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
                              border: `2px solid ${border}`,
                              background: bg,
                              color,
                              padding: '12px 16px',
                              borderRadius: '10px',
                              display: 'flex',
                              alignItems: 'center',
                              justifyContent: 'space-between',
                              fontSize: '.92rem',
                            }}
                          >
                            <span style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                              <strong style={{ minWidth: '24px' }}>{opt.key}.</strong>
                              <span>{opt.text}</span>
                            </span>
                            {isRight && (
                              <span style={{ fontSize: '.75rem', fontWeight: 800, color: '#16a34a', textTransform: 'uppercase' }}>
                                Correct Answer
                              </span>
                            )}
                            {isChosen && !isRight && (
                              <span style={{ fontSize: '.75rem', fontWeight: 800, color: '#dc2626', textTransform: 'uppercase' }}>
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
                          border: '1.5px solid #cbd5e1',
                          borderRadius: '10px',
                          padding: '16px 18px',
                          fontSize: '.92rem',
                          color: '#334155',
                          lineHeight: 1.65,
                        }}
                      >
                        <strong style={{ display: 'flex', alignItems: 'center', gap: 6, color: '#0284c7', marginBottom: 8 }}>
                          <Sparkles size={16} /> Clinical Rationale & Teaching Points:
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

  // ──────────────────────────────────────────────────────────────────────────
  // SCREEN 3: ACTIVE EXAM / TEST SOLVER PLAYER (Interactive Amboss / UWorld UI)
  // ──────────────────────────────────────────────────────────────────────────
  const selectedKey = selectedAnswers[safeIndex];
  const isAnswered = selectedKey !== undefined;
  const isCurrentCorrect = selectedKey === currentQ.correctKey;
  const isFlagged = flaggedQuestions.has(safeIndex);
  const currentOptions = currentQ.options || [];
  const currentEliminated = eliminatedOptions[safeIndex] || new Set();

  return (
    <div
      className="interactive-quiz-container"
      style={
        isFullScreen
          ? {
              position: 'fixed',
              inset: 0,
              zIndex: 99999,
              background: '#f0f4f8',
              overflowY: 'auto',
              padding: '24px 16px 60px',
            }
          : { margin: '20px 0 45px' }
      }
    >
      <div
        style={{
          maxWidth: '960px',
          margin: '0 auto',
          background: '#ffffff',
          borderRadius: '20px',
          border: '1px solid #dbe7f3',
          boxShadow: '0 8px 30px rgba(10, 35, 66, 0.08)',
          overflow: 'hidden',
        }}
      >
        {/* Top Control Bar */}
        <div
          style={{
            background: 'linear-gradient(135deg, #0a2342 0%, #0d315d 100%)',
            color: '#ffffff',
            padding: '16px 24px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            gap: 16,
            flexWrap: 'wrap',
          }}
        >
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <span
              style={{
                background: '#0066cc',
                padding: '4px 12px',
                borderRadius: '8px',
                fontSize: '.76rem',
                fontWeight: 800,
                textTransform: 'uppercase',
                letterSpacing: '.06em',
              }}
            >
              MRCEM SBA
            </span>
            <span style={{ fontSize: '.96rem', fontWeight: 800, color: '#f1f5f9' }}>
              Question {safeIndex + 1} of {totalQuestions}
            </span>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: 12, flexWrap: 'wrap' }}>
            {/* Mode Switcher */}
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
                  padding: '4px 12px',
                  borderRadius: '16px',
                  cursor: 'pointer',
                  fontWeight: mode === 'tutor' ? 800 : 500,
                }}
                title="Immediate explanation after selecting an answer"
              >
                Tutor
              </button>
              <button
                type="button"
                onClick={() => setMode('exam')}
                style={{
                  border: 0,
                  background: mode === 'exam' ? '#0066cc' : 'transparent',
                  color: '#ffffff',
                  padding: '4px 12px',
                  borderRadius: '16px',
                  cursor: 'pointer',
                  fontWeight: mode === 'exam' ? 800 : 500,
                }}
                title="Exam simulation — calculate score at the end"
              >
                Exam
              </button>
            </div>

            {/* Timer */}
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 6,
                fontSize: '.85rem',
                color: '#93c5fd',
                fontWeight: 700,
                background: 'rgba(255,255,255,0.08)',
                padding: '4px 10px',
                borderRadius: '8px',
              }}
            >
              <Timer size={15} /> {formatTime(elapsedSeconds)}
            </span>

            {/* Flag question */}
            <button
              type="button"
              onClick={() => toggleFlag(safeIndex)}
              style={{
                border: 0,
                background: isFlagged ? '#f59e0b' : 'rgba(255,255,255,0.14)',
                color: '#ffffff',
                padding: '5px 12px',
                borderRadius: '8px',
                cursor: 'pointer',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 5,
                fontSize: '.8rem',
                fontWeight: 700,
                transition: 'background .15s ease',
              }}
              title="Flag this question for review"
            >
              <Flag size={13} fill={isFlagged ? '#ffffff' : 'none'} />
              {isFlagged ? 'Flagged' : 'Flag'}
            </button>

            {/* Full-screen Mode Toggle */}
            <button
              type="button"
              onClick={() => setIsFullScreen((fs) => !fs)}
              style={{
                border: 0,
                background: isFullScreen ? '#0066cc' : 'rgba(255,255,255,0.14)',
                color: '#ffffff',
                padding: '5px 12px',
                borderRadius: '8px',
                cursor: 'pointer',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 5,
                fontSize: '.8rem',
                fontWeight: 700,
                transition: 'background .15s ease',
              }}
              title={isFullScreen ? 'Exit Full Screen' : 'Full Screen Exam Hall Mode'}
            >
              {isFullScreen ? <Minimize2 size={13} /> : <Maximize2 size={13} />}
              {isFullScreen ? 'Exit Full Screen' : 'Full Screen'}
            </button>
          </div>
        </div>

        {/* Progress bar */}
        <div style={{ height: '5px', background: '#e2e8f0', width: '100%' }}>
          <div
            style={{
              height: '100%',
              background: 'linear-gradient(90deg, #0066cc 0%, #38bdf8 100%)',
              width: `${Math.round(((safeIndex + 1) / totalQuestions) * 100)}%`,
              transition: 'width .2s ease',
            }}
          />
        </div>

        {/* Question Area */}
        <div style={{ padding: '32px clamp(20px, 4vw, 42px)' }}>
          {/* Question Stem / Clinical Vignette */}
          <div
            style={{
              fontSize: '1.18rem',
              fontWeight: 650,
              color: '#0a2342',
              lineHeight: 1.7,
              marginBottom: 28,
              letterSpacing: '-0.01em',
            }}
          >
            {currentQ.stem}
          </div>

          {/* Options (A, B, C, D, E) */}
          <div style={{ display: 'grid', gap: 12, marginBottom: 28 }} role="radiogroup">
            {currentOptions.map((opt) => {
              const isSelected = selectedKey === opt.key;
              const isRight = opt.key === currentQ.correctKey;
              const showTutorResult = mode === 'tutor' && isAnswered;
              const isEliminated = currentEliminated.has(opt.key);

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
                <div
                  key={opt.key}
                  onClick={() => handleSelectOption(opt.key)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    gap: 14,
                    padding: '16px 20px',
                    borderRadius: '12px',
                    border: `2px solid ${borderColor}`,
                    background: bgColor,
                    cursor: 'pointer',
                    transition: 'all .15s ease',
                    userSelect: 'none',
                    opacity: isEliminated ? 0.45 : 1,
                    textDecoration: isEliminated ? 'line-through' : 'none',
                    boxShadow: isSelected ? '0 2px 10px rgba(0, 102, 204, 0.1)' : 'none',
                  }}
                  className="interactive-quiz-option"
                >
                  <span style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
                    {/* Option Letter Circle */}
                    <span
                      style={{
                        width: '32px',
                        height: '32px',
                        borderRadius: '50%',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        fontWeight: 850,
                        fontSize: '.88rem',
                        background: isSelected
                          ? showTutorResult
                            ? isRight
                              ? '#16a34a'
                              : '#dc2626'
                            : '#0066cc'
                          : '#f1f5f9',
                        color: isSelected ? '#ffffff' : '#475569',
                        flexShrink: 0,
                        border: isSelected ? 'none' : '1px solid #cbd5e1',
                      }}
                    >
                      {opt.key}
                    </span>

                    <span style={{ fontSize: '1.02rem', fontWeight: isSelected ? 750 : 500, color: textColor, lineHeight: 1.5 }}>
                      {opt.text}
                    </span>
                  </span>

                  <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                    {/* Elimination / Strikethrough Tool button */}
                    <button
                      type="button"
                      onClick={(e) => toggleEliminate(e, opt.key)}
                      style={{
                        border: '1px solid #cbd5e1',
                        background: isEliminated ? '#e2e8f0' : '#ffffff',
                        color: isEliminated ? '#dc2626' : '#94a3b8',
                        padding: '3px 8px',
                        borderRadius: '6px',
                        fontSize: '.72rem',
                        fontWeight: 700,
                        cursor: 'pointer',
                      }}
                      title="Eliminate (Strike through) this option"
                    >
                      <Strikethrough size={14} />
                    </button>

                    {showTutorResult && (
                      <span>
                        {isRight && <CheckCircle2 size={22} color="#16a34a" />}
                        {isSelected && !isRight && <XCircle size={22} color="#dc2626" />}
                      </span>
                    )}
                  </div>
                </div>
              );
            })}
          </div>

          {/* Immediate Tutor Feedback / Clinical Rationale */}
          {mode === 'tutor' && isAnswered && (
            <div
              style={{
                marginTop: 24,
                padding: '24px 26px',
                borderRadius: '14px',
                background: isCurrentCorrect ? '#f0fdf4' : '#fff7ed',
                border: isCurrentCorrect ? '1.5px solid #86efac' : '1.5px solid #fdba74',
                color: '#1f2937',
                boxShadow: '0 4px 16px rgba(0,0,0,0.04)',
              }}
            >
              <div
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: 10,
                  fontSize: '1.05rem',
                  fontWeight: 850,
                  color: isCurrentCorrect ? '#15803d' : '#c2410c',
                  marginBottom: 10,
                }}
              >
                {isCurrentCorrect ? <CheckCircle2 size={22} /> : <AlertCircle size={22} />}
                {isCurrentCorrect ? 'Correct Answer! Outstanding' : `Incorrect. The correct answer is Option ${currentQ.correctKey}`}
              </div>

              {currentQ.explanation && (
                <div style={{ fontSize: '.96rem', lineHeight: 1.7, marginTop: 10, color: '#334155' }}>
                  <strong style={{ display: 'flex', alignItems: 'center', gap: 6, color: '#0f172a', marginBottom: 6 }}>
                    <Sparkles size={16} color="#0284c7" /> Clinical Explanation & Key Learning Points:
                  </strong>
                  <div style={{ whiteSpace: 'pre-line', paddingLeft: 6 }}>{currentQ.explanation}</div>
                </div>
              )}
            </div>
          )}

          {/* Question Matrix & Jump Navigation */}
          <div
            style={{
              marginTop: 36,
              paddingTop: 26,
              borderTop: '1px solid #e2e8f0',
              display: 'flex',
              flexDirection: 'column',
              gap: 20,
            }}
          >
            {/* Quick jump circles */}
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, alignItems: 'center' }}>
              <span style={{ fontSize: '.8rem', fontWeight: 800, color: '#64748b', marginRight: 6, textTransform: 'uppercase' }}>
                Questions ({totalQuestions}):
              </span>
              {questions.slice(0, 45).map((_, i) => {
                const answered = selectedAnswers[i] !== undefined;
                const isCur = i === safeIndex;
                const flagged = flaggedQuestions.has(i);

                let bg = '#f8fafc';
                let col = '#475569';
                let border = '1.5px solid #cbd5e1';

                if (isCur) {
                  border = '2px solid #0066cc';
                  bg = '#eff6ff';
                  col = '#0066cc';
                } else if (answered) {
                  bg = '#0066cc';
                  col = '#ffffff';
                  border = '1.5px solid #0066cc';
                }

                return (
                  <button
                    key={i}
                    type="button"
                    onClick={() => setCurrentIndex(i)}
                    style={{
                      width: '34px',
                      height: '34px',
                      borderRadius: '10px',
                      border,
                      background: bg,
                      color: col,
                      fontWeight: 800,
                      fontSize: '.82rem',
                      cursor: 'pointer',
                      position: 'relative',
                      transition: 'transform .1s ease',
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
                          width: '9px',
                          height: '9px',
                          borderRadius: '50%',
                          background: '#f59e0b',
                          border: '1.5px solid #ffffff',
                        }}
                      />
                    )}
                  </button>
                );
              })}
              {totalQuestions > 45 && (
                <span style={{ fontSize: '.78rem', color: '#64748b', fontWeight: 700 }}>
                  +{totalQuestions - 45} more
                </span>
              )}
            </div>

            {/* Bottom Buttons: Prev, Next, Submit */}
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                flexWrap: 'wrap',
                gap: 14,
              }}
            >
              <button
                type="button"
                onClick={() => setCurrentIndex((c) => Math.max(0, c - 1))}
                disabled={safeIndex === 0}
                className="btn btn-outline"
                style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: 8,
                  opacity: safeIndex === 0 ? 0.4 : 1,
                  fontSize: '.9rem',
                  fontWeight: 700,
                }}
              >
                <ArrowLeft size={16} /> Previous Question
              </button>

              <div style={{ display: 'flex', gap: 12 }}>
                {safeIndex < totalQuestions - 1 ? (
                  <button
                    type="button"
                    onClick={() => setCurrentIndex((c) => Math.min(totalQuestions - 1, c + 1))}
                    className="btn btn-primary"
                    style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontSize: '.9rem', fontWeight: 800 }}
                  >
                    Next Question <ArrowRight size={16} />
                  </button>
                ) : (
                  <button
                    type="button"
                    onClick={handleFinishQuiz}
                    className="btn btn-primary"
                    style={{
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 8,
                      background: '#16a34a',
                      fontSize: '.95rem',
                      fontWeight: 850,
                      padding: '10px 22px',
                    }}
                  >
                    <CheckCircle2 size={18} /> Submit Exam & Calculate Score
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
