import { ArrowLeft, ArrowRight, BookOpen, CheckCircle2, ChevronRight, Clock3, FileAudio, FileText, Film, HelpCircle, Lock, MessageCircle, Paperclip, Play } from 'lucide-react';
import { Link, useParams } from 'wouter';
import { ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { Reveal } from '@/components/shared/Reveal';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { useGetCourse } from '@workspace/api-client-react';
import { usePageMeta } from '@/lib/usePageMeta';

const icons = {
  video: Film,
  audio: FileAudio,
  pdf: FileText,
  article: FileText,
  resource: Paperclip,
  quiz: HelpCircle,
} as const;

function minutes(seconds: number | null | undefined) {
  return seconds ? `${Math.max(1, Math.round(seconds / 60))} min` : '';
}

export default function CoursePage() {
  const { slug = '' } = useParams<{ slug: string }>();
  const course = useGetCourse(slug);
  usePageMeta(course.data?.course.title ?? 'Course', course.data?.course.summary || 'Course lessons and practice.');

  if (course.isLoading) {
    return <SiteLayout><main className="section"><div className="container"><PageSkeleton /></div></main></SiteLayout>;
  }
  if (course.isError || !course.data) {
    return (
      <SiteLayout>
        <main className="section">
          <div className="container">
            <ErrorState title="Course not found" onRetry={() => void course.refetch()} />
          </div>
        </main>
      </SiteLayout>
    );
  }

  const data = course.data;
  const allLessons = data.modules.flatMap((m) => m.lessons);
  const firstPreviewLesson = allLessons.find((l) => l.isFreePreview || data.hasAccess);

  return (
    <SiteLayout>
      <main>
        {/* Hero Section from OSCEPASS template */}
        <section className="neurology-hero">
          <div className="container">
            <Link
              href="/courses"
              className="course-back"
              style={{
                color: '#9acbff',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 6,
                marginBottom: 16,
                fontSize: '.84rem',
                textDecoration: 'none',
                fontWeight: 600,
              }}
            >
              <ArrowLeft size={15} /> All courses
            </Link>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, flexWrap: 'wrap', marginBottom: 10 }}>
              <span className="eyebrow" style={{ color: '#9bcaff', margin: 0 }}>
                {data.course.isFree ? 'FREE ACCESS' : 'PREMIUM COURSE'}
              </span>
              {allLessons.some((l) => l.isFreePreview) && (
                <span style={{ background: 'rgba(52, 168, 83, 0.25)', color: '#a8f5c4', border: '1px solid rgba(52, 168, 83, 0.4)', borderRadius: 20, padding: '2px 10px', fontSize: '.72rem', fontWeight: 700 }}>
                  Free preview available
                </span>
              )}
            </div>
            <h1>{data.course.title}</h1>
            {data.course.summary && <p>{data.course.summary}</p>}
            <div className="course-meta" style={{ marginTop: 20, display: 'flex', gap: 20, flexWrap: 'wrap', color: '#c5d6e8', fontSize: '.84rem' }}>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}><BookOpen size={16} /> {data.modules.length} {data.modules.length === 1 ? 'module' : 'modules'}</span>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}><Clock3 size={16} /> {allLessons.length} lessons</span>
              {data.hasAccess && <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6, color: '#68d391' }}><CheckCircle2 size={16} /> Full access unlocked</span>}
            </div>
          </div>
        </section>

        {/* Main Body Layout with Sidebar */}
        <section className="section" style={{ background: '#f3f8ff', padding: '48px 0 75px' }}>
          <div className="container neurology-layout">
            <div className="neurology-main">
              {/* WhatsApp Subscription CTA Banner when locked */}
              {!data.course.isFree && !data.hasAccess && (
                <div className="course-membership-banner" data-testid="course-membership-banner" style={{ marginBottom: 28 }}>
                  <div className="course-membership-content">
                    <span className="eyebrow">Full Course Access</span>
                    <h2>Subscribe to unlock all {allLessons.length} lessons</h2>
                    <p>
                      Get comprehensive structured lessons and high-yield notes. Arrange access directly with our team on WhatsApp for immediate activation.
                    </p>
                    <div className="course-membership-actions">
                      <Link href="/app/membership" className="btn btn-primary">
                        <MessageCircle size={16} /> View offers & Subscribe on WhatsApp <ArrowRight size={15} />
                      </Link>
                      {firstPreviewLesson && (
                        <Link href={`/courses/${data.course.slug}/lessons/${firstPreviewLesson.id}`} className="btn btn-outline">
                          <Play size={15} /> Start Free Preview Lesson
                        </Link>
                      )}
                    </div>
                  </div>
                </div>
              )}

              {data.description && (
                <div style={{ background: '#fff', border: '1px solid #dbe7f3', borderRadius: 12, padding: '22px 24px', marginBottom: 24, lineHeight: 1.7, color: '#4a5d72' }}>
                  <h3 style={{ color: 'var(--navy)', margin: '0 0 8px', fontSize: '1.15rem' }}>About this course</h3>
                  <p style={{ margin: 0 }}>{data.description}</p>
                </div>
              )}

              <Reveal>
                <div className="section-heading" style={{ marginBottom: 20 }}>
                  <span className="eyebrow">Curriculum</span>
                  <h2>Course Modules and Lessons</h2>
                  <p>Study lesson-by-lesson with clear clinical structure, mnemonics, and exam recall pearls.</p>
                </div>
              </Reveal>

              {data.modules.length === 0 ? (
                <p>Lessons will be added soon.</p>
              ) : (
                data.modules.map((module, index) => (
                  <details className="topic-card" key={module.id} open={index === 0}>
                    <summary style={{ fontSize: '1.02rem' }}>
                      <span style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                        <span style={{ color: 'var(--blue)', fontWeight: 800 }}>{String(index + 1).padStart(2, '0')}.</span>
                        <span>{module.title}</span>
                      </span>
                      <span style={{ color: '#62768c', fontSize: '.78rem', fontWeight: 600 }}>
                        {module.lessons.length} {module.lessons.length === 1 ? 'lesson' : 'lessons'}
                      </span>
                    </summary>
                    <div className="topic-card-body">
                      {module.lessons.length === 0 ? (
                        <p style={{ margin: 0, color: '#7a8c9e', fontStyle: 'italic' }}>No lessons in this section yet.</p>
                      ) : (
                        <ul style={{ listStyle: 'none', padding: 0, margin: '6px 0 0', display: 'grid', gap: 6 }}>
                          {module.lessons.map((lesson) => {
                            const Icon = icons[lesson.type] || FileText;
                            const open = data.hasAccess || lesson.isFreePreview;
                            return (
                              <li key={lesson.id} style={{ borderBottom: '1px solid #edf3f9', paddingBottom: 6 }}>
                                {open ? (
                                  <Link
                                    href={`/courses/${data.course.slug}/lessons/${lesson.id}`}
                                    style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 12, textDecoration: 'none', padding: '8px 10px', borderRadius: 8, transition: 'background .15s' }}
                                    className="lesson-interactive-row"
                                  >
                                    <span style={{ display: 'flex', alignItems: 'center', gap: 10, color: 'var(--navy)', fontWeight: 600, fontSize: '.92rem' }}>
                                      <Icon size={16} color="#0874d5" />
                                      <span>{lesson.title}</span>
                                    </span>
                                    <span style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                                      {lesson.isFreePreview && (
                                        <span style={{ background: '#e6f7ec', color: '#166534', border: '1px solid #bbf7d0', borderRadius: 12, padding: '2px 8px', fontSize: '.7rem', fontWeight: 700 }}>
                                          Free preview
                                        </span>
                                      )}
                                      {lesson.durationSeconds && (
                                        <small style={{ color: '#718497' }}>{minutes(lesson.durationSeconds)}</small>
                                      )}
                                      <ChevronRight size={14} color="#0874d5" />
                                    </span>
                                  </Link>
                                ) : (
                                  <Link
                                    href="/app/membership"
                                    style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 12, textDecoration: 'none', padding: '8px 10px', borderRadius: 8, opacity: 0.85 }}
                                    title="Subscribe to unlock this lesson"
                                  >
                                    <span style={{ display: 'flex', alignItems: 'center', gap: 10, color: '#687e95', fontSize: '.92rem' }}>
                                      <Lock size={15} color="#94a3b8" />
                                      <span>{lesson.title}</span>
                                    </span>
                                    <span style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                                      <span style={{ background: '#f1f5f9', color: '#475569', borderRadius: 12, padding: '2px 8px', fontSize: '.7rem', fontWeight: 600 }}>
                                        Locked
                                      </span>
                                    </span>
                                  </Link>
                                )}
                              </li>
                            );
                          })}
                        </ul>
                      )}
                    </div>
                  </details>
                ))
              )}
            </div>

            {/* Sticky Sidebar */}
            <aside className="neurology-side" style={{ top: 90 }}>
              <h3 style={{ display: 'flex', alignItems: 'center', gap: 8, margin: '0 0 8px' }}>
                <BookOpen size={17} color="var(--blue)" /> Course Outline
              </h3>
              <p style={{ color: '#697c90', fontSize: '.82rem', margin: '0 0 14px', lineHeight: 1.5 }}>
                {allLessons.length} lessons ready for your preparation.
              </p>
              <div style={{ maxHeight: 360, overflowY: 'auto', display: 'grid', gap: 2, paddingRight: 4, marginBottom: 16 }}>
                {allLessons.map((lesson) => {
                  const open = data.hasAccess || lesson.isFreePreview;
                  return (
                    <Link
                      key={lesson.id}
                      href={open ? `/courses/${data.course.slug}/lessons/${lesson.id}` : '/app/membership'}
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        gap: 8,
                        padding: '8px 6px',
                        borderBottom: '1px solid #edf2f8',
                        textDecoration: 'none',
                        color: open ? 'var(--navy)' : '#8396aa',
                        fontSize: '.8rem',
                        fontWeight: 600,
                      }}
                    >
                      <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                        {lesson.title}
                      </span>
                      {open ? <ChevronRight size={13} style={{ flex: 'none', color: '#0874d5' }} /> : <Lock size={12} style={{ flex: 'none', color: '#94a3b8' }} />}
                    </Link>
                  );
                })}
              </div>

              {!data.course.isFree && !data.hasAccess ? (
                <Link href="/app/membership" className="btn btn-primary" style={{ width: '100%', justifyContent: 'center' }}>
                  <MessageCircle size={15} /> Subscribe on WhatsApp
                </Link>
              ) : firstPreviewLesson ? (
                <Link href={`/courses/${data.course.slug}/lessons/${firstPreviewLesson.id}`} className="btn btn-primary" style={{ width: '100%', justifyContent: 'center' }}>
                  <Play size={15} /> Start Learning
                </Link>
              ) : null}

              <Link href="/courses" style={{ display: 'block', textAlign: 'center', color: '#0874d5', fontWeight: 700, border: 0, marginTop: 14, fontSize: '.82rem', textDecoration: 'none' }}>
                All Courses <ArrowRight size={13} style={{ verticalAlign: 'middle' }} />
              </Link>
            </aside>
          </div>
        </section>
      </main>
    </SiteLayout>
  );
}
