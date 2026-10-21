import { useEffect, useMemo, useState } from 'react';
import {
  ArrowLeft,
  BookOpen,
  ChevronDown,
  ChevronRight,
  Lock,
  Search,
  X,
  Zap,
} from 'lucide-react';
import { Link } from 'wouter';
import type { ModuleWithLessons } from '@workspace/api-client-react';

export function checkIsQuiz(lesson: { type?: string; title?: string; slug?: string }) {
  if (lesson.type === 'quiz') return true;
  const t = (lesson.title || '').toLowerCase();
  const s = (lesson.slug || '').toLowerCase();
  return (
    t.includes('quiz') ||
    t.includes('mock') ||
    t.includes('sba') ||
    t.includes('paper') ||
    t.includes('exam') ||
    t.includes('practice') ||
    s.includes('quiz') ||
    s.includes('mock') ||
    s.includes('sba') ||
    s.includes('moka')
  );
}

interface CourseLessonSidebarProps {
  slug: string;
  courseTitle?: string;
  currentLessonId: string;
  modules: ModuleWithLessons[];
  hasAccess: boolean;
  isOpen: boolean;
  isMobileOpen: boolean;
  onCloseMobile: () => void;
}

export function CourseLessonSidebar({
  slug,
  courseTitle,
  currentLessonId,
  modules,
  hasAccess,
  isOpen,
  isMobileOpen,
  onCloseMobile,
}: CourseLessonSidebarProps) {
  const [activeTab, setActiveTab] = useState<'all' | 'quizzes' | 'lectures'>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [openModuleIds, setOpenModuleIds] = useState<Record<string, boolean>>({});

  const allLessons = useMemo(() => modules.flatMap((m) => m.lessons), [modules]);
  const allQuizzes = useMemo(() => allLessons.filter(checkIsQuiz), [allLessons]);
  const allLectures = useMemo(() => allLessons.filter((l) => !checkIsQuiz(l)), [allLessons]);

  const currentIndex = useMemo(
    () => allLessons.findIndex((l) => l.id === currentLessonId || l.slug === currentLessonId),
    [allLessons, currentLessonId]
  );

  // Automatically expand the module containing the current active lesson
  useEffect(() => {
    if (!modules.length) return;
    const currentMod = modules.find((m) =>
      m.lessons.some((l) => l.id === currentLessonId || l.slug === currentLessonId)
    );
    if (currentMod) {
      setOpenModuleIds((prev) => ({ ...prev, [currentMod.id]: true }));
    }
  }, [modules, currentLessonId]);

  // Filter modules and lessons
  const filteredModules = useMemo(() => {
    const q = searchQuery.trim().toLowerCase();
    return modules
      .map((mod) => {
        const filteredLessons = mod.lessons.filter((l) => {
          const isQ = checkIsQuiz(l);
          if (activeTab === 'quizzes' && !isQ) return false;
          if (activeTab === 'lectures' && isQ) return false;
          if (q && !l.title.toLowerCase().includes(q)) return false;
          return true;
        });
        return {
          ...mod,
          lessons: filteredLessons,
        };
      })
      .filter((mod) => mod.lessons.length > 0);
  }, [modules, activeTab, searchQuery]);

  const toggleModule = (modId: string) => {
    setOpenModuleIds((prev) => ({ ...prev, [modId]: !prev[modId] }));
  };

  const progressPercent =
    allLessons.length > 0 && currentIndex >= 0
      ? Math.round(((currentIndex + 1) / allLessons.length) * 100)
      : 0;

  return (
    <>
      {/* Mobile Drawer Backdrop */}
      {isMobileOpen && (
        <div className="lesson-sidebar-backdrop" onClick={onCloseMobile} />
      )}

      {/* Sidebar Panel */}
      <aside
        className={`lesson-curriculum-sidebar ${!isOpen ? 'is-collapsed' : ''} ${
          isMobileOpen ? 'is-open-mobile' : ''
        }`}
        aria-label="Course Curriculum and Quizzes"
      >
        {/* Header */}
        <div className="lesson-sidebar-header">
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              gap: 8,
              marginBottom: 8,
            }}
          >
            <span
              style={{
                fontSize: '.72rem',
                fontWeight: 800,
                textTransform: 'uppercase',
                letterSpacing: '.08em',
                color: '#0284c7',
              }}
            >
              {courseTitle || 'COURSE OUTLINE & QUIZZES'}
            </span>
            <button
              type="button"
              onClick={onCloseMobile}
              className="icon-button"
              style={{ padding: 4, display: isMobileOpen ? 'flex' : 'none' }}
              title="Close outline"
            >
              <X size={16} />
            </button>
          </div>

          <div
            style={{
              display: 'flex',
              alignItems: 'baseline',
              justifyContent: 'space-between',
              marginBottom: 6,
            }}
          >
            <strong style={{ fontSize: '.86rem', color: '#0f172a' }}>
              Item {currentIndex >= 0 ? currentIndex + 1 : 1} of {allLessons.length}
            </strong>
            <span style={{ fontSize: '.76rem', color: '#0284c7', fontWeight: 700 }}>
              {progressPercent}%
            </span>
          </div>

          {/* Progress bar */}
          <div
            style={{
              width: '100%',
              height: 4,
              background: '#e2e8f0',
              borderRadius: 2,
              overflow: 'hidden',
            }}
          >
            <div
              style={{
                width: `${progressPercent}%`,
                height: '100%',
                background: 'linear-gradient(90deg, #0284c7 0%, #10b981 100%)',
                transition: 'width .2s ease',
              }}
            />
          </div>

          {/* Filter Tabs */}
          <div className="lesson-sidebar-tabs">
            <button
              type="button"
              className={`lesson-sidebar-tab ${activeTab === 'all' ? 'active' : ''}`}
              onClick={() => setActiveTab('all')}
            >
              All ({allLessons.length})
            </button>
            <button
              type="button"
              className={`lesson-sidebar-tab ${activeTab === 'quizzes' ? 'active' : ''}`}
              onClick={() => setActiveTab('quizzes')}
            >
              <Zap
                size={12}
                style={{ color: activeTab === 'quizzes' ? '#0284c7' : '#059669' }}
              />
              Quizzes ({allQuizzes.length})
            </button>
            <button
              type="button"
              className={`lesson-sidebar-tab ${activeTab === 'lectures' ? 'active' : ''}`}
              onClick={() => setActiveTab('lectures')}
            >
              <BookOpen size={12} />
              Topics ({allLectures.length})
            </button>
          </div>

          {/* Live Search */}
          <div className="lesson-sidebar-search">
            <Search size={14} style={{ color: '#94a3b8', flexShrink: 0 }} />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Filter quizzes or topics..."
              style={{
                border: 0,
                outline: 'none',
                background: 'transparent',
                fontSize: '.78rem',
                width: '100%',
                color: '#1e293b',
              }}
            />
            {searchQuery && (
              <button
                type="button"
                onClick={() => setSearchQuery('')}
                style={{
                  border: 0,
                  background: 'none',
                  cursor: 'pointer',
                  color: '#94a3b8',
                  padding: 0,
                }}
              >
                <X size={13} />
              </button>
            )}
          </div>
        </div>

        {/* Scrollable Module List */}
        <div className="lesson-sidebar-scroll">
          {filteredModules.length === 0 ? (
            <div
              style={{
                textAlign: 'center',
                padding: '28px 10px',
                color: '#64748b',
                fontSize: '.82rem',
              }}
            >
              No lessons or quizzes matched your search.
            </div>
          ) : (
            filteredModules.map((mod) => {
              const isOpenMod = openModuleIds[mod.id] ?? true;
              const hasActive = mod.lessons.some(
                (l) => l.id === currentLessonId || l.slug === currentLessonId
              );

              return (
                <div
                  key={mod.id}
                  className={`lesson-sidebar-mod-block ${hasActive ? 'has-active' : ''}`}
                >
                  <button
                    type="button"
                    className="lesson-sidebar-mod-btn"
                    onClick={() => toggleModule(mod.id)}
                  >
                    <span
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: 6,
                        flex: 1,
                        minWidth: 0,
                        textAlign: 'left',
                      }}
                    >
                      <span className="mod-chevron">
                        {isOpenMod ? <ChevronDown size={14} /> : <ChevronRight size={14} />}
                      </span>
                      <strong className="mod-title" title={mod.title}>
                        {mod.title}
                      </strong>
                    </span>
                    <span className="mod-count">{mod.lessons.length}</span>
                  </button>

                  {isOpenMod && (
                    <ul className="lesson-sidebar-items-list">
                      {mod.lessons.map((item) => {
                        const isActive =
                          item.id === currentLessonId || item.slug === currentLessonId;
                        const isQ = checkIsQuiz(item);
                        const accessible = hasAccess || item.isFreePreview;

                        return (
                          <li key={item.id}>
                            <Link
                              href={
                                accessible
                                  ? `/courses/${slug}/lessons/${item.slug || item.id}`
                                  : '/app/membership'
                              }
                              className={`lesson-sidebar-item ${
                                isActive ? 'is-active' : ''
                              } ${!accessible ? 'is-locked' : ''}`}
                              onClick={() => {
                                onCloseMobile();
                              }}
                            >
                              <div
                                style={{
                                  display: 'flex',
                                  alignItems: 'center',
                                  gap: 7,
                                  flex: 1,
                                  minWidth: 0,
                                }}
                              >
                                <span className="item-icon">
                                  {isQ ? (
                                    <Zap
                                      size={13}
                                      style={{ color: isActive ? '#0284c7' : '#059669' }}
                                    />
                                  ) : (
                                    <BookOpen
                                      size={13}
                                      style={{ color: isActive ? '#0284c7' : '#64748b' }}
                                    />
                                  )}
                                </span>
                                <span className="item-text" title={item.title}>
                                  {item.title}
                                </span>
                              </div>

                              <div
                                style={{
                                  display: 'flex',
                                  alignItems: 'center',
                                  gap: 5,
                                  flexShrink: 0,
                                }}
                              >
                                {isQ && <span className="badge-quiz">Quiz</span>}
                                {item.isFreePreview && !hasAccess && (
                                  <span className="badge-free">Free</span>
                                )}
                                {!accessible && (
                                  <Lock size={12} style={{ color: '#94a3b8' }} />
                                )}
                              </div>
                            </Link>
                          </li>
                        );
                      })}
                    </ul>
                  )}
                </div>
              );
            })
          )}
        </div>

        {/* Footer */}
        <div className="lesson-sidebar-footer">
          <Link
            href={`/courses/${slug}`}
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              gap: 6,
              fontSize: '.78rem',
              fontWeight: 700,
              color: '#0284c7',
              textDecoration: 'none',
              padding: '6px 12px',
              borderRadius: 6,
              background: '#f0f9ff',
            }}
          >
            <ArrowLeft size={13} /> Full Course Overview
          </Link>
        </div>
      </aside>
    </>
  );
}
