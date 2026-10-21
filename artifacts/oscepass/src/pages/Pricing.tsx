import { useMemo, useState } from 'react';
import { ArrowRight, Brain, Check, MessageCircle, Sparkles, Stethoscope, Trophy, Zap } from 'lucide-react';
import { Link } from 'wouter';
import { useListFaqs } from '@workspace/api-client-react';
import { PageHero } from '@/components/shared/PageHero';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { FaqAccordion } from '@/features/exams/FaqAccordion';
import { faqPageJsonLd } from '@/lib/schema';
import { useJsonLd, usePageMeta } from '@/lib/usePageMeta';

interface FlagshipPricingTier {
  slug: string;
  title: string;
  badge: string;
  icon: typeof Brain;
  color: string;
  tagline: string;
  diets: Array<{
    name: string;
    duration: string;
    price: string;
    savings?: string;
    isFeatured?: boolean;
  }>;
  features: string[];
  ctaText: string;
  ctaLink: string;
}

const FLAGSHIP_PRICING: FlagshipPricingTier[] = [
  {
    slug: 'mrcem-primary',
    title: 'MRCEM PRIMARY',
    badge: 'BASIC SCIENCES MASTERCLASS',
    icon: Brain,
    color: '#0A84FF',
    tagline: 'Comprehensive anatomy, physiology, pharmacology, pathology & microbiology.',
    diets: [
      {
        name: 'Diet 1 Pass',
        duration: '3 Months Unlimited Access',
        price: '$99',
      },
      {
        name: 'Diet 2 / Full Pass',
        duration: '6 Months Extended Access',
        price: '$199',
        savings: 'PASS GUARANTEE',
        isFeatured: true,
      },
    ],
    features: [
      'All 21 RCEM syllabus basic science modules',
      '221 in-depth illustrated clinical lecture notes',
      '269 high-yield anatomical plates and clinical figures',
      'Interactive end-of-topic knowledge checks',
      'Mobile and desktop progress synchronization',
      'Direct 1-on-1 mentor guidance & support on WhatsApp',
    ],
    ctaText: 'Subscribe to MRCEM Primary',
    ctaLink: '/app/membership',
  },
  {
    slug: 'mrcem-sba',
    title: 'MRCEM SBA',
    badge: 'QUESTION BANK & MOCKS',
    icon: Stethoscope,
    color: '#10B981',
    tagline: 'Single best answer practice engine & full timed mock examination simulations.',
    diets: [
      {
        name: 'Diet 1 Pass',
        duration: '3 Months Unlimited Access',
        price: '$149',
      },
      {
        name: 'Diet 2 / Full Pass',
        duration: '6 Months Extended Access',
        price: '$249',
        savings: 'PASS GUARANTEE',
        isFeatured: true,
      },
    ],
    features: [
      '41 topical SBA question banks across all emergency domains',
      '6 full-length timed mock simulation exams (RCEM blueprint)',
      'Amboss/UWorld test engine with distractor elimination & flagging',
      'Comprehensive explanations and evidence-based rationales',
      'Performance analytics, accuracy trends & weak-area diagnosis',
      'Direct 1-on-1 mentor guidance & support on WhatsApp',
    ],
    ctaText: 'Subscribe to MRCEM SBA',
    ctaLink: '/app/membership',
  },
];

export default function Pricing() {
  usePageMeta('Pricing & Diets', 'Transparent pricing for MRCEM Primary and MRCEM SBA preparation with WhatsApp activation.');
  const faqs = useListFaqs({ category: 'pricing' });
  const faqLd = useMemo(() => (faqs.data?.items.length ? faqPageJsonLd(faqs.data.items) : null), [faqs.data]);
  useJsonLd('faq', faqLd);

  return (
    <SiteLayout>
      <main>
        <PageHero
          eyebrow="Membership &amp; Diets"
          title="Transparent, High-Yield Plans."
          intro="Choose your target examination track and duration. Instant manual activation arranged directly with our tutor team on WhatsApp."
        />

        <section className="section" style={{ background: '#f8fafc', padding: '48px 0 72px' }}>
          <div className="container">
            {/* WhatsApp Verification Banner */}
            <div
              style={{
                background: 'linear-gradient(135deg, #0a2342 0%, #004d99 100%)',
                borderRadius: 16,
                padding: '28px 32px',
                color: '#ffffff',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                flexWrap: 'wrap',
                gap: 20,
                marginBottom: 36,
                boxShadow: '0 10px 25px rgba(10, 35, 66, 0.12)',
              }}
            >
              <div>
                <span
                  style={{
                    fontSize: '.74rem',
                    fontWeight: 800,
                    textTransform: 'uppercase',
                    letterSpacing: '.08em',
                    color: '#93c5fd',
                  }}
                >
                  Direct Tutor Verification
                </span>
                <h3 style={{ fontSize: '1.35rem', fontWeight: 800, margin: '6px 0', color: '#ffffff' }}>
                  Subscribe Directly via WhatsApp
                </h3>
                <p style={{ margin: 0, color: '#e0e7ff', fontSize: '.92rem', maxWidth: '620px', lineHeight: 1.5 }}>
                  Choose your course and duration below, then send your transfer confirmation to our team on WhatsApp for immediate course access.
                </p>
              </div>

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
                }}
              >
                <MessageCircle size={16} style={{ color: '#25D366' }} />
                Subscribe on WhatsApp <ArrowRight size={15} />
              </Link>
            </div>

            {/* The Two Flagship Pricing Cards */}
            <div
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(360px, 1fr))',
                gap: 28,
                marginBottom: 36,
              }}
            >
              {FLAGSHIP_PRICING.map((plan) => {
                const Icon = plan.icon;
                return (
                  <article
                    key={plan.slug}
                    style={{
                      background: '#ffffff',
                      borderRadius: 18,
                      border: '1.5px solid #dce8f5',
                      boxShadow: '0 12px 36px rgba(10, 35, 66, 0.08)',
                      overflow: 'hidden',
                      display: 'flex',
                      flexDirection: 'column',
                    }}
                  >
                    {/* Header */}
                    <div
                      style={{
                        padding: '28px 28px 20px',
                        background: '#ffffff',
                        borderBottom: '1px solid #f1f5f9',
                      }}
                    >
                      <div
                        style={{
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: 6,
                          fontSize: '.72rem',
                          fontWeight: 800,
                          letterSpacing: '.06em',
                          textTransform: 'uppercase',
                          color: plan.color,
                          background: `${plan.color}15`,
                          padding: '4px 10px',
                          borderRadius: 6,
                          marginBottom: 10,
                        }}
                      >
                        <Icon size={14} />
                        {plan.badge}
                      </div>
                      <h2
                        style={{
                          margin: 0,
                          fontSize: '1.75rem',
                          fontWeight: 850,
                          color: '#0f172a',
                          letterSpacing: '-.02em',
                        }}
                      >
                        {plan.title}
                      </h2>
                      <p style={{ margin: '8px 0 0', color: '#64748b', fontSize: '.9rem', lineHeight: 1.5 }}>
                        {plan.tagline}
                      </p>
                    </div>

                    {/* Diets Boxes */}
                    <div style={{ padding: '24px 28px', background: '#fafbfc', flex: 1 }}>
                      <div
                        style={{
                          fontSize: '.74rem',
                          fontWeight: 800,
                          textTransform: 'uppercase',
                          letterSpacing: '.06em',
                          color: '#475569',
                          marginBottom: 12,
                          display: 'flex',
                          alignItems: 'center',
                          gap: 6,
                        }}
                      >
                        <Trophy size={14} style={{ color: '#0284c7' }} />
                        Select Examination Diet:
                      </div>

                      <div style={{ display: 'flex', flexDirection: 'column', gap: 12, marginBottom: 24 }}>
                        {plan.diets.map((diet, idx) => (
                          <div
                            key={idx}
                            style={{
                              background: '#ffffff',
                              borderRadius: 12,
                              padding: '16px 18px',
                              border: diet.isFeatured ? '2px solid #0284c7' : '1px solid #e2e8f0',
                              display: 'flex',
                              alignItems: 'center',
                              justifyContent: 'space-between',
                              position: 'relative',
                              boxShadow: diet.isFeatured ? '0 4px 16px rgba(2, 132, 199, 0.12)' : 'none',
                            }}
                          >
                            {diet.savings && (
                              <span
                                style={{
                                  position: 'absolute',
                                  top: -9,
                                  right: 14,
                                  background: '#0284c7',
                                  color: '#ffffff',
                                  fontSize: '.62rem',
                                  fontWeight: 800,
                                  padding: '2px 8px',
                                  borderRadius: 4,
                                  textTransform: 'uppercase',
                                  letterSpacing: '.04em',
                                }}
                              >
                                {diet.savings}
                              </span>
                            )}
                            <div>
                              <div style={{ fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>{diet.name}</div>
                              <div style={{ fontSize: '.78rem', color: '#64748b', marginTop: 2 }}>
                                {diet.duration}
                              </div>
                            </div>
                            <div style={{ textAlign: 'right' }}>
                              <div style={{ fontSize: '1.5rem', fontWeight: 850, color: '#0284c7', lineHeight: 1 }}>
                                {diet.price}
                              </div>
                              <div style={{ fontSize: '.68rem', color: '#94a3b8', marginTop: 3 }}>One-time</div>
                            </div>
                          </div>
                        ))}
                      </div>

                      {/* Feature checklist */}
                      <div
                        style={{
                          fontSize: '.74rem',
                          fontWeight: 800,
                          textTransform: 'uppercase',
                          letterSpacing: '.06em',
                          color: '#475569',
                          marginBottom: 12,
                        }}
                      >
                        Track Inclusions:
                      </div>
                      <ul
                        style={{
                          listStyle: 'none',
                          padding: 0,
                          margin: 0,
                          display: 'flex',
                          flexDirection: 'column',
                          gap: 9,
                        }}
                      >
                        {plan.features.map((feat, idx) => (
                          <li
                            key={idx}
                            style={{
                              display: 'flex',
                              alignItems: 'flex-start',
                              gap: 10,
                              fontSize: '.86rem',
                              color: '#334155',
                              lineHeight: 1.4,
                            }}
                          >
                            <span
                              style={{
                                display: 'inline-flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                width: 18,
                                height: 18,
                                borderRadius: '50%',
                                background: '#dcfce7',
                                color: '#15803d',
                                flexShrink: 0,
                                marginTop: 1,
                              }}
                            >
                              <Check size={12} strokeWidth={3} />
                            </span>
                            <span>{feat}</span>
                          </li>
                        ))}
                      </ul>
                    </div>

                    {/* Action */}
                    <div
                      style={{
                        padding: '20px 28px 24px',
                        background: '#ffffff',
                        borderTop: '1px solid #f1f5f9',
                      }}
                    >
                      <Link
                        href="/app/membership"
                        className="btn btn-primary"
                        style={{
                          width: '100%',
                          display: 'inline-flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          gap: 8,
                          fontWeight: 750,
                          padding: '13px 20px',
                          fontSize: '.95rem',
                        }}
                      >
                        <MessageCircle size={16} style={{ color: '#25D366' }} />
                        {plan.ctaText} <ArrowRight size={16} />
                      </Link>
                    </div>
                  </article>
                );
              })}
            </div>

            {/* Comprehensive Dual Bundle */}
            <div
              style={{
                background: 'linear-gradient(135deg, #07172c 0%, #0a2342 60%, #0d3868 100%)',
                borderRadius: 18,
                padding: '34px 38px',
                color: '#ffffff',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                flexWrap: 'wrap',
                gap: 24,
                boxShadow: '0 12px 32px rgba(10, 35, 66, 0.2)',
                marginBottom: 48,
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
                    color: '#38bdf8',
                    marginBottom: 8,
                  }}
                >
                  <Sparkles size={14} /> Full Pass Master Bundle (Primary + SBA)
                </div>
                <h3 style={{ fontSize: '1.5rem', fontWeight: 800, margin: '0 0 8px', color: '#ffffff' }}>
                  Combine Both Flagship Courses &amp; Save
                </h3>
                <p style={{ margin: 0, color: '#e0e7ff', fontSize: '.92rem', lineHeight: 1.55 }}>
                  Get complete access to all 221 basic science lecture notes, all 41 topical question banks, and all 6 timed mock examination papers in one master bundle. Diet 1: $199 • Diet 2: $299.
                </p>
              </div>

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
                  padding: '12px 22px',
                }}
              >
                <MessageCircle size={16} style={{ color: '#25D366' }} />
                Get Master Bundle on WhatsApp <ArrowRight size={15} />
              </Link>
            </div>

            {/* FAQ Accordion */}
            {faqs.data && faqs.data.items.length > 0 && (
              <section className="faq-wrap" style={{ marginTop: 20 }}>
                <div className="section-heading" style={{ textAlign: 'center', marginBottom: 24 }}>
                  <h2 style={{ fontSize: '1.6rem', fontWeight: 800, color: '#0f172a' }}>
                    Frequently Asked Questions
                  </h2>
                </div>
                <FaqAccordion faqs={faqs.data.items} />
              </section>
            )}
          </div>
        </section>
      </main>
    </SiteLayout>
  );
}
