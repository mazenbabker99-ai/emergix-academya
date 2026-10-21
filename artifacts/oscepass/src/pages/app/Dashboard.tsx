import { useState } from 'react';
import {
  ArrowRight,
  Award,
  BookOpen,
  Brain,
  CheckCircle2,
  Clock,
  Compass,
  FileCheck,
  Flame,
  HelpCircle,
  LayoutGrid,
  Lock,
  MessageCircle,
  Play,
  RotateCcw,
  ShieldCheck,
  Sparkles,
  Stethoscope,
  Target,
  Trophy,
  Zap,
} from 'lucide-react';
import { Link } from 'wouter';
import { AppLayout } from '@/components/layouts/AppLayout';
import { useAuth } from '@/features/auth/AuthProvider';
import { usePageMeta } from '@/lib/usePageMeta';

export default function Dashboard() {
  usePageMeta('Candidate Portal', 'Your personalized MRCEM candidate command center.');
  const { user } = useAuth();
  const displayName = user?.name ? (user.name.startsWith('Dr.') ? user.name : `Dr. ${user.name}`) : 'Doctor';

  // WhatsApp mentor URL prefilled with candidate information
  const whatsappNumber = '966563169123';
  const mentorMessage = encodeURIComponent(
    `Hello Emergix Academy Mentor Team,\nCandidate: ${user?.name ?? 'Candidate'} (${user?.email ?? ''})\n\nI am currently studying for the MRCEM examination and would like clinical guidance / study plan assistance.`
  );
  const mentorUrl = `https://wa.me/${whatsappNumber}?text=${mentorMessage}`;

  return (
    <AppLayout>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 32, paddingBottom: 48 }}>
        {/* Alerts for unverified email or account deletion */}
        {user && !user.emailVerified && (
          <div
            className="form-alert"
            role="alert"
            style={{
              background: '#eff6ff',
              border: '1px solid #bfdbfe',
              color: '#1e40af',
              borderRadius: 12,
              padding: '12px 18px',
              display: 'flex',
              alignItems: 'center',
              gap: 10,
              fontSize: '.88rem',
            }}
          >
            <ShieldCheck size={18} />
            <span>
              Your candidate e-mail is registered ({user.email}). Check your inbox to confirm your email address.
            </span>
          </div>
        )}

        {user?.deletionScheduledAt && (
          <div
            className="form-alert"
            role="alert"
            style={{
              background: '#fef2f2',
              border: '1px solid #fecaca',
              color: '#991b1b',
              borderRadius: 12,
              padding: '12px 18px',
            }}
          >
            Your account is scheduled for deletion on {new Date(user.deletionScheduledAt).toLocaleDateString()}.{' '}
            <Link href="/app/account" style={{ textDecoration: 'underline', fontWeight: 700 }}>
              Cancel deletion
            </Link>
          </div>
        )}

        {/* 1. Hero Candidate Command Center */}
        <div
          style={{
            background: 'linear-gradient(135deg, #07172c 0%, #0a2342 55%, #0d3868 100%)',
            borderRadius: 20,
            padding: '36px 36px 32px',
            color: '#ffffff',
            boxShadow: '0 16px 40px rgba(10, 35, 66, 0.16)',
            position: 'relative',
            overflow: 'hidden',
          }}
        >
          {/* Subtle background glow */}
          <div
            style={{
              position: 'absolute',
              top: -60,
              right: -60,
              width: 240,
              height: 240,
              borderRadius: '50%',
              background: 'radial-gradient(circle, rgba(14, 165, 233, 0.25) 0%, transparent 70%)',
              pointerEvents: 'none',
            }}
          />

          <div
            style={{
              display: 'flex',
              alignItems: 'flex-start',
              justifyContent: 'space-between',
              flexWrap: 'wrap',
              gap: 20,
              position: 'relative',
              zIndex: 1,
            }}
          >
            <div>
              <div
                style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: 8,
                  background: 'rgba(255, 255, 255, 0.1)',
                  backdropFilter: 'blur(8px)',
                  padding: '5px 14px',
                  borderRadius: 20,
                  fontSize: '.74rem',
                  fontWeight: 700,
                  letterSpacing: '.06em',
                  textTransform: 'uppercase',
                  color: '#93c5fd',
                  marginBottom: 12,
                  border: '1px solid rgba(255, 255, 255, 0.15)',
                }}
              >
                <Sparkles size={13} style={{ color: '#38bdf8' }} />
                Official Candidate Portal • Emergix Academy
              </div>
              <h1
                style={{
                  fontSize: 'clamp(1.75rem, 3vw, 2.3rem)',
                  fontWeight: 850,
                  letterSpacing: '-.025em',
                  margin: '0 0 10px',
                  color: '#ffffff',
                  lineHeight: 1.2,
                }}
              >
                Welcome back, {displayName}.
              </h1>
              <p
                style={{
                  fontSize: '1rem',
                  color: '#cbd5e1',
                  margin: 0,
                  maxWidth: '680px',
                  lineHeight: 1.6,
                }}
              >
                Your dedicated workspace for the Royal College of Emergency Medicine (RCEM) examinations. Review lecture notes, simulate timed SBA sessions, and track your clinical mastery.
              </p>
            </div>

            {/* Target Diet Widget */}
            <div
              style={{
                background: 'rgba(255, 255, 255, 0.08)',
                backdropFilter: 'blur(10px)',
                border: '1px solid rgba(255, 255, 255, 0.18)',
                borderRadius: 14,
                padding: '16px 20px',
                minWidth: 230,
              }}
            >
              <div
                style={{
                  fontSize: '.7rem',
                  textTransform: 'uppercase',
                  letterSpacing: '.08em',
                  color: '#93c5fd',
                  fontWeight: 800,
                  display: 'flex',
                  alignItems: 'center',
                  gap: 6,
                  marginBottom: 6,
                }}
              >
                <Target size={14} /> RCEM Target Examination
              </div>
              <div style={{ fontSize: '1.25rem', fontWeight: 850, color: '#ffffff' }}>
                MRCEM 2026 Sitting
              </div>
              <div style={{ fontSize: '.76rem', color: '#cbd5e1', marginTop: 4 }}>
                Curriculum Blueprint Aligned
              </div>
            </div>
          </div>

          {/* Quick Action Pills */}
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: 12,
              flexWrap: 'wrap',
              marginTop: 24,
              paddingTop: 20,
              borderTop: '1px solid rgba(255, 255, 255, 0.12)',
              position: 'relative',
              zIndex: 1,
            }}
          >
            <Link
              href="/courses/mrcem-primary"
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 8,
                background: '#0284c7',
                color: '#ffffff',
                fontWeight: 700,
                fontSize: '.86rem',
                padding: '9px 16px',
                borderRadius: 10,
                textDecoration: 'none',
                boxShadow: '0 4px 14px rgba(2, 132, 199, 0.35)',
              }}
            >
              <BookOpen size={15} /> Resume Primary Notes (221 Lessons)
            </Link>

            <Link
              href="/question-bank"
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 8,
                background: '#10b981',
                color: '#ffffff',
                fontWeight: 700,
                fontSize: '.86rem',
                padding: '9px 16px',
                borderRadius: 10,
                textDecoration: 'none',
                boxShadow: '0 4px 14px rgba(16, 185, 129, 0.35)',
              }}
            >
              <Zap size={15} /> Launch SBA Practice (41 Banks)
            </Link>

            <a
              href={mentorUrl}
              target="_blank"
              rel="noopener noreferrer"
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: 8,
                background: 'rgba(255, 255, 255, 0.12)',
                color: '#ffffff',
                fontWeight: 700,
                fontSize: '.86rem',
                padding: '9px 16px',
                borderRadius: 10,
                textDecoration: 'none',
                border: '1px solid rgba(255, 255, 255, 0.2)',
              }}
            >
              <MessageCircle size={15} style={{ color: '#4ade80' }} />
              WhatsApp EM Mentor Desk
            </a>
          </div>
        </div>

        {/* 2. The Two Flagship Tracks Hub */}
        <div>
          <div
            style={{
              display: 'flex',
              alignItems: 'baseline',
              justifyContent: 'space-between',
              marginBottom: 16,
              flexWrap: 'wrap',
              gap: 8,
            }}
          >
            <div>
              <span
                style={{
                  fontSize: '.76rem',
                  fontWeight: 800,
                  textTransform: 'uppercase',
                  letterSpacing: '.08em',
                  color: '#0284c7',
                }}
              >
                Core Examination Tracks
              </span>
              <h2
                style={{
                  fontSize: '1.45rem',
                  fontWeight: 850,
                  color: '#0f172a',
                  margin: '4px 0 0',
                }}
              >
                Your Flagship Learning Hub
              </h2>
            </div>
            <Link
              href="/app/membership"
              style={{
                fontSize: '.86rem',
                color: '#0284c7',
                fontWeight: 700,
                textDecoration: 'none',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 5,
              }}
            >
              Manage Subscriptions <ArrowRight size={14} />
            </Link>
          </div>

          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fit, minmax(360px, 1fr))',
              gap: 24,
            }}
          >
            {/* Track 1: MRCEM PRIMARY */}
            <article
              style={{
                background: '#ffffff',
                borderRadius: 18,
                border: '1px solid #e2e8f0',
                boxShadow: '0 8px 24px rgba(10, 35, 66, 0.06)',
                overflow: 'hidden',
                display: 'flex',
                flexDirection: 'column',
              }}
            >
              <div
                style={{
                  position: 'relative',
                  height: 180,
                  background: '#0a2342',
                  overflow: 'hidden',
                }}
              >
                <img
                  src="/brand/t1.jpg"
                  alt="MRCEM PRIMARY"
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                    opacity: 0.88,
                  }}
                />
                <div
                  style={{
                    position: 'absolute',
                    inset: 0,
                    background: 'linear-gradient(to top, rgba(10, 35, 66, 0.95) 0%, rgba(10, 35, 66, 0.3) 60%, transparent 100%)',
                  }}
                />
                <div
                  style={{
                    position: 'absolute',
                    top: 12,
                    left: 14,
                    background: 'rgba(255, 255, 255, 0.96)',
                    color: '#0a2342',
                    fontSize: '.7rem',
                    fontWeight: 800,
                    letterSpacing: '.06em',
                    padding: '3px 9px',
                    borderRadius: 6,
                    display: 'flex',
                    alignItems: 'center',
                    gap: 5,
                  }}
                >
                  <Brain size={13} style={{ color: '#0284c7' }} />
                  BASIC SCIENCES TRACK
                </div>
                <div
                  style={{
                    position: 'absolute',
                    bottom: 14,
                    left: 16,
                    right: 16,
                  }}
                >
                  <h3
                    style={{
                      fontSize: '1.4rem',
                      fontWeight: 850,
                      color: '#ffffff',
                      margin: 0,
                    }}
                  >
                    MRCEM PRIMARY
                  </h3>
                  <div style={{ color: '#93c5fd', fontSize: '.78rem', marginTop: 2 }}>
                    Anatomy • Physiology • Pharmacology • Pathology
                  </div>
                </div>
              </div>

              <div style={{ padding: '20px 22px', display: 'flex', flexDirection: 'column', flex: 1 }}>
                <p style={{ color: '#475569', fontSize: '.88rem', lineHeight: 1.5, margin: '0 0 16px' }}>
                  Master all 21 basic science modules with 221 structured clinical lecture notes, 269 high-resolution diagrams, and end-of-topic knowledge checks.
                </p>

                {/* Metrics */}
                <div
                  style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(3, 1fr)',
                    gap: 8,
                    background: '#f8fafc',
                    borderRadius: 10,
                    padding: '10px 8px',
                    textAlign: 'center',
                    marginBottom: 18,
                    border: '1px solid #e2e8f0',
                  }}
                >
                  <div>
                    <div style={{ fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>21</div>
                    <div style={{ fontSize: '.68rem', color: '#64748b', fontWeight: 600 }}>Modules</div>
                  </div>
                  <div>
                    <div style={{ fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>221</div>
                    <div style={{ fontSize: '.68rem', color: '#64748b', fontWeight: 600 }}>Lessons</div>
                  </div>
                  <div>
                    <div style={{ fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>269</div>
                    <div style={{ fontSize: '.68rem', color: '#64748b', fontWeight: 600 }}>Figures</div>
                  </div>
                </div>

                <div style={{ marginTop: 'auto', display: 'flex', gap: 10 }}>
                  <Link
                    href="/courses/mrcem-primary"
                    className="btn btn-primary"
                    style={{
                      flex: 1,
                      display: 'inline-flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: 7,
                      fontSize: '.86rem',
                      fontWeight: 750,
                      padding: '10px 14px',
                    }}
                  >
                    Open Curriculum <ArrowRight size={14} />
                  </Link>
                  <Link
                    href="/app/membership"
                    style={{
                      padding: '10px 14px',
                      background: '#f1f5f9',
                      borderRadius: 8,
                      fontSize: '.84rem',
                      fontWeight: 700,
                      color: '#0a2342',
                      textDecoration: 'none',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 5,
                    }}
                  >
                    <MessageCircle size={14} style={{ color: '#25D366' }} /> Subscriptions
                  </Link>
                </div>
              </div>
            </article>

            {/* Track 2: MRCEM SBA */}
            <article
              style={{
                background: '#ffffff',
                borderRadius: 18,
                border: '1px solid #e2e8f0',
                boxShadow: '0 8px 24px rgba(10, 35, 66, 0.06)',
                overflow: 'hidden',
                display: 'flex',
                flexDirection: 'column',
              }}
            >
              <div
                style={{
                  position: 'relative',
                  height: 180,
                  background: '#0a2342',
                  overflow: 'hidden',
                }}
              >
                <img
                  src="/brand/hero.jpg"
                  alt="MRCEM SBA"
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                    opacity: 0.88,
                  }}
                />
                <div
                  style={{
                    position: 'absolute',
                    inset: 0,
                    background: 'linear-gradient(to top, rgba(10, 35, 66, 0.95) 0%, rgba(10, 35, 66, 0.3) 60%, transparent 100%)',
                  }}
                />
                <div
                  style={{
                    position: 'absolute',
                    top: 12,
                    left: 14,
                    background: 'rgba(255, 255, 255, 0.96)',
                    color: '#0a2342',
                    fontSize: '.7rem',
                    fontWeight: 800,
                    letterSpacing: '.06em',
                    padding: '3px 9px',
                    borderRadius: 6,
                    display: 'flex',
                    alignItems: 'center',
                    gap: 5,
                  }}
                >
                  <Stethoscope size={13} style={{ color: '#10b981' }} />
                  QUESTION BANK &amp; MOCKS
                </div>
                <div
                  style={{
                    position: 'absolute',
                    bottom: 14,
                    left: 16,
                    right: 16,
                  }}
                >
                  <h3
                    style={{
                      fontSize: '1.4rem',
                      fontWeight: 850,
                      color: '#ffffff',
                      margin: 0,
                    }}
                  >
                    MRCEM SBA
                  </h3>
                  <div style={{ color: '#a7f3d0', fontSize: '.78rem', marginTop: 2 }}>
                    41 Topical Quizzes • 6 Full Timed Mock Papers
                  </div>
                </div>
              </div>

              <div style={{ padding: '20px 22px', display: 'flex', flexDirection: 'column', flex: 1 }}>
                <p style={{ color: '#475569', fontSize: '.88rem', lineHeight: 1.5, margin: '0 0 16px' }}>
                  Sharpen clinical decision-making with high-yield single-best-answer questions, distractor elimination, and realistic RCEM timed exam simulations.
                </p>

                {/* Metrics */}
                <div
                  style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(3, 1fr)',
                    gap: 8,
                    background: '#f8fafc',
                    borderRadius: 10,
                    padding: '10px 8px',
                    textAlign: 'center',
                    marginBottom: 18,
                    border: '1px solid #e2e8f0',
                  }}
                >
                  <div>
                    <div style={{ fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>41</div>
                    <div style={{ fontSize: '.68rem', color: '#64748b', fontWeight: 600 }}>Topic Banks</div>
                  </div>
                  <div>
                    <div style={{ fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>6</div>
                    <div style={{ fontSize: '.68rem', color: '#64748b', fontWeight: 600 }}>Mock Papers</div>
                  </div>
                  <div>
                    <div style={{ fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>Amboss</div>
                    <div style={{ fontSize: '.68rem', color: '#64748b', fontWeight: 600 }}>Exam Engine</div>
                  </div>
                </div>

                <div style={{ marginTop: 'auto', display: 'flex', gap: 10 }}>
                  <Link
                    href="/question-bank"
                    className="btn btn-primary"
                    style={{
                      flex: 1,
                      display: 'inline-flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: 7,
                      fontSize: '.86rem',
                      fontWeight: 750,
                      padding: '10px 14px',
                      background: '#10b981',
                      borderColor: '#10b981',
                    }}
                  >
                    Open Question Bank <ArrowRight size={14} />
                  </Link>
                  <Link
                    href="/app/membership"
                    style={{
                      padding: '10px 14px',
                      background: '#f1f5f9',
                      borderRadius: 8,
                      fontSize: '.84rem',
                      fontWeight: 700,
                      color: '#0a2342',
                      textDecoration: 'none',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 5,
                    }}
                  >
                    <MessageCircle size={14} style={{ color: '#25D366' }} /> Subscriptions
                  </Link>
                </div>
              </div>
            </article>
          </div>
        </div>

        {/* 3. SBA Practice Modes Launchpad */}
        <div
          style={{
            background: '#ffffff',
            borderRadius: 18,
            padding: '24px 28px',
            border: '1px solid #e2e8f0',
            boxShadow: '0 4px 18px rgba(10, 35, 66, 0.04)',
          }}
        >
          <div style={{ marginBottom: 18 }}>
            <span
              style={{
                fontSize: '.74rem',
                fontWeight: 800,
                textTransform: 'uppercase',
                letterSpacing: '.08em',
                color: '#64748b',
              }}
            >
              Interactive Test Modes
            </span>
            <h3 style={{ fontSize: '1.25rem', fontWeight: 800, color: '#0f172a', margin: '4px 0 0' }}>
              Choose Your Practice Experience
            </h3>
          </div>

          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))',
              gap: 16,
            }}
          >
            {/* Tutor Mode */}
            <Link
              href="/question-bank"
              style={{
                textDecoration: 'none',
                display: 'block',
                background: '#f8fafc',
                border: '1px solid #e2e8f0',
                borderRadius: 12,
                padding: '18px 20px',
                transition: 'border-color 0.2s ease, transform 0.2s ease',
              }}
            >
              <div
                style={{
                  width: 36,
                  height: 36,
                  borderRadius: 10,
                  background: '#dbeafe',
                  color: '#0284c7',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: 12,
                }}
              >
                <HelpCircle size={20} />
              </div>
              <h4 style={{ margin: '0 0 6px', fontSize: '1rem', fontWeight: 800, color: '#0f172a' }}>
                Tutor Mode (Untimed)
              </h4>
              <p style={{ margin: 0, fontSize: '.84rem', color: '#64748b', lineHeight: 1.45 }}>
                See comprehensive clinical explanations and teaching rationales immediately after answering each question.
              </p>
            </Link>

            {/* Timed Exam Mode */}
            <Link
              href="/question-bank"
              style={{
                textDecoration: 'none',
                display: 'block',
                background: '#f8fafc',
                border: '1px solid #e2e8f0',
                borderRadius: 12,
                padding: '18px 20px',
                transition: 'border-color 0.2s ease, transform 0.2s ease',
              }}
            >
              <div
                style={{
                  width: 36,
                  height: 36,
                  borderRadius: 10,
                  background: '#fef3c7',
                  color: '#d97706',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: 12,
                }}
              >
                <Clock size={20} />
              </div>
              <h4 style={{ margin: '0 0 6px', fontSize: '1rem', fontWeight: 800, color: '#0f172a' }}>
                Timed Mock Simulation
              </h4>
              <p style={{ margin: 0, fontSize: '.84rem', color: '#64748b', lineHeight: 1.45 }}>
                180-minute countdown with question flagging and strike-through options under authentic Royal College exam conditions.
              </p>
            </Link>

            {/* Subspecialty Topical Drill */}
            <Link
              href="/courses/mrcem-primary"
              style={{
                textDecoration: 'none',
                display: 'block',
                background: '#f8fafc',
                border: '1px solid #e2e8f0',
                borderRadius: 12,
                padding: '18px 20px',
                transition: 'border-color 0.2s ease, transform 0.2s ease',
              }}
            >
              <div
                style={{
                  width: 36,
                  height: 36,
                  borderRadius: 10,
                  background: '#dcfce7',
                  color: '#15803d',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: 12,
                }}
              >
                <BookOpen size={20} />
              </div>
              <h4 style={{ margin: '0 0 6px', fontSize: '1rem', fontWeight: 800, color: '#0f172a' }}>
                Basic Sciences Syllabus
              </h4>
              <p style={{ margin: 0, fontSize: '.84rem', color: '#64748b', lineHeight: 1.45 }}>
                Study 21 anatomy, physiology, pharmacology, and microbiology modules with 269 high-yield figures.
              </p>
            </Link>
          </div>
        </div>

        {/* 4. Candidate Quick Tools & Account Shortcuts */}
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))',
            gap: 16,
          }}
        >
          <div
            style={{
              background: '#ffffff',
              borderRadius: 14,
              padding: '20px 22px',
              border: '1px solid #e2e8f0',
            }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 8 }}>
              <ShieldCheck size={20} style={{ color: '#0284c7' }} />
              <h4 style={{ margin: 0, fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>
                Course Access &amp; Offers
              </h4>
            </div>
            <p style={{ fontSize: '.82rem', color: '#64748b', margin: '0 0 14px', lineHeight: 1.45 }}>
              Choose WhatsApp-verified subscription packages with instant activation.
            </p>
            <Link
              href="/app/membership"
              className="btn btn-primary"
              style={{
                fontSize: '.82rem',
                padding: '8px 14px',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 6,
              }}
            >
              <MessageCircle size={14} /> View Offers on WhatsApp
            </Link>
          </div>

          <div
            style={{
              background: '#ffffff',
              borderRadius: 14,
              padding: '20px 22px',
              border: '1px solid #e2e8f0',
            }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 8 }}>
              <Compass size={20} style={{ color: '#8b5cf6' }} />
              <h4 style={{ margin: 0, fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>
                Clinical OSCE Stations
              </h4>
            </div>
            <p style={{ fontSize: '.82rem', color: '#64748b', margin: '0 0 14px', lineHeight: 1.45 }}>
              Rehearse clinical neurological examination and communication stations.
            </p>
            <Link
              href="/neurology"
              style={{
                fontSize: '.82rem',
                color: '#0284c7',
                fontWeight: 700,
                textDecoration: 'none',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 4,
              }}
            >
              Open Stations <ArrowRight size={14} />
            </Link>
          </div>

          <div
            style={{
              background: '#ffffff',
              borderRadius: 14,
              padding: '20px 22px',
              border: '1px solid #e2e8f0',
            }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 8 }}>
              <LayoutGrid size={20} style={{ color: '#0f172a' }} />
              <h4 style={{ margin: 0, fontSize: '.95rem', fontWeight: 800, color: '#0f172a' }}>
                Account &amp; Security
              </h4>
            </div>
            <p style={{ fontSize: '.82rem', color: '#64748b', margin: '0 0 14px', lineHeight: 1.45 }}>
              Manage password, active logged-in devices, and candidate profile.
            </p>
            <Link
              href="/app/account"
              style={{
                fontSize: '.82rem',
                color: '#0284c7',
                fontWeight: 700,
                textDecoration: 'none',
                display: 'inline-flex',
                alignItems: 'center',
                gap: 4,
              }}
            >
              Account Settings <ArrowRight size={14} />
            </Link>
          </div>
        </div>
      </div>
    </AppLayout>
  );
}
