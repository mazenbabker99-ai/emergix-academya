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

    // 2. Query Courses
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

    // 3. Query Modules count per course
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

    // 4. Query Lessons count per course
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

    // 5. Query Questions and Question Bank stats
    const qCountRes = await client.query(`SELECT COUNT(*) as count FROM questions;`);
    const optCountRes = await client.query(`SELECT COUNT(*) as count FROM question_options;`);
    console.log(`\n🎯 QUESTION BANK:`);
    console.log(`  - Total Questions: ${qCountRes.rows[0].count}`);
    console.log(`  - Total Options: ${optCountRes.rows[0].count}`);

    // 6. Query Plans & Pricing
    const plansRes = await client.query(`
      SELECT p.id, p.slug, p.name, p.description, p.is_featured,
             json_agg(json_build_object('label', pr.label, 'amountMinor', pr.amount_minor, 'currency', pr.currency)) as prices
      FROM plans p
      LEFT JOIN plan_prices pr ON pr.plan_id = p.id
      GROUP BY p.id, p.slug, p.name, p.description, p.is_featured, p.sort_order
      ORDER BY p.sort_order ASC;
    `);
    console.log(`\n💳 PRICING PLANS (${plansRes.rows.length}):`);
    plansRes.rows.forEach((p: any) => {
      const prices = (p.prices || []).map((pr: any) => pr ? `${pr.label}: $${(pr.amountMinor / 100).toFixed(2)}` : '').filter(Boolean).join(' | ');
      console.log(`  - ${p.name} (slug: '${p.slug}'): ${prices || 'No prices set'}`);
    });

    // 7. Query Users
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

    // 8. Generate full JSON export
    const fullExport = {
      exportedAt: new Date().toISOString(),
      summary: {
        totalCourses: coursesRes.rows.length,
        totalQuestions: Number(qCountRes.rows[0].count),
        totalUsers: Number(userTotalRes.rows[0].count),
      },
      courses: coursesRes.rows,
      modulesPerCourse: modulesRes.rows,
      lessonsPerCourse: lessonsRes.rows,
      plans: plansRes.rows,
      latestUsers: usersRes.rows,
    };

    const exportPath = path.resolve(process.cwd(), 'replit_db_export.json');
    fs.writeFileSync(exportPath, JSON.stringify(fullExport, null, 2), 'utf8');

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
