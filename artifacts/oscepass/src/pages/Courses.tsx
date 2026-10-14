import { ArrowRight, MessageCircle } from 'lucide-react';
import { Link } from 'wouter';
import { PageHero } from '@/components/shared/PageHero';
import { CourseGrid } from '@/features/courses/CourseGrid';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { usePageMeta } from '@/lib/usePageMeta';

export default function Courses() {
  usePageMeta('MRCEM Flagship Preparation Courses', 'Comprehensive high-yield notes, topical SBA question banks, and timed mock simulations aligned 100% with the RCEM curriculum.');
  return (
    <SiteLayout>
      <main>
        <PageHero
          eyebrow="Royal College Curriculum"
          title="MRCEM Flagship Preparation Courses"
          intro="Comprehensive high-yield notes, topical SBA question banks, and timed mock simulations aligned 100% with the Royal College of Emergency Medicine syllabus."
        />
        <section className="section" style={{ background: '#f3f8ff', padding: '42px 0 72px' }}>
          <div className="container">
            <div className="course-membership-banner" style={{ marginBottom: 32 }}>
              <div className="course-membership-content">
                <span className="eyebrow">Comprehensive Master Access</span>
                <h2>Unlock both MRCEM Primary &amp; SBA Master Bundles</h2>
                <p>
                  Get full access to all 268 lessons, 41 topical SBA quizzes, 6 full mock exam papers, and direct tutor mentorship on WhatsApp.
                </p>
                <div className="course-membership-actions">
                  <Link href="/app/membership" className="btn btn-primary">
                    <MessageCircle size={16} /> View Packages &amp; Subscribe on WhatsApp <ArrowRight size={15} />
                  </Link>
                </div>
              </div>
            </div>

            <CourseGrid />
          </div>
        </section>
      </main>
    </SiteLayout>
  );
}

