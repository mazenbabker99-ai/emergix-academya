import { ArrowLeft, ArrowRight, FileAudio, FileText, Film, HelpCircle, Lock, MessageCircle, Paperclip } from 'lucide-react';
import { Link, useParams } from 'wouter';
import { ErrorState, PageSkeleton } from '@/components/shared/DataState';
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
    return <SiteLayout><main className="section"><div className="container"><ErrorState title="Course not found" onRetry={() => void course.refetch()} /></div></main></SiteLayout>;
  }

  const data = course.data;
  return (
    <SiteLayout>
      <main className="section">
        <div className="container course-page">
          <Link href="/courses" className="course-back"><ArrowLeft size={15} /> All courses</Link>
          <span className="eyebrow">{data.course.isFree ? 'FREE COURSE' : 'PREMIUM COURSE'}</span>
          <h1>{data.course.title}</h1>
          {data.course.summary && <p className="shell-lead">{data.course.summary}</p>}
          {data.description && <p>{data.description}</p>}
          {!data.course.isFree && !data.hasAccess && (
            <div className="course-membership-banner" data-testid="course-membership-banner">
              <div className="course-membership-content">
                <span className="eyebrow">Premium Course</span>
                <h2>Subscribe to unlock this full course</h2>
                <p>
                  Access all structured lessons and clinical materials with our verified course offers. 
                  Arrange your subscription directly with our team on WhatsApp and get your access activated immediately.
                </p>
                <div className="course-membership-actions">
                  <Link href="/app/membership" className="btn btn-primary">
                    <MessageCircle size={16} /> View offers & Subscribe on WhatsApp <ArrowRight size={15} />
                  </Link>
                  <Link href="/courses" className="btn btn-outline">
                    Browse free courses
                  </Link>
                </div>
              </div>
            </div>
          )}
          {data.modules.length === 0 && <p>Lessons will be added soon.</p>}
          {data.modules.map((module, index) => (
            <section className="course-module" key={module.id}>
              <h2><span>{String(index + 1).padStart(2, '0')}</span> {module.title}</h2>
              {module.lessons.length === 0 ? <p>No published lessons in this section yet.</p> : (
                <ul>
                  {module.lessons.map((lesson) => {
                    const Icon = icons[lesson.type];
                    const open = data.hasAccess || lesson.isFreePreview;
                    return (
                      <li key={lesson.id}>
                        {open ? (
                          <Link href={`/courses/${data.course.slug}/lessons/${lesson.id}`}>
                            <Icon size={16} />
                            <span>{lesson.title}</span>
                            <small>{minutes(lesson.durationSeconds)}{lesson.isFreePreview && !data.hasAccess ? ' · Preview' : ''}</small>
                          </Link>
                        ) : (
                          <Link href="/app/membership" className="course-locked course-locked-link" title="Subscribe to unlock this lesson">
                            <Lock size={16} />
                            <span>{lesson.title}</span>
                            <small className="course-locked-badge">Locked · Subscribe to unlock</small>
                          </Link>
                        )}
                      </li>
                    );
                  })}
                </ul>
              )}
            </section>
          ))}
        </div>
      </main>
    </SiteLayout>
  );
}
