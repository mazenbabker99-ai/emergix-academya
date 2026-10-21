import { ArrowRight, BookOpen, Brain, Check, Clock3, FileText, HelpCircle, MessageCircle, Sparkles, Stethoscope, Trophy } from 'lucide-react';
import { Link } from 'wouter';
import { useQuery } from '@tanstack/react-query';
import { listCourses } from '@workspace/api-client-react';
import { PageSkeleton } from '@/components/shared/DataState';

interface FlagshipCourseConfig {
  slug: string;
  title: string;
  badge: string;
  category: string;
  tagline: string;
  summary: string;
  image: string;
  icon: typeof Brain;
  color: string;
  priceRange: string;
  diets: Array<{ name: string; duration: string; price: string; isBestValue?: boolean }>;
  stats: Array<{ label: string; value: string }>;
  features: string[];
  primaryLink: string;
  primaryCta: string;
  secondaryLink: string;
  secondaryCta: string;
}

const FLAGSHIP_COURSES: FlagshipCourseConfig[] = [
  {
    slug: 'mrcem-primary',
    title: 'MRCEM PRIMARY',
    badge: 'FLAGSHIP BASIC SCIENCES',
    category: 'RCEM Basic Sciences Masterclass',
    tagline: 'Comprehensive anatomy, physiology, pharmacology, pathology & microbiology.',
    summary:
      'The definitive RCEM Primary masterclass. Includes all 21 core curriculum modules, 221 detailed lecture notes, 269 high-yield medical figures and anatomical plates, plus topic knowledge checks.',
    image: '/brand/t1.jpg',
    icon: Brain,
    color: '#0A84FF',
    priceRange: '$99 – $199',
    diets: [
      { name: 'Diet 1 Pass', duration: '3 Months Access', price: '$99' },
      { name: 'Diet 2 / Full Pass', duration: '6 Months Access', price: '$199', isBestValue: true },
    ],
    stats: [
      { label: 'Modules', value: '21 Modules' },
      { label: 'Lessons', value: '221 Lessons' },
      { label: 'Figures', value: '269 Figures' },
      { label: 'Topic Checks', value: 'End-of-Topic' },
    ],
    features: [
      'Full coverage: Anatomy, Physiology, Pharmacology, Pathology & Microbiology',
      '221 in-depth illustrated clinical lecture notes',
      '269 high-yield anatomical plates and clinical figures',
      'Interactive end-of-topic self-assessment knowledge checks',
      'Aligned 100% with the latest Royal College curriculum',
      'Direct 1-on-1 mentor guidance & support on WhatsApp',
    ],
    primaryLink: '/courses/mrcem-primary',
    primaryCta: 'Explore Curriculum (221 Lessons)',
    secondaryLink: '/app/membership',
    secondaryCta: 'Subscribe via WhatsApp',
  },
  {
    slug: 'mrcem-sba',
    title: 'MRCEM SBA',
    badge: 'FLAGSHIP QUESTION BANK & MOCKS',
    category: 'Clinical Reasoning & SBA Engine',
    tagline: 'Topical SBA question bank and full-length timed mock examinations.',
    summary:
      'The premier single-best-answer (SBA) training engine. Features 41 topical question banks across all emergency domains, 6 full-length timed mock exams, and an Amboss/UWorld-style test interface.',
    image: '/brand/hero.jpg',
    icon: Stethoscope,
    color: '#10B981',
    priceRange: '$149 – $249',
    diets: [
      { name: 'Diet 1 Pass', duration: '3 Months Access', price: '$149' },
      { name: 'Diet 2 / Full Pass', duration: '6 Months Access', price: '$249', isBestValue: true },
    ],
    stats: [
      { label: 'Question Banks', value: '41 Topics' },
      { label: 'Mock Exams', value: '6 Timed Papers' },
      { label: 'Test Engine', value: 'Amboss-Style' },
      { label: 'Rationales', value: 'Instant Explanations' },
    ],
    features: [
      '41 topical SBA question banks covering every emergency subspecialty',
      '6 full-length timed mock examination papers (RCEM exam blueprint)',
      'World-class test engine with distractor elimination (strikethrough) and flagging',
      'Comprehensive explanations and evidence-based clinical guidance',
      'Performance analytics, accuracy tracking, and weak-area diagnosis',
      'Direct 1-on-1 mentor guidance & support on WhatsApp',
    ],
    primaryLink: '/question-bank',
    primaryCta: 'Launch SBA Question Bank',
    secondaryLink: '/app/membership',
    secondaryCta: 'Subscribe via WhatsApp',
  },
];

export function CourseGrid() {
  const coursesQuery = useQuery({
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

  if (coursesQuery.isLoading) {
    return <PageSkeleton rows={3} label="Loading flagship courses" />;
  }

  // Find dynamic course records if available
  const dbCourses = coursesQuery.data ?? [];
  const primaryDb = dbCourses.find((c) => c.slug === 'mrcem-primary');
  const sbaDb = dbCourses.find((c) => c.slug === 'mrcem-sba');

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 36 }}>
      {/* Two Flagship Cards Grid */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))',
          gap: 28,
          alignItems: 'stretch',
        }}
      >
        {FLAGSHIP_COURSES.map((flagship) => {
          const Icon = flagship.icon;
          const liveCourse = flagship.slug === 'mrcem-primary' ? primaryDb : sbaDb;
          const lessonCount = liveCourse?.lessonCount ?? (flagship.slug === 'mrcem-primary' ? 221 : 47);

          return (
            <article
              key={flagship.slug}
              className="module-card"
              data-testid={`flagship-card-${flagship.slug}`}
              style={{
                display: 'flex',
                flexDirection: 'column',
                borderRadius: 18,
                border: '1px solid #dce8f5',
                background: '#ffffff',
                boxShadow: '0 12px 36px rgba(10, 35, 66, 0.08)',
                overflow: 'hidden',
                position: 'relative',
                transition: 'transform 0.25s ease, box-shadow 0.25s ease',
              }}
            >
              {/* Image banner with overlay */}
              <div
                style={{
                  position: 'relative',
                  height: 220,
                  width: '100%',
                  overflow: 'hidden',
                  background: '#0a2342',
                }}
              >
                <img
                  src={flagship.image}
                  alt={flagship.title}
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                    opacity: 0.88,
                    transition: 'transform 0.3s ease',
                  }}
                  loading="lazy"
                />
                <div
                  style={{
                    position: 'absolute',
                    inset: 0,
                    background: 'linear-gradient(to top, rgba(10, 35, 66, 0.95) 0%, rgba(10, 35, 66, 0.4) 60%, transparent 100%)',
                  }}
                />

                {/* Badge top-left */}
                <div
                  style={{
                    position: 'absolute',
                    top: 14,
                    left: 14,
                    background: 'rgba(255, 255, 255, 0.96)',
                    backdropFilter: 'blur(8px)',
                    color: '#0a2342',
                    fontSize: '.72rem',
                    fontWeight: 800,
                    letterSpacing: '.06em',
                    padding: '4px 10px',
                    borderRadius: 8,
                    display: 'flex',
                    alignItems: 'center',
                    gap: 6,
                    boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                  }}
                >
                  <Icon size={14} style={{ color: flagship.color }} />
                  {flagship.badge}
                </div>

                {/* Price range pill top-right */}
                <div
                  style={{
                    position: 'absolute',
                    top: 14,
                    right: 14,
                    background: 'linear-gradient(135deg, #0A84FF 0%, #0056b3 100%)',
                    color: '#ffffff',
                    fontSize: '.82rem',
                    fontWeight: 800,
                    padding: '5px 12px',
                    borderRadius: 20,
                    letterSpacing: '.02em',
                    boxShadow: '0 4px 14px rgba(10, 132, 255, 0.4)',
                  }}
                >
                  {flagship.priceRange}
                </div>

                {/* Title on image banner */}
                <div
                  style={{
                    position: 'absolute',
                    bottom: 16,
                    left: 18,
                    right: 18,
                  }}
                >
                  <span
                    style={{
                      display: 'block',
                      color: '#93c5fd',
                      fontSize: '.76rem',
                      fontWeight: 700,
                      textTransform: 'uppercase',
                      letterSpacing: '.08em',
                      marginBottom: 4,
                    }}
                  >
                    {flagship.category}
                  </span>
                  <h3
                    style={{
                      margin: 0,
                      color: '#ffffff',
                      fontSize: '1.65rem',
                      fontWeight: 850,
                      letterSpacing: '-.02em',
                      lineHeight: 1.2,
                    }}
                  >
                    {flagship.title}
                  </h3>
                </div>
              </div>

              {/* Card Body */}
              <div
                style={{
                  padding: '24px 22px',
                  display: 'flex',
                  flexDirection: 'column',
                  flex: 1,
                  background: '#ffffff',
                }}
              >
                {/* Short summary */}
                <p
                  style={{
                    color: '#475569',
                    fontSize: '.92rem',
                    lineHeight: 1.55,
                    margin: '0 0 18px',
                  }}
                >
                  {liveCourse?.summary || flagship.summary}
                </p>

                {/* Stats highlight strip */}
                <div
                  style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(4, 1fr)',
                    gap: 8,
                    background: '#f8fafc',
                    border: '1px solid #e2e8f0',
                    borderRadius: 12,
                    padding: '12px 8px',
                    marginBottom: 20,
                    textAlign: 'center',
                  }}
                >
                  {flagship.stats.map((stat, idx) => (
                    <div key={idx} style={{ padding: '0 4px' }}>
                      <div
                        style={{
                          fontSize: '.88rem',
                          fontWeight: 800,
                          color: '#0f172a',
                          whiteSpace: 'nowrap',
                          overflow: 'hidden',
                          textOverflow: 'ellipsis',
                        }}
                      >
                        {stat.value}
                      </div>
                      <div
                        style={{
                          fontSize: '.68rem',
                          color: '#64748b',
                          fontWeight: 600,
                          textTransform: 'uppercase',
                          letterSpacing: '.04em',
                          marginTop: 2,
                        }}
                      >
                        {stat.label}
                      </div>
                    </div>
                  ))}
                </div>

                {/* Diet Pricing Boxes matching Image 1 */}
                <div
                  style={{
                    marginBottom: 20,
                    padding: 14,
                    background: '#f0f7ff',
                    borderRadius: 12,
                    border: '1px solid #bfdbfe',
                  }}
                >
                  <div
                    style={{
                      fontSize: '.72rem',
                      fontWeight: 800,
                      textTransform: 'uppercase',
                      letterSpacing: '.06em',
                      color: '#1e40af',
                      marginBottom: 10,
                      display: 'flex',
                      alignItems: 'center',
                      gap: 6,
                    }}
                  >
                    <Trophy size={13} />
                    Available Diets &amp; Pricing Options
                  </div>
                  <div
                    style={{
                      display: 'grid',
                      gridTemplateColumns: 'repeat(2, 1fr)',
                      gap: 10,
                    }}
                  >
                    {flagship.diets.map((diet, idx) => (
                      <div
                        key={idx}
                        style={{
                          background: '#ffffff',
                          borderRadius: 8,
                          padding: '10px 12px',
                          border: diet.isBestValue ? '1.5px solid #0284c7' : '1px solid #e2e8f0',
                          position: 'relative',
                        }}
                      >
                        {diet.isBestValue && (
                          <span
                            style={{
                              position: 'absolute',
                              top: -8,
                              right: 8,
                              background: '#0284c7',
                              color: '#ffffff',
                              fontSize: '.62rem',
                              fontWeight: 800,
                              padding: '2px 6px',
                              borderRadius: 4,
                              textTransform: 'uppercase',
                            }}
                          >
                            Pass Guarantee
                          </span>
                        )}
                        <div style={{ fontSize: '.8rem', fontWeight: 700, color: '#0f172a' }}>{diet.name}</div>
                        <div style={{ fontSize: '.72rem', color: '#64748b', marginTop: 2 }}>{diet.duration}</div>
                        <div style={{ fontSize: '1.15rem', fontWeight: 850, color: '#0284c7', marginTop: 4 }}>
                          {diet.price}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                {/* Features Checklist */}
                <div style={{ marginBottom: 24, flex: 1 }}>
                  <div
                    style={{
                      fontSize: '.74rem',
                      fontWeight: 800,
                      textTransform: 'uppercase',
                      letterSpacing: '.06em',
                      color: '#475569',
                      marginBottom: 10,
                    }}
                  >
                    What&apos;s Included:
                  </div>
                  <ul
                    style={{
                      listStyle: 'none',
                      padding: 0,
                      margin: 0,
                      display: 'flex',
                      flexDirection: 'column',
                      gap: 8,
                    }}
                  >
                    {flagship.features.map((feat, idx) => (
                      <li
                        key={idx}
                        style={{
                          display: 'flex',
                          alignItems: 'flex-start',
                          gap: 9,
                          fontSize: '.84rem',
                          color: '#334155',
                          lineHeight: 1.4,
                        }}
                      >
                        <span
                          style={{
                            display: 'inline-flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            width: 17,
                            height: 17,
                            borderRadius: '50%',
                            background: '#dcfce7',
                            color: '#15803d',
                            flexShrink: 0,
                            marginTop: 1,
                          }}
                        >
                          <Check size={11} strokeWidth={3} />
                        </span>
                        <span>{feat}</span>
                      </li>
                    ))}
                  </ul>
                </div>

                {/* Actions */}
                <div
                  style={{
                    display: 'flex',
                    flexDirection: 'column',
                    gap: 10,
                    paddingTop: 16,
                    borderTop: '1px solid #f1f5f9',
                  }}
                >
                  <Link
                    href={flagship.primaryLink}
                    className="btn btn-primary"
                    style={{
                      width: '100%',
                      display: 'inline-flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: 8,
                      fontWeight: 750,
                      padding: '12px 18px',
                      fontSize: '.92rem',
                    }}
                  >
                    {flagship.primaryCta} <ArrowRight size={16} />
                  </Link>

                  <Link
                    href={flagship.secondaryLink}
                    style={{
                      width: '100%',
                      display: 'inline-flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: 8,
                      fontWeight: 700,
                      padding: '10px 16px',
                      fontSize: '.86rem',
                      color: '#0a2342',
                      background: '#f1f5f9',
                      borderRadius: 8,
                      textDecoration: 'none',
                      transition: 'background 0.2s ease',
                    }}
                  >
                    <MessageCircle size={15} style={{ color: '#25D366' }} />
                    {flagship.secondaryCta}
                  </Link>
                </div>
              </div>
            </article>
          );
        })}
      </div>

      {/* Dual Flagship Bundle Banner */}
      <div
        style={{
          background: 'linear-gradient(135deg, #0a2342 0%, #004d99 100%)',
          borderRadius: 18,
          padding: '30px 34px',
          color: '#ffffff',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          gap: 24,
          boxShadow: '0 12px 30px rgba(10, 35, 66, 0.16)',
        }}
      >
        <div style={{ maxWidth: '640px' }}>
          <div
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: 6,
              fontSize: '.74rem',
              fontWeight: 800,
              textTransform: 'uppercase',
              letterSpacing: '.08em',
              color: '#93c5fd',
              marginBottom: 8,
            }}
          >
            <Sparkles size={14} /> Comprehensive All-Access Dual Bundle
          </div>
          <h3 style={{ fontSize: '1.45rem', fontWeight: 800, margin: '0 0 8px', color: '#ffffff', lineHeight: 1.3 }}>
            Preparing for Both MRCEM Primary &amp; SBA?
          </h3>
          <p style={{ margin: 0, color: '#e0e7ff', fontSize: '.92rem', lineHeight: 1.55 }}>
            Unlock all 221 basic science lessons, all 41 topical SBA question banks, and all 6 timed mock simulation papers in one discounted master package with direct WhatsApp tutor mentorship.
          </p>
        </div>

        <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
          <Link
            href="/app/membership"
            className="btn btn-primary"
            style={{
              background: '#ffffff',
              color: '#0a2342',
              fontWeight: 750,
              display: 'inline-flex',
              alignItems: 'center',
              gap: 8,
              padding: '12px 20px',
            }}
          >
            <MessageCircle size={16} style={{ color: '#25D366' }} />
            View Bundle Offer on WhatsApp <ArrowRight size={15} />
          </Link>
        </div>
      </div>
    </div>
  );
}
