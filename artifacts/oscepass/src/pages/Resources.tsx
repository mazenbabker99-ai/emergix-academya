import { ArrowRight, BookOpen, ClipboardList, FileText, HelpCircle } from 'lucide-react';
import { Link } from 'wouter';
import { PageHero } from '@/components/shared/PageHero';
import { Reveal } from '@/components/shared/Reveal';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { usePageMeta } from '@/lib/usePageMeta';

export default function Resources() {
  usePageMeta('Study resources', 'High-yield study guides, SBA strategy, clinical guidelines and free demo questions for MRCEM Primary and SBA preparation.');
  const resources = [
    {
      icon: BookOpen,
      title: 'High-Yield Revision Notes',
      text: 'System-by-system summaries covering Anatomy, Physiology, Pathology, Pharmacology and Microbiology — distilled to exam-critical concepts with mnemonics and clinical callouts.',
      label: 'Revision material',
      href: '/courses/mrcem-primary',
    },
    {
      icon: ClipboardList,
      title: 'SBA Question Bank',
      text: '600+ single-best-answer questions with detailed explanations, previous exam recalls, and topical quizzes aligned to the RCEM curriculum.',
      label: 'Practice questions',
      href: '/app/qbank',
    },
    {
      icon: FileText,
      title: 'RCEM Clinical Guidelines',
      text: 'Links to official Royal College of Emergency Medicine guidelines, NICE evidence-based recommendations and key references examiners draw from.',
      label: 'Guidelines',
      href: '/exams',
    },
    {
      icon: HelpCircle,
      title: 'Free Demo Questions',
      text: 'Try 3 real MRCEM-style SBA questions with full explanations — no account required. A quick taste of the platform before you enroll.',
      label: 'Try free',
      href: '/free-demo',
    },
  ];

  return (
    <SiteLayout>
      <main>
        <PageHero
          eyebrow="Student resources"
          title="Everything you need to pass MRCEM."
          intro="High-yield notes, SBA question banks, clinical guidelines and free demo questions — structured around the official RCEM exam syllabus."
        />
        <section className="section">
          <div className="container">
            <div className="content-grid">
              {resources.map(({ icon: Icon, title, text, label, href }) => (
                <Reveal key={title}>
                  <article className="content-card">
                    <span className="icon-tile"><Icon size={21} /></span>
                    <p className="eyebrow" style={{ margin: '17px 0 0', fontSize: '.65rem' }}>{label}</p>
                    <h3>{title}</h3>
                    <p>{text}</p>
                    <Link className="btn btn-light" href={href}>
                      Browse resources <ArrowRight size={14} />
                    </Link>
                  </article>
                </Reveal>
              ))}
            </div>

            <div style={{ marginTop: 45, padding: '26px 28px', background: '#edf6ff', borderRadius: 13, display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 20, flexWrap: 'wrap' }}>
              <div>
                <span className="eyebrow">Start immediately</span>
                <h2 style={{ color: 'var(--navy)', margin: '11px 0 6px', fontSize: '1.5rem', letterSpacing: '-.04em' }}>
                  Try a free MRCEM SBA demo
                </h2>
                <p style={{ color: '#5c7086', margin: 0 }}>
                  3 high-yield SBA questions with full clinical explanations. No account needed.
                </p>
              </div>
              <Link className="btn btn-primary" href="/free-demo">
                Try free demo <ArrowRight size={15} />
              </Link>
            </div>
          </div>
        </section>
      </main>
    </SiteLayout>
  );
}
