import { PageHero } from '@/components/shared/PageHero';
import { CourseGrid } from '@/features/courses/CourseGrid';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { usePageMeta } from '@/lib/usePageMeta';

export default function Courses() {
  usePageMeta('Courses', 'Discover emergency medicine and MRCEM OSCE courses, with focused learning and practice pathways.');
  return <SiteLayout><main><PageHero eyebrow="Explore our modules" title="Find the right next step for your preparation." intro="Choose a focused pathway, build your clinical approach and practise the stations that matter to your exam." />
    <section className="section"><div className="container"><CourseGrid /></div></section>
  </main></SiteLayout>;
}
