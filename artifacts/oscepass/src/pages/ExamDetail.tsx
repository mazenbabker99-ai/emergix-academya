import { useMemo } from 'react';
import { ArrowRight, BookOpen, CheckCircle2, Clock3, Download, ExternalLink, HelpCircle, MessageCircle, Play } from 'lucide-react';
import { Link, useParams } from 'wouter';
import { ApiError, useGetCourse, useGetExam } from '@workspace/api-client-react';
import { EmptyState, ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { PageHero } from '@/components/shared/PageHero';
import { Prose } from '@/components/shared/Prose';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { brand } from '@/config/brand';
import { DatesTable } from '@/features/exams/DatesTable';
import { ExamFacts } from '@/features/exams/ExamFacts';
import { FaqAccordion } from '@/features/exams/FaqAccordion';
import { formatBytes, formatDuration, formatLongDate } from '@/lib/format';
import { courseJsonLd, faqPageJsonLd } from '@/lib/schema';
import { useJsonLd, usePageMeta } from '@/lib/usePageMeta';
import NotFound from './not-found';

export default function ExamDetail() {
  const { slug = '' } = useParams<{ slug: string }>();
  const { data: exam, isLoading, error, refetch } = useGetExam(slug);
  const courseQuery = useGetCourse(slug);
  const notFound = error instanceof ApiError && error.status === 404;

  const course = courseQuery.data;
  const hasAccess = Boolean(course?.hasAccess);
  const lessonCount = course?.course?.lessonCount ?? (slug === 'mrcem-primary' ? 221 : slug === 'mrcem-sba' ? 47 : 0);
  const moduleCount = course?.modules?.length ?? (slug === 'mrcem-primary' ? 21 : slug === 'mrcem-sba' ? 5 : 0);

  usePageMeta(
    exam ? exam.name : 'Exam',
    exam ? `${exam.name}: ${exam.format}. Dates, fees, FAQs and preparation with ${brand.name}.` : `Exam information on ${brand.name}.`,
    { noindex: notFound },
  );
  const faqLd = useMemo(() => (exam && exam.faqs.length ? faqPageJsonLd(exam.faqs) : null), [exam]);
  const courseLd = useMemo(() => (exam ? courseJsonLd({ name: `${exam.name} preparation`, description: exam.summary, path: `/exams/${exam.slug}` }) : null), [exam]);
  useJsonLd('faq', faqLd);
  useJsonLd('course', courseLd);

  if (notFound) return <NotFound />;
  return <SiteLayout><main>
    {isLoading && <PageSkeleton label="Loading exam" />}
    {error && !notFound && <div className="container section"><ErrorState onRetry={() => void refetch()} /></div>}
    {exam && <>
      <PageHero eyebrow={exam.examType} title={exam.name} intro={exam.summary} />
      <section className="section" aria-labelledby="overview-heading"><div className="container exam-layout">
        <div>
          <h2 id="overview-heading">At a glance</h2>
          <ExamFacts exam={exam} />

          {/* Flagship Course Integration Card */}
          <div style={{ background: '#fff', border: '1.5px solid #dbe7f3', borderRadius: 14, padding: '24px 26px', margin: '28px 0', boxShadow: '0 8px 24px rgba(10,35,66,.04)' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: 12, marginBottom: 12 }}>
              <span className="eyebrow" style={{ margin: 0 }}>FLAGSHIP PREPARATION COURSE</span>
              {hasAccess && (
                <span style={{ background: '#e6f7ec', color: '#166534', border: '1px solid #bbf7d0', borderRadius: 20, padding: '3px 12px', fontSize: '.74rem', fontWeight: 750, display: 'inline-flex', alignItems: 'center', gap: 5 }}>
                  <CheckCircle2 size={14} /> Subscribed &amp; Unlocked
                </span>
              )}
            </div>
            <h3 style={{ fontSize: '1.45rem', color: 'var(--navy)', margin: '0 0 8px', letterSpacing: '-.03em' }}>
              {exam.name} Master Course
            </h3>
            <p style={{ color: '#586d84', fontSize: '.92rem', lineHeight: 1.65, margin: '0 0 16px' }}>
              Study {lessonCount} high-yield lessons structured across {moduleCount} system modules. Includes concise revision notes, clinical callouts, mnemonics, and topical single-best-answer practice.
            </p>
            <div style={{ display: 'flex', alignItems: 'center', gap: 20, flexWrap: 'wrap', color: '#62768c', fontSize: '.82rem', fontWeight: 600, marginBottom: 18 }}>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}>
                <BookOpen size={16} color="var(--blue)" /> {moduleCount} Modules
              </span>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}>
                <Clock3 size={16} color="var(--blue)" /> {lessonCount} Lessons
              </span>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}>
                <CheckCircle2 size={16} color="var(--blue)" /> 100% RCEM Aligned
              </span>
            </div>
            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
              <Link className="btn btn-primary" href={exam.slug === 'mrcem-sba' ? '/question-bank' : `/courses/${exam.slug}`}>
                {exam.slug === 'mrcem-sba' ? (
                  <><HelpCircle size={16} /> Open SBA Question Bank &amp; Mocks</>
                ) : hasAccess ? (
                  <><Play size={16} /> Open Course &amp; Continue Lessons</>
                ) : (
                  <><BookOpen size={16} /> View Curriculum &amp; Free Preview</>
                )} <ArrowRight size={15} />
              </Link>
              {!hasAccess && (
                <Link className="btn btn-light" href="/app/membership">
                  <MessageCircle size={15} /> Subscribe on WhatsApp
                </Link>
              )}
            </div>
          </div>

          {exam.sections.length > 0 && <>
            <h2>Structure</h2>
            <div className="table-wrap" role="region" aria-label="Exam structure" tabIndex={0}>
              <table className="data-table">
                <thead><tr><th scope="col">Part</th><th scope="col">Items</th><th scope="col">Time</th><th scope="col">Notes</th></tr></thead>
                <tbody>{exam.sections.map((s) => <tr key={s.name}>
                  <th scope="row">{s.name}</th>
                  <td>{s.itemCount ? `${s.itemCount} ${s.itemLabel}` : s.itemLabel}</td>
                  <td>{s.minutes ? formatDuration(s.minutes) : '—'}</td>
                  <td>{s.notes ?? '—'}</td>
                </tr>)}</tbody>
              </table>
            </div>
          </>}
          <Prose text={exam.content} className="exam-content" />
        </div>
        <aside className="exam-aside" aria-label="Next steps">
          <h2>Official Course Access</h2>

          {hasAccess ? (
            <div style={{ background: '#eef8f2', border: '1px solid #b7ebc9', borderRadius: 12, padding: '16px', marginBottom: 14 }}>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6, color: '#15803d', fontWeight: 800, fontSize: '.84rem', marginBottom: 6 }}>
                <CheckCircle2 size={17} /> Full Access Unlocked
              </span>
              <p style={{ color: '#2d6a4f', fontSize: '.82rem', margin: '0 0 12px', lineHeight: 1.5 }}>
                Your account has active full access. Start studying the {lessonCount} lessons and question banks now.
              </p>
              <Link className="btn btn-primary" style={{ width: '100%', justifyContent: 'center' }} href={`/courses/${exam.slug}`}>
                <Play size={16} /> Open Course ({lessonCount} Lessons) <ArrowRight size={15} />
              </Link>
            </div>
          ) : (
            <div style={{ display: 'grid', gap: 10, marginBottom: 14 }}>
              <Link className="btn btn-primary" href={`/courses/${exam.slug}`}>
                <BookOpen size={16} /> Explore Course ({lessonCount} Lessons) <ArrowRight size={16} />
              </Link>
              <Link className="btn btn-light" href="/app/membership">
                <MessageCircle size={15} /> Subscribe on WhatsApp <ArrowRight size={15} />
              </Link>
              <Link className="btn btn-ghost" href="/free-demo" style={{ border: '1px solid #dce8f5' }}>
                <CheckCircle2 size={15} /> Try Free Sample Questions
              </Link>
            </div>
          )}

          {exam.officialUrl && <a className="btn btn-light" href={exam.officialUrl} target="_blank" rel="noopener noreferrer">Official RCEM information <ExternalLink size={15} aria-hidden="true" /><span className="sr-only"> (opens in a new tab)</span></a>}
          {exam.lastReviewedAt && <p className="muted">Last reviewed {formatLongDate(exam.lastReviewedAt)}</p>}
        </aside>
      </div></section>

      {exam.dates.length > 0 && <section className="section compare-section" aria-labelledby="dates-heading"><div className="container">
        <div className="section-heading"><h2 id="dates-heading">Dates and fees</h2><p>Sample values until confirmed. See the <Link href="/calendar">full calendar</Link> and check the official site.</p></div>
        <DatesTable dates={exam.dates} showExam={false} />
      </div></section>}

      {exam.documents.length > 0 && <section className="section" aria-labelledby="docs-heading"><div className="container">
        <div className="section-heading"><h2 id="docs-heading">Documents</h2></div>
        <ul className="doc-list">{exam.documents.map((d) => <li key={d.id}>
          <a href={d.url} target="_blank" rel="noopener noreferrer"><Download size={18} aria-hidden="true" /><span><strong>{d.title}</strong>{d.description && <small>{d.description}</small>}</span>
            <span className="doc-meta">{d.fileType.toUpperCase()}{d.sizeBytes ? ` · ${formatBytes(d.sizeBytes)}` : ''}</span><span className="sr-only"> (opens in a new tab)</span></a>
        </li>)}</ul>
      </div></section>}

      {exam.faqs.length > 0 ? <section className="section compare-section" aria-labelledby="faq-heading"><div className="container faq-wrap">
        <div className="section-heading"><span className="eyebrow">Frequently asked questions</span><h2 id="faq-heading">About the {exam.shortName} exam</h2></div>
        <FaqAccordion faqs={exam.faqs} defaultOpenFirst />
      </div></section> : <div className="container section"><EmptyState title="No questions answered yet" /></div>}

      <section className="section"><div className="container note-panel">
        <p className="disclaimer">{brand.legalDisclaimer}</p>
      </div></section>
    </>}
  </main></SiteLayout>;
}
