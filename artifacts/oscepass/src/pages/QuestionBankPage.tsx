import { useMemo, useState } from 'react';
import {
  ArrowRight,
  BookOpen,
  CheckCircle2,
  Clock3,
  HelpCircle,
  Play,
  RotateCcw,
  Search,
  Sparkles,
  Stethoscope,
  Target,
  Trophy,
} from 'lucide-react';
import { Link } from 'wouter';
import { useGetCourse } from '@workspace/api-client-react';
import { PageHero } from '@/components/shared/PageHero';
import { PageSkeleton } from '@/components/shared/DataState';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { usePageMeta } from '@/lib/usePageMeta';

export default function QuestionBankPage() {
  usePageMeta(
    'MRCEM SBA Question Bank & Mock Simulations',
    'High-yield single-best-answer practice questions, topical quizzes, and full Royal College mock exams with clinical explanations.'
  );

  const [activeTab, setActiveTab] = useState<'all' | 'topics' | 'mocks'>('all');
  const [searchQuery, setSearchQuery] = useState('');

  // Fetch the flagship MRCEM SBA question bank course (which holds all 47 quizzes)
  const sbaCourse = useGetCourse('mrcem-sba');
  const allModules = sbaCourse.data?.modules ?? [];

  const allQuizzes = useMemo(() => {
    return allModules.flatMap((mod) =>
      mod.lessons.map((lesson) => ({
        ...lesson,
        moduleTitle: mod.title,
        isMock:
          /mock|paper|exam|simulation/i.test(lesson.title) ||
          /mock|paper|exam/i.test(mod.title),
      }))
    );
  }, [allModules]);

  const filteredQuizzes = useMemo(() => {
    return allQuizzes.filter((item) => {
      const matchSearch =
        item.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.moduleTitle.toLowerCase().includes(searchQuery.toLowerCase());
      if (!matchSearch) return false;

      if (activeTab === 'topics') return !item.isMock;
      if (activeTab === 'mocks') return item.isMock;
      return true;
    });
  }, [allQuizzes, activeTab, searchQuery]);

  const mockCount = allQuizzes.filter((q) => q.isMock).length;
  const topicCount = allQuizzes.filter((q) => !q.isMock).length;

  return (
    <SiteLayout>
      <main>
        <PageHero
          eyebrow="RCEM SBA Practice Engine"
          title="Single Best Answer (SBA) Question Bank &amp; Mocks"
          intro="Master the decisions you make in emergency practice. Filter by curriculum topic, test yourself with instant tutor feedback, or simulate timed Royal College exam conditions."
        />

        <section className="section" style={{ background: '#f3f8ff', padding: '38px 0 72px' }}>
          <div className="container" style={{ maxWidth: '1100px' }}>
            {/* Top Stats Cards */}
            <div
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))',
                gap: 16,
                marginBottom: 32,
              }}
            >
              <div
                style={{
                  background: '#ffffff',
                  borderRadius: 14,
                  padding: '20px 24px',
                  border: '1px solid #dbe7f3',
                  boxShadow: '0 4px 14px rgba(10,35,66,0.04)',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: 10, color: '#0066cc', marginBottom: 8 }}>
                  <HelpCircle size={22} />
                  <span style={{ fontSize: '.84rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '.04em' }}>
                    Total SBA Quizzes
                  </span>
                </div>
                <div style={{ fontSize: '1.85rem', fontWeight: 850, color: '#0a2342' }}>
                  {allQuizzes.length || 47}
                </div>
                <p style={{ margin: '4px 0 0', fontSize: '.84rem', color: '#64748b' }}>
                  Aligned 100% with the RCEM curriculum
                </p>
              </div>

              <div
                style={{
                  background: '#ffffff',
                  borderRadius: 14,
                  padding: '20px 24px',
                  border: '1px solid #dbe7f3',
                  boxShadow: '0 4px 14px rgba(10,35,66,0.04)',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: 10, color: '#16a34a', marginBottom: 8 }}>
                  <Target size={22} />
                  <span style={{ fontSize: '.84rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '.04em' }}>
                    Topical SBA Sets
                  </span>
                </div>
                <div style={{ fontSize: '1.85rem', fontWeight: 850, color: '#0a2342' }}>
                  {topicCount || 41}
                </div>
                <p style={{ margin: '4px 0 0', fontSize: '.84rem', color: '#64748b' }}>
                  Organized by body system &amp; specialty
                </p>
              </div>

              <div
                style={{
                  background: '#ffffff',
                  borderRadius: 14,
                  padding: '20px 24px',
                  border: '1px solid #dbe7f3',
                  boxShadow: '0 4px 14px rgba(10,35,66,0.04)',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: 10, color: '#7c3aed', marginBottom: 8 }}>
                  <Trophy size={22} />
                  <span style={{ fontSize: '.84rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '.04em' }}>
                    Full Mock Exam Papers
                  </span>
                </div>
                <div style={{ fontSize: '1.85rem', fontWeight: 850, color: '#0a2342' }}>
                  {mockCount || 6}
                </div>
                <p style={{ margin: '4px 0 0', fontSize: '.84rem', color: '#64748b' }}>
                  Timed full exam simulation papers
                </p>
              </div>
            </div>

            {/* Quick Practice Mode Card */}
            <div
              style={{
                background: 'linear-gradient(135deg, #0a2342 0%, #0052a3 100%)',
                borderRadius: 16,
                padding: '26px 30px',
                color: '#ffffff',
                marginBottom: 32,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                flexWrap: 'wrap',
                gap: 20,
              }}
            >
              <div>
                <span
                  style={{
                    background: 'rgba(255,255,255,0.2)',
                    color: '#ffffff',
                    borderRadius: 20,
                    padding: '3px 12px',
                    fontSize: '.72rem',
                    fontWeight: 800,
                    textTransform: 'uppercase',
                    letterSpacing: '.06em',
                  }}
                >
                  Custom Practice Session
                </span>
                <h3 style={{ fontSize: '1.35rem', fontWeight: 800, margin: '8px 0 6px', color: '#ffffff' }}>
                  Want to practice specific topics with custom question counts?
                </h3>
                <p style={{ margin: 0, color: '#dbeafe', fontSize: '.9rem', maxWidth: '600px' }}>
                  Use our interactive session builder to select specific clinical topics, question quantities, and Tutor vs Timed modes.
                </p>
              </div>
              <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
                <Link
                  href="/app/qbank/new"
                  className="btn btn-primary"
                  style={{ background: '#ffffff', color: '#0a2342', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: 8 }}
                >
                  <Stethoscope size={16} /> Build Custom Session <ArrowRight size={15} />
                </Link>
                <Link
                  href="/free-demo"
                  className="btn btn-outline"
                  style={{ borderColor: 'rgba(255,255,255,0.4)', color: '#ffffff', display: 'inline-flex', alignItems: 'center', gap: 6 }}
                >
                  <Sparkles size={15} /> Free Sample Demo
                </Link>
              </div>
            </div>

            {/* Search and Filter Controls */}
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                flexWrap: 'wrap',
                gap: 16,
                marginBottom: 24,
              }}
            >
              <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
                <button
                  type="button"
                  onClick={() => setActiveTab('all')}
                  style={{
                    padding: '8px 18px',
                    borderRadius: 20,
                    border: 0,
                    fontWeight: 700,
                    fontSize: '.86rem',
                    cursor: 'pointer',
                    background: activeTab === 'all' ? '#0066cc' : '#ffffff',
                    color: activeTab === 'all' ? '#ffffff' : '#334155',
                    boxShadow: '0 2px 6px rgba(0,0,0,0.05)',
                  }}
                >
                  All Quizzes ({allQuizzes.length || 47})
                </button>
                <button
                  type="button"
                  onClick={() => setActiveTab('topics')}
                  style={{
                    padding: '8px 18px',
                    borderRadius: 20,
                    border: 0,
                    fontWeight: 700,
                    fontSize: '.86rem',
                    cursor: 'pointer',
                    background: activeTab === 'topics' ? '#0066cc' : '#ffffff',
                    color: activeTab === 'topics' ? '#ffffff' : '#334155',
                    boxShadow: '0 2px 6px rgba(0,0,0,0.05)',
                  }}
                >
                  Topical SBA Quizzes ({topicCount || 41})
                </button>
                <button
                  type="button"
                  onClick={() => setActiveTab('mocks')}
                  style={{
                    padding: '8px 18px',
                    borderRadius: 20,
                    border: 0,
                    fontWeight: 700,
                    fontSize: '.86rem',
                    cursor: 'pointer',
                    background: activeTab === 'mocks' ? '#0066cc' : '#ffffff',
                    color: activeTab === 'mocks' ? '#ffffff' : '#334155',
                    boxShadow: '0 2px 6px rgba(0,0,0,0.05)',
                  }}
                >
                  Full Mock Exams ({mockCount || 6})
                </button>
              </div>

              <div style={{ position: 'relative', minWidth: '260px' }}>
                <Search size={16} color="#94a3b8" style={{ position: 'absolute', left: 12, top: 11 }} />
                <input
                  type="text"
                  placeholder="Search quizzes or topics..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  style={{
                    width: '100%',
                    padding: '8px 12px 8px 36px',
                    borderRadius: 20,
                    border: '1px solid #cbd5e1',
                    fontSize: '.86rem',
                    background: '#ffffff',
                  }}
                />
              </div>
            </div>

            {/* Quiz List */}
            {sbaCourse.isLoading ? (
              <PageSkeleton rows={4} label="Loading Question Bank" />
            ) : filteredQuizzes.length === 0 ? (
              <div
                style={{
                  background: '#ffffff',
                  padding: '48px',
                  borderRadius: 16,
                  textAlign: 'center',
                  border: '1px solid #e2e8f0',
                }}
              >
                <HelpCircle size={40} color="#94a3b8" style={{ margin: '0 auto 12px' }} />
                <h3 style={{ color: '#0a2342', margin: '0 0 6px' }}>No quizzes match your filter</h3>
                <p style={{ color: '#64748b', fontSize: '.9rem', margin: 0 }}>
                  Try a different search term or switch tabs to explore more questions.
                </p>
              </div>
            ) : (
              <div
                style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))',
                  gap: 18,
                }}
              >
                {filteredQuizzes.map((quiz, index) => {
                  const href = `/courses/mrcem-sba/lessons/${quiz.slug || quiz.id}`;
                  return (
                    <article
                      key={quiz.id || index}
                      style={{
                        background: '#ffffff',
                        borderRadius: 14,
                        border: '1px solid #dbe7f3',
                        padding: '20px 22px',
                        boxShadow: '0 4px 12px rgba(10,35,66,0.03)',
                        display: 'flex',
                        flexDirection: 'column',
                        justifyContent: 'space-between',
                        transition: 'transform .15s ease, box-shadow .15s ease',
                      }}
                    >
                      <div>
                        <div
                          style={{
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'space-between',
                            marginBottom: 10,
                          }}
                        >
                          <span
                            style={{
                              fontSize: '.72rem',
                              fontWeight: 800,
                              textTransform: 'uppercase',
                              letterSpacing: '.05em',
                              padding: '2px 8px',
                              borderRadius: 12,
                              background: quiz.isMock ? '#f3e8ff' : '#eff6ff',
                              color: quiz.isMock ? '#7c3aed' : '#0066cc',
                            }}
                          >
                            {quiz.isMock ? 'Mock Simulation' : 'Topical SBA'}
                          </span>
                          {quiz.isFreePreview && (
                            <span
                              style={{
                                fontSize: '.68rem',
                                fontWeight: 700,
                                padding: '2px 8px',
                                borderRadius: 12,
                                background: '#dcfce7',
                                color: '#15803d',
                              }}
                            >
                              Free Preview
                            </span>
                          )}
                        </div>

                        <h3
                          style={{
                            fontSize: '1.08rem',
                            fontWeight: 750,
                            color: '#0a2342',
                            margin: '0 0 6px',
                            lineHeight: 1.4,
                          }}
                        >
                          {quiz.title}
                        </h3>

                        <p
                          style={{
                            fontSize: '.82rem',
                            color: '#64748b',
                            margin: '0 0 16px',
                          }}
                        >
                          Section: <strong>{quiz.moduleTitle}</strong>
                        </p>
                      </div>

                      <div
                        style={{
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'space-between',
                          paddingTop: 12,
                          borderTop: '1px solid #f1f5f9',
                        }}
                      >
                        <span
                          style={{
                            fontSize: '.78rem',
                            color: '#64748b',
                            display: 'inline-flex',
                            alignItems: 'center',
                            gap: 4,
                          }}
                        >
                          <CheckCircle2 size={13} color="#16a34a" /> Interactive SBA
                        </span>

                        <Link
                          href={href}
                          className="btn btn-primary"
                          style={{
                            padding: '6px 14px',
                            fontSize: '.82rem',
                            fontWeight: 700,
                            display: 'inline-flex',
                            alignItems: 'center',
                            gap: 6,
                          }}
                        >
                          <Play size={13} /> Start Quiz
                        </Link>
                      </div>
                    </article>
                  );
                })}
              </div>
            )}
          </div>
        </section>
      </main>
    </SiteLayout>
  );
}
