import { ArrowLeft, FileAudio, FileText, Film, HelpCircle, Lock, Paperclip } from 'lucide-react';
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
            <p className="course-access-note">Sign in to open free previews. Other lessons require an active plan for the linked exam.</p>
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
                          <span className="course-locked">
                            <Lock size={16} />
                            <span>{lesson.title}</span>
                            <small>Locked</small>
                          </span>
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
