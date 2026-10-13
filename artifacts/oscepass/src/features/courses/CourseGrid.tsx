import { useQuery } from '@tanstack/react-query';
import { ArrowRight, BookOpen, Clock3 } from 'lucide-react';
import { Link } from 'wouter';
import { EmptyState, ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { listCourses } from '@workspace/api-client-react';

export function CourseGrid() {
  const courses = useQuery({
    queryKey: ['public-courses'],
    queryFn: async ({ signal }) => {
      const pages: Awaited<ReturnType<typeof listCourses>>[] = [];
      let cursor: string | undefined;
      do {
        const page = await listCourses({ limit: 100, ...(cursor ? { cursor } : {}) }, { signal });
        pages.push(page);
        cursor = page.nextCursor ?? undefined;
      } while (cursor);
      return pages.flatMap((page) => page.data);
    },
  });

  if (courses.isLoading) return <PageSkeleton rows={3} label="Loading courses" />;
  if (courses.isError) {
    return <ErrorState title="We could not load the courses" onRetry={() => void courses.refetch()} />;
  }
  if (!courses.data?.length) {
    return <EmptyState title="Courses are coming soon" text="New courses will appear here as soon as they are published." />;
  }

  return (
    <div className="content-grid course-grid">
      {courses.data.map((course) => (
        <article className="content-card" key={course.id} data-testid={`course-card-${course.slug}`}>
          <span className="icon-tile"><BookOpen size={21} /></span>
          <p className="eyebrow course-card-label">{course.isFree ? 'Free course' : 'Premium course'}</p>
          <h3>{course.title}</h3>
          <p>{course.summary || 'Structured lessons and practice for your exam preparation.'}</p>
          <p className="course-card-meta"><Clock3 size={13} /> {course.lessonCount} lessons</p>
          <Link className="btn btn-light" href={`/courses/${course.slug}`}>
            Open course <ArrowRight size={15} />
          </Link>
        </article>
      ))}
    </div>
  );
}
