import { useMemo, useState } from 'react';
import { ArrowLeft, ArrowRight, BookOpen, Clock3, Download, FileText, MessageCircle, PlayCircle } from 'lucide-react';
import { Link, useParams } from 'wouter';
import { ApiError, useGetCourse, useGetLesson } from '@workspace/api-client-react';
import { ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { Prose } from '@/components/shared/Prose';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { InteractiveQuiz } from '@/components/quiz/InteractiveQuiz';
import { parseSbaQuestions } from '@/components/quiz/parseQuestions';
import { usePageMeta } from '@/lib/usePageMeta';

export default function LessonPage() {
  const { slug = '', lessonId = '' } = useParams<{ slug: string; lessonId: string }>();
  const lesson = useGetLesson(slug, lessonId);
  const course = useGetCourse(slug);
  usePageMeta(lesson.data?.title ?? 'Lesson', 'Course lesson.');
  const back = <Link href={`/courses/${slug}`} className="course-back"><ArrowLeft size={15} /> Back to course</Link>;

  const allLessons = course.data?.modules.flatMap((m) => m.lessons) ?? [];
  const currentIndex = allLessons.findIndex((l) => l.id === lessonId || l.slug === lessonId);
  const prevLesson = currentIndex > 0 ? allLessons[currentIndex - 1] : null;
  const nextLesson = currentIndex >= 0 && currentIndex < allLessons.length - 1 ? allLessons[currentIndex + 1] : null;

  const lessonData = lesson.data;
  const rawBody = lessonData?.body;
  const rawTitle = lessonData?.title;

  const parsedQuiz = useMemo(() => {
    if (!rawBody) return { introText: '', questions: [] };
    return parseSbaQuestions(rawBody);
  }, [rawBody]);

  const hasInteractiveQuiz = parsedQuiz.questions.length > 0;

  // Controls whether the full-screen exam overlay is open
  const [examOpen, setExamOpen] = useState(false);
  const [readerFontSize, setReaderFontSize] = useState<'normal' | 'large' | 'xlarge'>('normal');

  const readingTime = useMemo(() => {
    if (!rawBody) return 2;
    const words = rawBody.split(/\s+/).filter(Boolean).length;
    return Math.max(1, Math.ceil(words / 170));
  }, [rawBody]);

  if (lesson.isLoading) {
    return <SiteLayout><main className="section"><div className="container"><PageSkeleton /></div></main></SiteLayout>;
  }
  if (lesson.isError || !lesson.data) {
    const forbidden = lesson.error instanceof ApiError && (lesson.error.status === 403 || lesson.error.status === 401);
    if (forbidden) {
      return (
        <SiteLayout>
          <main className="section">
            <div className="container course-page">
              {back}
              <div className="course-membership-banner forbidden-lesson-banner" role="alert">
                <div className="course-membership-content">
                  <span className="eyebrow">Access required</span>
                  <h2>This lesson requires an active course subscription</h2>
                  <p>
                    This lesson is part of a premium Emergix Academy course. Subscribe via WhatsApp to have your account activated by our team.
                  </p>
                  <div className="course-membership-actions">
                    <Link href="/app/membership" className="btn btn-primary">
                      <MessageCircle size={16} /> View offers &amp; Subscribe on WhatsApp <ArrowRight size={15} />
                    </Link>
                    <Link href={`/courses/${slug}`} className="btn btn-outline">
                      Back to course overview
                    </Link>
                  </div>
                </div>
              </div>
            </div>
          </main>
        </SiteLayout>
      );
    }
    return (
      <SiteLayout>
        <main className="section">
          <div className="container course-page">
            {back}
            <ErrorState title="We could not load this lesson" onRetry={() => void lesson.refetch()} />
          </div>
        </main>
      </SiteLayout>
    );
  }

  const { title, type, body, chapters, captions } = lesson.data;
  const captionsList = Array.isArray(captions) ? captions : [];
  const chaptersList = Array.isArray(chapters) ? chapters : [];
  const assetUrl = lesson.data.assetUrl ?? null;
  const mime = lesson.data.assetMimeType ?? '';
  const filename = lesson.data.assetFilename || 'lesson file';
  const isVideo = type === 'video' || mime.startsWith('video/');
  const isAudio = type === 'audio' || mime.startsWith('audio/');
  const isPdf = type === 'pdf' || mime === 'application/pdf';

  const isQuiz = type === 'quiz' || hasInteractiveQuiz || /quiz|mock|sba|paper|test/i.test(title);

  // Dedicated quiz check: quiz type, mrcem-sba course, quiz slug/title, or 3+ parsed questions
  const isDedicatedQuiz =
    hasInteractiveQuiz &&
    (type === 'quiz' ||
      slug === 'mrcem-sba' ||
      /quiz|mock|sba|paper|exam|test/i.test(`${lessonId} ${slug} ${lessonData?.slug || ''}`) ||
      /quiz|mock|sba|paper|exam|test/i.test(title || '') ||
      parsedQuiz.questions.length >= 3);

  // ─── Dedicated Quiz View (Direct Amboss / UWorld interactive test player) ───
  if (isDedicatedQuiz) {
    return (
      <SiteLayout>
        <main className="section" style={{ minHeight: '80vh', padding: '24px 0 60px' }}>
          <div className="container course-page" style={{ maxWidth: '980px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 20 }}>
              {back}
              {allLessons.length > 0 && currentIndex >= 0 && (
                <span
                  style={{
                    fontSize: '.82rem',
                    fontWeight: 700,
                    color: '#64748b',
                    background: '#f1f5f9',
                    padding: '4px 14px',
                    borderRadius: 20,
                  }}
                >
                  Quiz {currentIndex + 1} of {allLessons.length}
                </span>
              )}
            </div>

            {parsedQuiz.introText && (
              <div
                style={{
                  marginBottom: 20,
                  background: '#ffffff',
                  borderRadius: '14px',
                  padding: '18px 22px',
                  border: '1px solid #dbe7f3',
                  boxShadow: '0 2px 8px rgba(10,35,66,0.03)',
                }}
              >
                <Prose text={parsedQuiz.introText} />
              </div>
            )}

            <InteractiveQuiz
              quizTitle={title}
              questions={parsedQuiz.questions}
              nextLessonHref={nextLesson ? `/courses/${slug}/lessons/${nextLesson.slug || nextLesson.id}` : undefined}
              nextLessonTitle={nextLesson?.title}
            />

            {/* Navigation Footer */}
            <div
              className="lesson-nav-footer"
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                marginTop: 48,
                paddingTop: 24,
                borderTop: '1px solid #e2e8f0',
                gap: 16,
                flexWrap: 'wrap',
              }}
            >
              {prevLesson ? (
                <Link
                  href={`/courses/${slug}/lessons/${prevLesson.slug || prevLesson.id}`}
                  className="btn btn-outline"
                  style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontSize: '.88rem' }}
                >
                  <ArrowLeft size={16} /> Previous: {prevLesson.title}
                </Link>
              ) : <div />}

              {nextLesson ? (
                <Link
                  href={`/courses/${slug}/lessons/${nextLesson.slug || nextLesson.id}`}
                  className="btn btn-primary"
                  style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontSize: '.88rem' }}
                >
                  Next: {nextLesson.title} <ArrowRight size={16} />
                </Link>
              ) : (
                <Link
                  href={`/courses/${slug}`}
                  className="btn btn-primary"
                  style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontSize: '.88rem' }}
                >
                  Back to Course Overview <ArrowRight size={16} />
                </Link>
              )}
            </div>
          </div>
        </main>
      </SiteLayout>
    );
  }

  // ─── Full-screen Exam Overlay (for lecture knowledge checks) ─────────────────
  if (examOpen && hasInteractiveQuiz) {
    return (
      <div
        style={{
          position: 'fixed',
          inset: 0,
          zIndex: 9999,
          background: '#f0f4f8',
          overflowY: 'auto',
          display: 'flex',
          flexDirection: 'column',
        }}
      >
        {/* Overlay Top Bar */}
        <div
          style={{
            background: '#0a2342',
            color: '#fff',
            padding: '12px 24px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            gap: 16,
            flexShrink: 0,
            boxShadow: '0 2px 12px rgba(0,0,0,0.25)',
          }}
        >
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <span
              style={{
                background: '#0066cc',
                padding: '3px 10px',
                borderRadius: '6px',
                fontSize: '.72rem',
                fontWeight: 800,
                textTransform: 'uppercase',
                letterSpacing: '.06em',
              }}
            >
              MRCEM SBA
            </span>
            <span style={{ fontSize: '.94rem', fontWeight: 700, color: '#e2e8f0', maxWidth: 420, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
              {title}
            </span>
          </div>
          <button
            type="button"
            onClick={() => setExamOpen(false)}
            style={{
              background: 'rgba(255,255,255,0.12)',
              border: '1px solid rgba(255,255,255,0.25)',
              color: '#fff',
              padding: '6px 16px',
              borderRadius: '8px',
              cursor: 'pointer',
              fontSize: '.82rem',
              fontWeight: 700,
              display: 'inline-flex',
              alignItems: 'center',
              gap: 6,
            }}
          >
            <ArrowLeft size={14} /> Exit Exam
          </button>
        </div>

        {/* Quiz Content */}
        <div style={{ flex: 1, maxWidth: '880px', width: '100%', margin: '0 auto', padding: '24px 20px 60px' }}>
          {parsedQuiz.introText && (
            <div style={{ marginBottom: 24, background: '#fff', borderRadius: '12px', padding: '20px 24px', border: '1px solid #dbe7f3' }}>
              <Prose text={parsedQuiz.introText} />
            </div>
          )}
          <InteractiveQuiz
            quizTitle={title}
            questions={parsedQuiz.questions}
            nextLessonHref={nextLesson ? `/courses/${slug}/lessons/${nextLesson.slug || nextLesson.id}` : undefined}
            nextLessonTitle={nextLesson?.title}
            onExitExam={() => setExamOpen(false)}
          />
        </div>
      </div>
    );
  }

  // ─── Normal Lesson View ────────────────────────────────────────────────────
  return (
    <SiteLayout>
      <main className="section">
        <div className="container course-page" style={{ maxWidth: '920px', margin: '0 auto' }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 20 }}>
            {back}
            {allLessons.length > 0 && currentIndex >= 0 && (
              <span style={{ fontSize: '.82rem', fontWeight: 700, color: '#64748b', background: '#f1f5f9', padding: '4px 12px', borderRadius: 20 }}>
                {isQuiz ? 'Quiz' : 'Lesson'} {currentIndex + 1} of {allLessons.length}
              </span>
            )}
          </div>

          <span className="eyebrow">{isQuiz ? 'MRCEM SBA Practice & Quiz Simulation' : 'MRCEM Primary Preparation'}</span>
          <h1 style={{ fontSize: '2.1rem', fontWeight: 850, letterSpacing: '-0.02em', color: '#0a2342', marginBottom: '1.2rem' }}>
            {title}
          </h1>

          {assetUrl && isVideo && (
            <video className="lesson-player" controls controlsList="nodownload" playsInline preload="metadata">
              <source src={assetUrl} type={mime || undefined} />
              {captionsList.map((caption, index) => (
                <track key={`${caption.lang}-${index}`} kind="captions" src={caption.url} srcLang={caption.lang} label={caption.lang} default={index === 0} />
              ))}
              Your browser does not support embedded video.
            </video>
          )}
          {assetUrl && isAudio && <audio className="lesson-audio" controls preload="metadata" src={assetUrl} />}
          {assetUrl && isPdf && <iframe className="lesson-pdf" title={title} src={assetUrl} />}
          {assetUrl && !isVideo && !isAudio && !isPdf && (
            <p><a className="btn btn-light" href={assetUrl} target="_blank" rel="noopener noreferrer"><Download size={15} /> Open {filename}</a></p>
          )}

          {/* Lesson body content inside an elegant medical textbook reader card */}
          {body && (
            <article
              className="lesson-reader-paper"
              style={{
                background: '#ffffff',
                borderRadius: '20px',
                border: '1px solid #e2e8f0',
                boxShadow: '0 4px 30px rgba(10, 35, 66, 0.05)',
                padding: 'clamp(24px, 5vw, 48px)',
                marginTop: '24px',
              }}
            >
              {/* Reader Header Toolbar */}
              <div
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  flexWrap: 'wrap',
                  gap: '12px',
                  paddingBottom: '20px',
                  marginBottom: '26px',
                  borderBottom: '1px solid #edf2f7',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                  <span
                    style={{
                      background: '#eff6ff',
                      color: '#0066cc',
                      fontSize: '.78rem',
                      fontWeight: 800,
                      textTransform: 'uppercase',
                      letterSpacing: '.06em',
                      padding: '4px 12px',
                      borderRadius: '20px',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: '6px',
                    }}
                  >
                    <BookOpen size={13} /> Curriculum Notes
                  </span>
                  <span style={{ fontSize: '.84rem', color: '#64748b', fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: '4px' }}>
                    <Clock3 size={13} /> ~{readingTime} min read
                  </span>
                </div>

                {/* Font Size Toggle Buttons */}
                <div
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '4px',
                    background: '#f1f5f9',
                    padding: '3px',
                    borderRadius: '10px',
                  }}
                >
                  <span style={{ fontSize: '.72rem', fontWeight: 700, color: '#64748b', padding: '0 8px', textTransform: 'uppercase' }}>
                    Font Size:
                  </span>
                  <button
                    type="button"
                    onClick={() => setReaderFontSize('normal')}
                    style={{
                      border: 0,
                      background: readerFontSize === 'normal' ? '#ffffff' : 'transparent',
                      color: readerFontSize === 'normal' ? '#0066cc' : '#64748b',
                      boxShadow: readerFontSize === 'normal' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none',
                      padding: '3px 10px',
                      borderRadius: '6px',
                      fontSize: '.82rem',
                      fontWeight: 700,
                      cursor: 'pointer',
                    }}
                    title="Standard Text (18px)"
                  >
                    A
                  </button>
                  <button
                    type="button"
                    onClick={() => setReaderFontSize('large')}
                    style={{
                      border: 0,
                      background: readerFontSize === 'large' ? '#ffffff' : 'transparent',
                      color: readerFontSize === 'large' ? '#0066cc' : '#64748b',
                      boxShadow: readerFontSize === 'large' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none',
                      padding: '3px 10px',
                      borderRadius: '6px',
                      fontSize: '.9rem',
                      fontWeight: 800,
                      cursor: 'pointer',
                    }}
                    title="Large Text (20px)"
                  >
                    A+
                  </button>
                  <button
                    type="button"
                    onClick={() => setReaderFontSize('xlarge')}
                    style={{
                      border: 0,
                      background: readerFontSize === 'xlarge' ? '#ffffff' : 'transparent',
                      color: readerFontSize === 'xlarge' ? '#0066cc' : '#64748b',
                      boxShadow: readerFontSize === 'xlarge' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none',
                      padding: '3px 10px',
                      borderRadius: '6px',
                      fontSize: '.98rem',
                      fontWeight: 900,
                      cursor: 'pointer',
                    }}
                    title="Extra Large Text (22px)"
                  >
                    A++
                  </button>
                </div>
              </div>

              {/* Rendered Clinical Text */}
              <Prose
                text={hasInteractiveQuiz && parsedQuiz.introText && parsedQuiz.introText.length > 50 ? parsedQuiz.introText : body}
                fontSize={readerFontSize}
              />
            </article>
          )}

          {/* Quiz Launch Card — shown after lesson content if quiz questions exist */}
          {hasInteractiveQuiz && (
            <div
              style={{
                marginTop: 52,
                background: 'linear-gradient(135deg, #0a2342 0%, #0066cc 100%)',
                borderRadius: '16px',
                padding: '36px 32px',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                textAlign: 'center',
                gap: 20,
                boxShadow: '0 12px 40px rgba(0, 102, 204, 0.22)',
              }}
            >
              {/* Badge */}
              <span
                style={{
                  background: 'rgba(255,255,255,0.18)',
                  color: '#fff',
                  fontSize: '.72rem',
                  fontWeight: 800,
                  textTransform: 'uppercase',
                  letterSpacing: '.1em',
                  padding: '4px 14px',
                  borderRadius: '20px',
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: 6,
                }}
              >
                <FileText size={13} /> Topic Knowledge Check
              </span>

              <div>
                <h2 style={{ fontSize: '1.55rem', fontWeight: 800, color: '#fff', margin: '0 0 8px', letterSpacing: '-0.02em' }}>
                  Single Best Answer Practice
                </h2>
                <p style={{ color: 'rgba(255,255,255,0.8)', fontSize: '.94rem', margin: 0, maxWidth: '520px' }}>
                  Test your understanding of <strong style={{ color: '#fff' }}>{title}</strong> with{' '}
                  {parsedQuiz.questions.length} high-yield MRCEM SBA question
                  {parsedQuiz.questions.length !== 1 ? 's' : ''}. Includes full clinical explanations and score analysis.
                </p>
              </div>

              {/* Stats row */}
              <div style={{ display: 'flex', gap: 28, flexWrap: 'wrap', justifyContent: 'center' }}>
                {[
                  { icon: <BookOpen size={16} />, label: `${parsedQuiz.questions.length} Questions` },
                  { icon: <Clock3 size={16} />, label: 'Tutor & Exam Mode' },
                ].map(({ icon, label }) => (
                  <span
                    key={label}
                    style={{
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 6,
                      color: 'rgba(255,255,255,0.85)',
                      fontSize: '.86rem',
                      fontWeight: 600,
                    }}
                  >
                    {icon} {label}
                  </span>
                ))}
              </div>

              {/* Launch Button */}
              <button
                type="button"
                onClick={() => setExamOpen(true)}
                style={{
                  background: '#ffffff',
                  color: '#0066cc',
                  border: 'none',
                  padding: '14px 36px',
                  borderRadius: '12px',
                  fontSize: '1rem',
                  fontWeight: 800,
                  cursor: 'pointer',
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: 10,
                  boxShadow: '0 4px 16px rgba(0,0,0,0.18)',
                  transition: 'transform .15s ease, box-shadow .15s ease',
                  letterSpacing: '-0.01em',
                }}
                onMouseOver={(e) => {
                  (e.currentTarget as HTMLButtonElement).style.transform = 'translateY(-2px)';
                  (e.currentTarget as HTMLButtonElement).style.boxShadow = '0 8px 24px rgba(0,0,0,0.22)';
                }}
                onMouseOut={(e) => {
                  (e.currentTarget as HTMLButtonElement).style.transform = 'translateY(0)';
                  (e.currentTarget as HTMLButtonElement).style.boxShadow = '0 4px 16px rgba(0,0,0,0.18)';
                }}
              >
                <PlayCircle size={20} />
                Start Exam
              </button>
            </div>
          )}

          {!assetUrl && !body && <p>Content for this lesson will be added soon.</p>}

          {chaptersList.length > 0 && (
            <section className="lesson-chapters" aria-label="Lesson chapters">
              <h2>Chapters</h2>
              <ul>{chaptersList.map((chapter, index) => <li key={`${chapter.at}-${index}`}>{chapter.title}</li>)}</ul>
            </section>
          )}

          {/* Navigation Footer */}
          <div
            className="lesson-nav-footer"
            style={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              marginTop: 48,
              paddingTop: 24,
              borderTop: '1px solid #e2e8f0',
              gap: 16,
              flexWrap: 'wrap',
            }}
          >
            {prevLesson ? (
              <Link
                href={`/courses/${slug}/lessons/${prevLesson.slug || prevLesson.id}`}
                className="btn btn-outline"
                style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontSize: '.88rem' }}
              >
                <ArrowLeft size={16} /> Previous: {prevLesson.title}
              </Link>
            ) : <div />}

            {nextLesson ? (
              <Link
                href={`/courses/${slug}/lessons/${nextLesson.slug || nextLesson.id}`}
                className="btn btn-primary"
                style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontSize: '.88rem' }}
              >
                Next: {nextLesson.title} <ArrowRight size={16} />
              </Link>
            ) : (
              <Link
                href={`/courses/${slug}`}
                className="btn btn-primary"
                style={{ display: 'inline-flex', alignItems: 'center', gap: 8, fontSize: '.88rem' }}
              >
                Back to Course Overview <ArrowRight size={16} />
              </Link>
            )}
          </div>
        </div>
      </main>
    </SiteLayout>
  );
}
