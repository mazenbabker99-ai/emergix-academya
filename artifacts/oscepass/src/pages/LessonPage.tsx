import { ArrowLeft, Download } from 'lucide-react';
import { Link, useParams } from 'wouter';
import { ApiError, useGetLesson } from '@workspace/api-client-react';
import { ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { Prose } from '@/components/shared/Prose';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { usePageMeta } from '@/lib/usePageMeta';

export default function LessonPage() {
  const { slug = '', lessonId = '' } = useParams<{ slug: string; lessonId: string }>();
  const lesson = useGetLesson(slug, lessonId);
  usePageMeta(lesson.data?.title ?? 'Lesson', 'Course lesson.');
  const back = <Link href={`/courses/${slug}`} className="course-back"><ArrowLeft size={15} /> Back to course</Link>;

  if (lesson.isLoading) {
    return <SiteLayout><main className="section"><div className="container"><PageSkeleton /></div></main></SiteLayout>;
  }
  if (lesson.isError || !lesson.data) {
    const forbidden = lesson.error instanceof ApiError && lesson.error.status === 403;
    return (
      <SiteLayout>
        <main className="section">
          <div className="container course-page">
            {back}
            <ErrorState title={forbidden ? 'This lesson is not included in your plan' : 'We could not load this lesson'} onRetry={() => void lesson.refetch()} />
          </div>
        </main>
      </SiteLayout>
    );
  }

  const { title, type, body, chapters, captions } = lesson.data;
  const assetUrl = lesson.data.assetUrl ?? null;
  const mime = lesson.data.assetMimeType ?? '';
  const filename = lesson.data.assetFilename || 'lesson file';
  const isVideo = type === 'video' || mime.startsWith('video/');
  const isAudio = type === 'audio' || mime.startsWith('audio/');
  const isPdf = type === 'pdf' || mime === 'application/pdf';

  return (
    <SiteLayout>
      <main className="section">
        <div className="container course-page">
          {back}
          <span className="eyebrow">Course lesson</span>
          <h1>{title}</h1>
          {assetUrl && isVideo && (
            <video className="lesson-player" controls controlsList="nodownload" playsInline preload="metadata">
              <source src={assetUrl} type={mime || undefined} />
              {captions.map((caption, index) => (
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
          {body && <Prose text={body} />}
          {!assetUrl && !body && <p>Content for this lesson will be added soon.</p>}
          {chapters.length > 0 && (
            <section className="lesson-chapters" aria-label="Lesson chapters">
              <h2>Chapters</h2>
              <ul>{chapters.map((chapter, index) => <li key={`${chapter.at}-${index}`}>{chapter.title}</li>)}</ul>
            </section>
          )}
        </div>
      </main>
    </SiteLayout>
  );
}
