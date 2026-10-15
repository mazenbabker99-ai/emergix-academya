import { useQuery } from '@tanstack/react-query';
import { ArrowRight, BookOpen, Brain, Clock3, GraduationCap, HeartPulse, ShieldCheck, Stethoscope } from 'lucide-react';
import { Link } from 'wouter';
import { EmptyState, ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { listCourses } from '@workspace/api-client-react';

const coursePalettes = [
  { image: '/brand/t1.jpg', color: '#0A84FF', icon: Brain },
  { image: '/brand/t2.jpg', color: '#7C3AED', icon: Stethoscope },
  { image: '/brand/t3.jpg', color: '#16A34A', icon: BookOpen },
  { image: '/brand/t4.jpg', color: '#0D9488', icon: HeartPulse },
  { image: '/brand/t5.jpg', color: '#DB2777', icon: GraduationCap },
  { image: '/brand/t6.jpg', color: '#4F46E5', icon: ShieldCheck },
];

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

  // Filter out question bank and mock exam sets so only instructional lecture courses appear under Courses
  const lectureCourses = courses.data.filter(
    (course) => !course.slug.includes('sba') && !/quiz|mock|bank|paper/i.test(course.title)
  );

  const displayList = lectureCourses.length > 0 ? lectureCourses : courses.data;

  return (
    <>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(290px, 1fr))', gap: '22px' }}>
        {displayList.map((course, index) => {
          const palette = coursePalettes[index % coursePalettes.length];
          const Icon = palette.icon;
          return (
            <article className="module-card" key={course.id} data-testid={`course-card-${course.slug}`}>
              <Link href={`/courses/${course.slug}`} className="module-image-link" aria-label={`Explore ${course.title}`}>
                <img src={palette.image} alt={course.title} loading="lazy" />
                <span className="module-icon" style={{ backgroundColor: palette.color }}>
                  <Icon size={20} aria-hidden="true" />
                </span>
                <span style={{ position: 'absolute', top: 12, right: 12, background: 'rgba(10, 35, 66, 0.85)', backdropFilter: 'blur(6px)', color: '#fff', fontSize: '.7rem', fontWeight: 750, padding: '3px 10px', borderRadius: 20, letterSpacing: '.03em', textTransform: 'uppercase' }}>
                  {course.isFree ? 'Free' : 'Premium'}
                </span>
              </Link>
              <div className="module-content">
                <h3>{course.title}</h3>
                <p>{course.summary || 'Structured lessons and clinical practice for your exam preparation.'}</p>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginTop: 14, paddingTop: 12, borderTop: '1px solid #edf2f8' }}>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5, color: '#62768c', fontSize: '.76rem', fontWeight: 600 }}>
                    <Clock3 size={13} /> {course.lessonCount} {course.lessonCount === 1 ? 'lesson' : 'lessons'}
                  </span>
                  <Link className="module-more" href={`/courses/${course.slug}`}>
                    Explore Course <ArrowRight size={14} />
                  </Link>
                </div>
              </div>
            </article>
          );
        })}
      </div>

      {/* Prominent Question Bank Spotlight Banner */}
      <div
        style={{
          marginTop: 36,
          background: 'linear-gradient(135deg, #0a2342 0%, #004d99 100%)',
          borderRadius: 16,
          padding: '28px 32px',
          color: '#ffffff',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          gap: 20,
          boxShadow: '0 10px 25px rgba(10, 35, 66, 0.12)',
        }}
      >
        <div>
          <span style={{ fontSize: '.76rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '.08em', color: '#93c5fd' }}>
            Dedicated Question Bank &amp; Mock Exams
          </span>
          <h3 style={{ fontSize: '1.4rem', fontWeight: 800, margin: '6px 0', color: '#ffffff' }}>
            Looking for MRCEM SBA Quizzes &amp; Timed Mocks?
          </h3>
          <p style={{ margin: 0, color: '#e0e7ff', fontSize: '.92rem', maxWidth: '620px', lineHeight: 1.5 }}>
            All 41 topical single-best-answer quizzes and 6 full mock exam papers are in our dedicated Question Bank section with instant clinical explanations.
          </p>
        </div>
        <Link href="/question-bank" className="btn btn-primary" style={{ background: '#ffffff', color: '#0a2342', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: 8 }}>
          Go to Question Bank <ArrowRight size={15} />
        </Link>
      </div>
    </>
  );
}
