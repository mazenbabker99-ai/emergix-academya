-- ============================================================================
-- DIAGNOSTIC SCRIPT: Run this on Replit to understand why SBA quizzes are missing
-- Copy & paste into: psql "$DATABASE_URL"
-- ============================================================================

\echo '=== 1. COURSE OVERVIEW ==='
SELECT slug, title, status, deleted_at IS NOT NULL as deleted, position
FROM courses
ORDER BY position, title;

\echo ''
\echo '=== 2. MODULE COUNT PER COURSE ==='
SELECT c.slug as course, c.title,
       count(m.id) FILTER (WHERE m.deleted_at IS NULL) as active_modules,
       count(m.id) FILTER (WHERE m.deleted_at IS NOT NULL) as deleted_modules
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id
WHERE c.status = 'published' AND c.deleted_at IS NULL
GROUP BY c.id, c.slug, c.title
ORDER BY c.position;

\echo ''
\echo '=== 3. LESSON COUNT BY TYPE PER COURSE ==='
SELECT c.slug as course,
       count(l.id) FILTER (WHERE l.type='article' AND l.status='published' AND l.deleted_at IS NULL) as articles,
       count(l.id) FILTER (WHERE l.type='quiz'    AND l.status='published' AND l.deleted_at IS NULL) as quizzes,
       count(l.id) FILTER (WHERE l.status='published' AND l.deleted_at IS NULL) as total
FROM courses c
LEFT JOIN modules m ON m.course_id = c.id AND m.deleted_at IS NULL
LEFT JOIN lessons l ON l.module_id = m.id
WHERE c.status = 'published' AND c.deleted_at IS NULL
GROUP BY c.slug
ORDER BY c.slug;

\echo ''
\echo '=== 4. MRCEM-SBA MODULE DETAIL (active only) ==='
SELECT m.id, m.title, m.position,
       count(l.id) FILTER (WHERE l.type='article' AND l.status='published' AND l.deleted_at IS NULL) as articles,
       count(l.id) FILTER (WHERE l.type='quiz'    AND l.status='published' AND l.deleted_at IS NULL) as quizzes
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = (SELECT id FROM courses WHERE slug='mrcem-sba' LIMIT 1)
  AND m.deleted_at IS NULL
GROUP BY m.id, m.title, m.position
ORDER BY m.position, m.title;

\echo ''
\echo '=== 5. MRCEM-SBA DELETED MODULES (may contain missing quizzes) ==='
SELECT m.id, m.title, m.position,
       count(l.id) FILTER (WHERE l.type='quiz' AND l.status='published' AND l.deleted_at IS NULL) as live_quizzes,
       count(l.id) FILTER (WHERE l.type='quiz') as all_quizzes
FROM modules m
LEFT JOIN lessons l ON l.module_id = m.id
WHERE m.course_id = (SELECT id FROM courses WHERE slug='mrcem-sba' LIMIT 1)
  AND m.deleted_at IS NOT NULL
GROUP BY m.id, m.title, m.position
ORDER BY m.position, m.title;

\echo ''
\echo '=== 6. ORPHAN QUIZZES (published quizzes in deleted modules) ==='
SELECT l.slug, l.title, l.status, m.title as module_title, m.deleted_at as module_deleted
FROM lessons l
JOIN modules m ON m.id = l.module_id
WHERE l.type = 'quiz'
  AND l.status = 'published'
  AND l.deleted_at IS NULL
  AND m.deleted_at IS NOT NULL
ORDER BY m.title, l.position
LIMIT 50;

\echo ''
\echo '=== 7. TOTAL QUIZ COUNT ==='
SELECT
  count(*) FILTER (WHERE l.status='published' AND l.deleted_at IS NULL AND m.deleted_at IS NULL) as visible_quizzes,
  count(*) FILTER (WHERE l.status='published' AND l.deleted_at IS NULL AND m.deleted_at IS NOT NULL) as orphaned_quizzes,
  count(*) FILTER (WHERE l.status='published' AND l.deleted_at IS NULL) as total_published_quizzes
FROM lessons l
JOIN modules m ON m.id = l.module_id
WHERE l.type = 'quiz';
