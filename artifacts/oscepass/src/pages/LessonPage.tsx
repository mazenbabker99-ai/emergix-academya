import { useMemo } from 'react';
import { ArrowLeft, ArrowRight, BookOpen, Clock3, Download, MessageCircle } from 'lucide-react';
import { Link, useParams } from 'wouter';
import { ApiError, useGetCourse, useGetLesson } from '@workspace/api-client-react';
import { ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { Prose } from '@/components/shared/Prose';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { InteractiveQuiz } from '@/components/quiz/InteractiveQuiz';
import { parseSbaQuestions } from '@/components/quiz/parseQuestions';
import { getLessonTopicQuiz } from '@/components/quiz/generateTopicQuiz';
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

  const topicQuizQuestions = useMemo(() => {
    if (hasInteractiveQuiz || !rawTitle) return [];
    return getLessonTopicQuiz(rawTitle, rawBody || '');
  }, [hasInteractiveQuiz, rawTitle, rawBody]);

  if (lesson.isLoading) {
    return <SiteLayout><main className="section"><div className="container"><PageSkeleton /></div></main></SiteLayout>;
  }
  if (lesson.isError || !lesson.data) {
    const forbidden = lesson.error instanceof ApiError && lesson.error.status === 403;
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
                      <MessageCircle size={16} /> View offers & Subscribe on WhatsApp <ArrowRight size={15} />
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

  return (
    <SiteLayout>
      <main className="section">
        <div className="container course-page" style={{ maxWidth: '860px', margin: '0 auto' }}>
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

          {/* If the lesson contains questions, render them interactively */}
          {hasInteractiveQuiz ? (
            <>
              {parsedQuiz.introText && (
                <div style={{ marginBottom: 24 }}>
                  <Prose text={parsedQuiz.introText} />
                </div>
              )}
              <InteractiveQuiz
                quizTitle={title}
                questions={parsedQuiz.questions}
                nextLessonHref={nextLesson ? `/courses/${slug}/lessons/${nextLesson.slug || nextLesson.id}` : undefined}
                nextLessonTitle={nextLesson?.title}
              />
            </>
          ) : (
            <>
              {body && <Prose text={body} />}
              {topicQuizQuestions.length > 0 && (
                <div style={{ marginTop: 44, paddingTop: 32, borderTop: '2px dashed #cbd5e1' }}>
                  <div style={{ marginBottom: 20 }}>
                    <span style={{ fontSize: '.78rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '0.08em', color: '#0066cc', background: '#eff6ff', padding: '4px 10px', borderRadius: 6, display: 'inline-block' }}>
                      Interactive Assessment
                    </span>
                    <h2 style={{ fontSize: '1.45rem', fontWeight: 800, color: '#0a2342', marginTop: 10, marginBottom: 6 }}>
                      Topic Knowledge Check: Single Best Answer Practice
                    </h2>
                    <p style={{ color: '#64748b', fontSize: '.92rem', margin: 0 }}>
                      Test your understanding of the clinical concepts covered in this lesson with these high-yield MRCEM single best answer questions.
                    </p>
                  </div>
                  <InteractiveQuiz
                    quizTitle={`Knowledge Check: ${title}`}
                    questions={topicQuizQuestions}
                    nextLessonHref={nextLesson ? `/courses/${slug}/lessons/${nextLesson.slug || nextLesson.id}` : undefined}
                    nextLessonTitle={nextLesson?.title}
                  />
                </div>
              )}
            </>
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
