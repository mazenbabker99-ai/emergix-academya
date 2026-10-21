import fs from 'node:fs';
import path from 'node:path';
import { pool } from '@workspace/db';

async function exportDatabase() {
  console.log('====================================================');
  console.log('   EMERGIX ACADEMY - DATABASE EXPORT & INSPECTION   ');
  console.log('====================================================');

  if (!process.env.DATABASE_URL) {
    console.error('Error: DATABASE_URL environment variable is not set.');
    process.exit(1);
  }

  const client = await pool.connect();
  const exportData: Record<string, any> = {
    exportedAt: new Date().toISOString(),
  };

  try {
    console.log('Connected to PostgreSQL successfully.\n');

    // 1. Fetch all tables in public schema
    const tablesRes = await client.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      ORDER BY table_name;
    `);
    const tableNames = tablesRes.rows.map((r: { table_name: string }) => r.table_name);
    console.log(`Found ${tableNames.length} tables in database:`);
    console.log(tableNames.join(', '));
    console.log('----------------------------------------------------');
    exportData.tables = tableNames;

    // 2. Query Courses
    try {
      const coursesRes = await client.query(`
        SELECT id, slug, title, summary, is_free, position, status, created_at, deleted_at
        FROM courses
        ORDER BY position ASC, title ASC;
      `);
      console.log(`\n📚 COURSES (${coursesRes.rows.length} total):`);
      coursesRes.rows.forEach((c: any) => {
        const isDeleted = c.deleted_at ? ' [DELETED]' : '';
        console.log(`  - [${c.status.toUpperCase()}] ${c.title} (slug: '${c.slug}', pos: ${c.position})${isDeleted}`);
      });
      exportData.courses = coursesRes.rows;
    } catch (e: any) {
      console.warn('Could not query courses:', e.message);
    }

    // 3. Query Modules count per course
    try {
      const modulesRes = await client.query(`
        SELECT c.slug as course_slug, c.title as course_title, COUNT(m.id) as module_count
        FROM courses c
        LEFT JOIN modules m ON m.course_id = c.id AND m.deleted_at IS NULL
        GROUP BY c.id, c.slug, c.title, c.position
        ORDER BY c.position ASC;
      `);
      console.log(`\n📂 MODULES PER COURSE:`);
      modulesRes.rows.forEach((m: any) => {
        console.log(`  - ${m.course_title}: ${m.module_count} modules`);
      });
      exportData.modulesPerCourse = modulesRes.rows;
    } catch (e: any) {
      console.warn('Could not query modules:', e.message);
    }

    // 4. Query Lessons count per course
    try {
      const lessonsRes = await client.query(`
        SELECT c.slug as course_slug, c.title as course_title, COUNT(l.id) as lesson_count
        FROM courses c
        LEFT JOIN modules m ON m.course_id = c.id
        LEFT JOIN lessons l ON l.module_id = m.id AND l.status = 'published'
        GROUP BY c.id, c.slug, c.title, c.position
        ORDER BY c.position ASC;
      `);
      console.log(`\n📝 PUBLISHED LESSONS PER COURSE:`);
      lessonsRes.rows.forEach((l: any) => {
        console.log(`  - ${l.course_title}: ${l.lesson_count} lessons`);
      });
      exportData.lessonsPerCourse = lessonsRes.rows;
    } catch (e: any) {
      console.warn('Could not query lessons:', e.message);
    }

    // 5. Query Questions & SBA Quizzes
    try {
      const qCountRes = await client.query(`SELECT COUNT(*) as count FROM questions;`);
      const optCountRes = await client.query(`SELECT COUNT(*) as count FROM question_options;`);
      const quizLessonsRes = await client.query(`
        SELECT COUNT(*) as count FROM lessons 
        WHERE type = 'quiz' OR slug LIKE '%quiz%' OR title ILIKE '%quiz%' OR title ILIKE '%mock%';
      `);

      console.log(`\n🎯 QUESTION BANK & SBA QUIZZES:`);
      console.log(`  - Standalone Questions: ${qCountRes.rows[0].count}`);
      console.log(`  - Question Options: ${optCountRes.rows[0].count}`);
      console.log(`  - SBA Quiz & Mock Lessons: ${quizLessonsRes.rows[0].count}`);

      exportData.questionBankStats = {
        totalQuestions: Number(qCountRes.rows[0].count),
        totalOptions: Number(optCountRes.rows[0].count),
        totalQuizLessons: Number(quizLessonsRes.rows[0].count),
      };
    } catch (e: any) {
      console.warn('Could not query questions/quizzes:', e.message);
    }

    // 6. Query Plans & Pricing
    try {
      const plansRes = await client.query(`
        SELECT p.id, p.slug, p.name, p.description, p.is_featured, p.position, p.access_months, p.status,
               COALESCE(
                 json_agg(
                   json_build_object(
                     'amountMinor', pr.amount_minor, 
                     'currency', pr.currency, 
                     'region', pr.region
                   )
                 ) FILTER (WHERE pr.id IS NOT NULL),
                 '[]'::json
               ) as prices
        FROM plans p
        LEFT JOIN plan_prices pr ON pr.plan_id = p.id
        GROUP BY p.id, p.slug, p.name, p.description, p.is_featured, p.position, p.access_months, p.status
        ORDER BY p.position ASC;
      `);
      console.log(`\n💳 PRICING PLANS (${plansRes.rows.length}):`);
      plansRes.rows.forEach((p: any) => {
        const prices = (p.prices || [])
          .map((pr: any) => (pr.amountMinor != null ? `${pr.currency} ${(pr.amountMinor / 100).toFixed(2)} (${p.access_months || 0}m)` : ''))
          .filter(Boolean)
          .join(' | ');
        console.log(`  - [${p.status || 'draft'}] ${p.name} (slug: '${p.slug}'): ${prices || 'No prices set'}`);
      });
      exportData.plans = plansRes.rows;
    } catch (e: any) {
      console.warn('Could not query plans:', e.message);
    }

    // 7. Query Users
    try {
      const usersRes = await client.query(`
        SELECT id, email, name, role, email_verified, created_at 
        FROM users 
        ORDER BY created_at DESC 
        LIMIT 10;
      `);
      const userTotalRes = await client.query(`SELECT COUNT(*) as count FROM users;`);
      console.log(`\n👥 USERS (Total: ${userTotalRes.rows[0].count}, showing latest ${usersRes.rows.length}):`);
      usersRes.rows.forEach((u: any) => {
        console.log(`  - ${u.name || 'User'} (${u.email}) [${u.role}]`);
      });
      exportData.latestUsers = usersRes.rows;
      exportData.totalUsers = Number(userTotalRes.rows[0].count);
    } catch (e: any) {
      console.warn('Could not query users:', e.message);
    }

    // 8. Generate full JSON export
    const exportPath = path.resolve(process.cwd(), 'replit_db_export.json');
    fs.writeFileSync(exportPath, JSON.stringify(exportData, null, 2), 'utf8');

    console.log('\n====================================================');
    console.log(`✅ Full database summary exported to:`);
    console.log(`   ${exportPath}`);
    console.log('====================================================');
    console.log('To dump the complete raw PostgreSQL schema & all data, run:');
    console.log('   pg_dump "$DATABASE_URL" > replit_database_backup.sql\n');
  } catch (err) {
    console.error('Error during database export:', err);
    process.exit(1);
  } finally {
    client.release();
    await pool.end();
  }
}

exportDatabase();
