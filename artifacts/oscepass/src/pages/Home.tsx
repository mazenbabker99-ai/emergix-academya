import { useState } from 'react';
import { ArrowRight, ArrowUpRight, BookOpen, Brain, Check, CheckCircle2, Clock3, MessageCircle, Play } from 'lucide-react';
import { Link } from 'wouter';
import { Reveal } from '@/components/shared/Reveal';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { VideoModal } from '@/components/shared/VideoModal';
import { brand } from '@/config/brand';
import { CourseGrid } from '@/features/courses/CourseGrid';
import { features, testimonials } from '@/features/home/data';
import { usePageMeta } from '@/lib/usePageMeta';

export default function Home() {
  usePageMeta('MRCEM Exam Preparation Platform', 'Quick revision notes, high-yield SBA question bank with detailed explanations, along with MRCEM Primary and Intermediate SBA mock simulations.');
  const [videoOpen, setVideoOpen] = useState(false);

  return (
    <SiteLayout>
      <main>
        {/* Hero Section */}
        <section className="hero">
          <div className="container hero-grid">
            <div className="hero-copy">
              <span className="eyebrow">MRCEM Exam Preparation Platform</span>
              <h1>
                Helping Emergency Medicine Physicians to <span>Succeed</span>
              </h1>
              <p>
                Quick revision notes, high-yield SBA question bank with detailed explanations, along with MRCEM Primary and Intermediate SBA mock simulations.
              </p>
              <div className="hero-actions">
                <Link className="btn btn-primary" href="/courses/mrcem-primary">
                  MRCEM Primary <ArrowRight size={17} />
                </Link>
                <Link className="btn btn-light" href="/courses/mrcem-sba">
                  MRCEM SBA <ArrowRight size={17} />
                </Link>
                <Link className="btn btn-light" href="/app/membership">
                  <MessageCircle size={16} /> WhatsApp Enrollment
                </Link>
              </div>
              <div className="hero-proof">
                <div className="avatar-stack" aria-hidden="true">
                  <span>98%</span>
                  <span>260</span>
                  <span>600</span>
                  <span>+</span>
                </div>
                <span>98% Pass Ratio • 260+ Topics • 600+ SBA Questions</span>
              </div>
            </div>
            <div className="hero-art" aria-label="Emergency medicine candidates preparing for MRCEM">
              <div className="hero-photo-frame" />
              <img className="hero-photo" src="/brand/hero.jpg" alt="Emergency medicine team in clinical discussion" />
              <div className="floating-note">
                <span className="float-check">
                  <Check size={19} />
                </span>
                <span>
                  <strong>Pass on First Attempt</strong>
                  <small>High-yield notes &amp; authentic SBA mocks</small>
                </span>
              </div>
            </div>
          </div>
        </section>

        {/* Social Proof / Stats Strip */}
        <section className="social-proof" aria-label={`${brand.name} at a glance`}>
          <div className="container proof-row">
            <div className="proof-label">Trusted by Emergency Medicine Physicians Worldwide</div>
            <div className="proof-stat">
              <strong>98%</strong>
              <small>Success Ratio</small>
            </div>
            <div className="proof-divider" />
            <div className="proof-stat">
              <strong>260+</strong>
              <small>High-Yield Topics</small>
            </div>
            <div className="proof-divider" />
            <div className="proof-stat">
              <strong>600+</strong>
              <small>SBA Questions &amp; Recalls</small>
            </div>
            <div className="proof-divider" />
            <div className="proof-stat">
              <strong>100%</strong>
              <small>RCEM Aligned Curriculum</small>
            </div>
          </div>
        </section>

        {/* Core Value Pillars / Features */}
        <section className="section feature-strip">
          <div className="container">
            <Reveal>
              <div className="section-heading">
                <span className="eyebrow">Why Choose {brand.name}?</span>
                <h2>Engineered specifically for the MRCEM examinations.</h2>
                <p>
                  Cover the entire Royal College of Emergency Medicine syllabus in shorter time, retain high-yield concepts, and master single-best-answer techniques.
                </p>
              </div>
            </Reveal>
            <div className="feature-grid">
              {features.map(({ icon: Icon, title, text }, index) => (
                <Reveal key={title} className={`delay-${index}`}>
                  <article className="feature-card">
                    <span className="icon-tile">
                      <Icon size={21} />
                    </span>
                    <h3>{title}</h3>
                    <p>{text}</p>
                  </article>
                </Reveal>
              ))}
            </div>
          </div>
        </section>

        {/* Flagship Courses Section */}
        <section className="section modules-section">
          <div className="container">
            <Reveal>
              <div className="section-heading modules-heading">
                <div>
                  <span className="eyebrow">Official Curriculum Pathways</span>
                  <h2>Choose Your MRCEM Course</h2>
                </div>
                <Link className="link-all-courses" href="/courses">
                  View All Courses <ArrowRight size={15} />
                </Link>
              </div>
            </Reveal>
            <CourseGrid />
          </div>
        </section>

        {/* Accelerated Revision Band */}
        <section className="section course-band">
          <div className="container course-showcase">
            <Reveal>
              <div className="course-copy">
                <span className="eyebrow">Accelerated Preparation</span>
                <h2>Cover the entire RCEM curriculum in 2 to 2.5 months.</h2>
                <p>
                  Eliminate non-examinable clutter. Our revision notes distill Anatomy, Physiology, Pathology, Pharmacology, and Microbiology into actionable concepts with clinical callouts, mnemonics, and previous exam pearls.
                </p>
                <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
                  <Link className="btn btn-primary" href="/courses/mrcem-primary">
                    Explore MRCEM Primary <ArrowRight size={16} />
                  </Link>
                  <Link className="btn btn-light" href="/courses/mrcem-sba">
                    Explore MRCEM SBA <ArrowRight size={16} />
                  </Link>
                </div>
              </div>
            </Reveal>
            <Reveal>
              <article className="course-card">
                <div className="course-card-top">
                  <span className="course-label">COMPREHENSIVE MASTER BUNDLE</span>
                  <Brain size={26} color="#9acbff" />
                </div>
                <h3>MRCEM Primary &amp; SBA Master Access</h3>
                <p>
                  Get full access to all 221 Primary Basic Science lessons, 41 topical SBA quizzes, and 6 full mock exam simulation papers with direct tutor WhatsApp support.
                </p>
                <div className="course-meta">
                  <span>
                    <BookOpen size={15} /> 221 Primary Lessons
                  </span>
                  <span>
                    <CheckCircle2 size={15} /> 41 SBA Quizzes
                  </span>
                  <span>
                    <Clock3 size={15} /> 6 Mock Papers
                  </span>
                </div>
                <Link className="btn btn-light" href="/app/membership">
                  <MessageCircle size={15} /> Get Full Access on WhatsApp <ArrowUpRight size={16} />
                </Link>
              </article>
            </Reveal>
          </div>
        </section>

        {/* 3-Step Methodology */}
        <section className="section how-section">
          <div className="container">
            <Reveal>
              <div className="section-heading">
                <span className="eyebrow">A Proven 3-Step Strategy</span>
                <h2>The Formula to Pass on Your First Attempt</h2>
                <p>A structured learning and revision methodology engineered for busy emergency medicine physicians.</p>
              </div>
            </Reveal>
            <div className="steps">
              {[
                ['01', 'Concise High-Yield Notes', 'Study system-by-system summaries across Anatomy, Physiology, Pathology and Pharmacology with clear clinical pearls and mnemonics.'],
                ['02', 'Topical SBA Practice', 'Cement every topic immediately with 41 single-best-answer question sets featuring detailed rationales and solved previous exam recalls.'],
                ['03', 'Timed Mock Simulations', 'Simulate authentic 3-hour computer-based Royal College exam conditions across 6 full mock papers to build speed and stamina.'],
              ].map(([number, title, text]) => (
                <Reveal key={number}>
                  <article className="step">
                    <span className="step-number">{number}</span>
                    <h3>{title}</h3>
                    <p>{text}</p>
                  </article>
                </Reveal>
              ))}
            </div>
          </div>
        </section>

        {/* Doctor Testimonials Section */}
        <section className="section quote-section">
          <div className="container">
            <Reveal>
              <div className="section-heading" style={{ color: '#fff' }}>
                <span className="eyebrow" style={{ color: '#84bdff' }}>Candidate Success Stories</span>
                <h2 style={{ color: '#fff' }}>98% of MRCEM candidates recommend us.</h2>
                <p style={{ color: '#bfd1e5' }}>
                  Real feedback from emergency medicine doctors who passed their Royal College examinations using our high-yield notes and question banks.
                </p>
              </div>
            </Reveal>

            <div className="quote-cards-grid">
              {testimonials.map((t, idx) => (
                <Reveal key={t.author} className={`delay-${idx}`}>
                  <article className="quote-card">
                    <div>
                      <span className="quote-badge">{t.exam}</span>
                      <blockquote>"{t.quote}"</blockquote>
                    </div>
                    <div className="quote-person">
                      <div className="quote-avatar">
                        {t.author.replace('Dr. ', '').slice(0, 2).toUpperCase()}
                      </div>
                      <div>
                        <strong>{t.author}</strong>
                        <small>{t.role}</small>
                      </div>
                    </div>
                  </article>
                </Reveal>
              ))}
            </div>
          </div>
        </section>

        {/* Enrollment CTA Section */}
        <section className="cta-section">
          <div className="container cta-panel">
            <div>
              <h2>Ready to succeed in your MRCEM exam?</h2>
              <p>Start preparing today with high-yield revision notes, topical SBA question banks, and authentic mock simulations.</p>
            </div>
            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
              <Link className="btn btn-primary" href="/app/membership">
                <MessageCircle size={16} /> Enroll via WhatsApp <ArrowRight size={16} />
              </Link>
              <Link className="btn btn-light" href="/courses">
                Explore Courses <ArrowRight size={16} />
              </Link>
            </div>
          </div>
        </section>
      </main>
      {videoOpen && <VideoModal onClose={() => setVideoOpen(false)} />}
    </SiteLayout>
  );
}

