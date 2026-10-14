import { ArrowRight, CheckCircle2, MessageCircle } from 'lucide-react';
import { Link } from 'wouter';
import { PageHero } from '@/components/shared/PageHero';
import { Reveal } from '@/components/shared/Reveal';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { brand } from '@/config/brand';
import { usePageMeta } from '@/lib/usePageMeta';

export default function About() {
  usePageMeta(`About ${brand.name}`, `Learn about ${brand.name} and our mission to help Emergency Medicine physicians pass MRCEM Primary and SBA on their first attempt.`);
  return (
    <SiteLayout>
      <main>
        <PageHero
          eyebrow={`About ${brand.name}`}
          title="Helping Emergency Medicine Physicians to Succeed."
          intro={`${brand.name} delivers high-yield revision notes, topical SBA question banks, and authentic mock simulations to help candidates pass their Royal College exams.`}
        />
        <section className="section">
          <div className="container quote-layout">
            <Reveal>
              <div>
                <span className="eyebrow">The Emergix Methodology</span>
                <h2 style={{ color: 'var(--navy)', fontSize: '2.6rem', lineHeight: 1.1, letterSpacing: '-.05em' }}>
                  Cover the entire RCEM curriculum in 2 to 2.5 months.
                </h2>
                <p style={{ color: '#5e7187', lineHeight: 1.8 }}>
                  Preparing for the MRCEM examinations while working busy shifts in the Emergency Department is demanding. {brand.name} was built to solve this challenge by eliminating non-examinable clutter and distilling the syllabus into high-yield, structured lessons.
                </p>
                <p style={{ color: '#5e7187', lineHeight: 1.8 }}>
                  Our curriculum combines 221 comprehensive Primary revision topics across Basic Sciences (Anatomy, Physiology, Pathology, Pharmacology, and Microbiology) with 41 topical SBA quizzes and 6 full mock papers mirroring actual computer-based testing conditions.
                </p>
                <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', marginTop: 20 }}>
                  <Link className="btn btn-primary" href="/courses">
                    Explore Flagship Courses <ArrowRight size={16} />
                  </Link>
                  <Link className="btn btn-light" href="/app/membership">
                    <MessageCircle size={15} /> WhatsApp Support
                  </Link>
                </div>
              </div>
            </Reveal>
            <Reveal>
              <div className="course-card">
                <span className="course-label">100% RCEM CURRICULUM ALIGNED</span>
                <h3>High-Yield Notes. Topical SBAs. Authentic Mocks.</h3>
                <p>Pass your MRCEM Primary and Intermediate SBA on your first attempt.</p>
                <div className="course-meta">
                  <span>
                    <CheckCircle2 size={15} /> 221 High-Yield Lessons
                  </span>
                  <span>
                    <CheckCircle2 size={15} /> 41 Topical SBA Quizzes
                  </span>
                  <span>
                    <CheckCircle2 size={15} /> 6 Timed Mock Papers
                  </span>
                  <span>
                    <CheckCircle2 size={15} /> Solved Exam Recalls
                  </span>
                </div>
              </div>
            </Reveal>
          </div>
        </section>
      </main>
    </SiteLayout>
  );
}

