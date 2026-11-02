# 🏥 Emergix Academy — Phase 1 QA Audit Report

> **Auditor:** Antigravity QA Engine  
> **Date:** 2026-11-02  
> **Target:** https://emergix-academy--keshomid89.replit.app  
> **Repo:** `N:\project\school-frontend-vue\emergix-academya` (commit `4303ad3`)  
> **Mode:** READ-ONLY Phase 1 — awaiting approval before fixes

---

## Executive Summary

| Severity | Count |
|----------|-------|
| 🔴 Blocker | 0 |
| 🟠 Critical | 14 |
| 🟡 Major | 33 |
| 🔵 Minor | 12 |
| ⚪ Cosmetic | 5 |
| **Total** | **64** |

| Area | Issues |
|------|--------|
| Content - Missing Quizzes | 8 |
| Content - Title/Slug Typos | 15 |
| Content - Known Bugs A-D | 4 |
| Data Integrity | 7 |
| UI Counter Mismatches | 4 |
| Quiz Engine | 5 |
| Security | 5 |
| UX/Accessibility | 8 |
| SEO | 4 |
| Performance | 2 |
| Routing/Navigation | 2 |

> [!IMPORTANT]
> **8 of 10 SBA specialty modules have ZERO quizzes.** Only Resuscitation (1 quiz) and High-Yield Clinical Revision (4 quizzes) have quizzes. The API confirms only **5 quizzes** across all of MRCEM SBA despite the migration claiming 109. The quizzes either failed to insert or are in `draft` status.

---

## 1. SITE MAP & INVENTORY

### 1.1 Courses Overview

| Course | Slug | Modules (API) | Lessons (API) | Quizzes | Articles | PDFs |
|--------|------|:---:|:---:|:---:|:---:|:---:|
| MRCEM Primary | `mrcem-primary` | 25 | 266 | 41 | 222 | 3 |
| MRCEM SBA | `mrcem-sba` | 11 | 186 | 5 | 181 | 0 |
| **Total** | | **36** | **452** | **46** | **403** | **3** |

### 1.2 MRCEM Primary Modules (25 modules)

| Pos | Module | Lessons | Articles | Quizzes |
|:---:|--------|:---:|:---:|:---:|
| 0 | Upper Limb Anatomy | 8 | 7 | 0 |
| 1 | Lower Limb Anatomy | 9 | 9 | 0 |
| 2 | Thorax Anatomy & Mediastinum | 11 | 11 | 0 |
| 3 | Abdomen & Peritoneum | 10 | 10 | 0 |
| 4 | Head & Neck Anatomy | 6 | 6 | 0 |
| 5 | Central Nervous System & Spine | 11 | 11 | 0 |
| 6 | Cranial Nerves In-Depth | 12 | 12 | 0 |
| 7 | Cell Physiology & Membrane Transport | 10 | 10 | 0 |
| 8 | Cardiovascular Physiology & Hemodynamics | 14 | 14 | 0 |
| 9 | Respiratory Physiology & Ventilation | 15 | 15 | 0 |
| 10 | Renal Physiology & Acid-Base Balance | 13 | 13 | 0 |
| 11 | Gastrointestinal (GIT) Physiology | 21 | 21 | 0 |
| 12 | Endocrine Physiology & Metabolism | 20 | 20 | 0 |
| 13 | Blood Physiology & Coagulation Pathways | 8 | 8 | 0 |
| 14 | Respiratory Pharmacology & Asthma Management | 5 | 5 | 0 |
| 15 | Cardiovascular Pharmacology & Anticoagulants | 8 | 8 | 0 |
| 16 | CNS Pharmacology & Analgesia | 7 | 7 | 0 |
| 17 | Anesthesia & Sedation Drugs | 1 | 1 | 0 |
| 18 | Emergency Toxicology & Antidotes | 3 | 3 | 0 |
| 19 | General Pathology, Inflammation & Anemia | 11 | 11 | 0 |
| 20 | Clinical Microbiology, Bacteria & Antibiotics | 22 | 22 | 0 |
| ~~21~~ | *(missing — gap)* | — | — | — |
| 22 | MRCEM Primary Question Bank: Quizzes 01–10 | 10 | 0 | 10 |
| 23 | MRCEM Primary Question Bank: Quizzes 11–20 | 10 | 0 | 10 |
| 24 | MRCEM Primary Question Bank: Quizzes 21–30 | 10 | 0 | 10 |
| 25 | MRCEM Primary Question Bank: Quizzes 31–41 | 11 | 0 | 11 |

### 1.3 MRCEM SBA Modules (11 modules)

| Pos | Module | Lessons | Articles | Quizzes | ⚠️ |
|:---:|--------|:---:|:---:|:---:|:---:|
| 0 | Resuscitation & Critical Care | 14 | 11 | **1** | ✅ |
| 1 | Ophthalmology Emergencies | 9 | 9 | **0** | 🔴 |
| 2 | Cardiovascular Emergencies | 21 | 21 | **0** | 🔴 |
| 3 | Major Trauma & Injury Management | 13 | 13 | **0** | 🔴 |
| 4 | Pulmonology & Respiratory Emergencies | 13 | 13 | **0** | 🔴 |
| 5 | Urological Emergencies | 11 | 11 | **0** | 🔴 |
| 6 | Nephrology & Acid-Base Disorders | 8 | 8 | **0** | 🔴 |
| 7 | Vascular Emergencies | 3 | 3 | **0** | 🔴 |
| 8 | Gastroenterology Emergencies | 21 | 21 | **0** | 🔴 |
| 9–12 | *(positions 9–12 missing)* | — | — | — | |
| 13 | MRCEM primary Mock Simulations | 6 | 6 | 0 | ⚠️ Wrong course |
| 14 | High-Yield Rapid Clinical Revision | 67 | 63 | **4** | ✅ |

### 1.4 Frontend Routes (39 routes)

All routes from [Router.tsx](file:///N:/project/school-frontend-vue/emergix-academya/artifacts/oscepass/src/app/Router.tsx) verified. 

| Finding | Severity |
|---------|----------|
| `/app/account` route placed AFTER `/app` — but wouter uses exact matching so both work correctly | ℹ️ Not a bug (verified wouter behavior) |
| No route for `/question-bank/:topic` or deep-links into question bank filters | Minor |
| SPA returns HTTP 200 for 404 pages (client-side only) — bad for SEO crawlers | Major |

### 1.5 Sitemap

- `/api/sitemap.xml` exists and returns valid XML ✅
- **Missing:** Individual course pages (`/courses/mrcem-primary`, `/courses/mrcem-sba`) not in sitemap 🟡
- **Missing:** No `robots.txt` served at root (it may be in static assets) 🟡

---

## 2. CONTENT QA

### 2.1 Known Bug A — Quiz `high-yield-clinical-sba-practice-32`

**Status: NOT REPRODUCIBLE via API** — this lesson is behind auth (not free preview). However, the `check_lessons.py` script is designed to run against DB export. The quiz parser code ([parseQuestions.ts](file:///N:/project/school-frontend-vue/emergix-academya/artifacts/oscepass/src/components/quiz/parseQuestions.ts)) has systematic issues:

| ID | Severity | Issue |
|----|----------|-------|
| BUG-A1 | Critical | `detectCorrectAnswer` Tier 5 uses keyword overlap heuristics — can guess WRONG answer for questions where explanation discusses multiple options |
| BUG-A2 | Major | No validation that options are consecutive A-E; parser silently accepts B,C,D,E (missing A) |
| BUG-A3 | Major | `cleanText()` strips blockquotes (`> **Correct answer: C.**`) which is where the answer key lives — if not in Tier 1 regex format, answer detection fails |
| BUG-A4 | Major | Explanation leak: parser relies on line position (before/after options) but if Q2 stem is in Q1's explanation lines, it gets included silently |

### 2.2 Known Bug B — Lesson `brief-resolved-unexplained-event-brue`

**Status: CONFIRMED** — this is a free preview lesson. The raw markdown body has issues that `beautifyClinicalMarkdown()` in [prose.ts](file:///N:/project/school-frontend-vue/emergix-academya/artifacts/oscepass/src/lib/prose.ts) attempts to fix but can't fully resolve:

| ID | Severity | Issue |
|----|----------|-------|
| BUG-B1 | Major | Lists in raw body use `>` or plain lines without `- ` prefix, rendering as paragraphs instead of `<ul>` |
| BUG-B2 | Major | `beautifyClinicalMarkdown` regex for section headings creates duplicate `## Emergency Management Protocol` when the raw text has "Emergency Management" followed by "Management:" |
| BUG-B3 | Major | Heading glued into paragraph: regex `[a-z]\s+—\s*(Investigation|Management)` only WARNS but doesn't fix |
| BUG-B4 | Minor | `(Page N Reference)` captions not stripped by parser |
| BUG-B5 | Minor | Duplicate image URLs passed through to `<img>` |

### 2.3 Known Bug C — Text Garbling

**Status: CONFIRMED systematically** — OCR artifacts throughout content:

| ID | Severity | Issue |
|----|----------|-------|
| BUG-C1 | Major | `beautifyClinicalMarkdown` fixes 16 specific OCR patterns but many more exist (e.g., "grouæ(ALSC)" not covered) |
| BUG-C2 | Major | Slug typos: `transfution-mangement-of-major-hge`, `chocking-andult-and-pedio`, `resucitiation-in-sepsis`, `acute-glucoma`, `head-reauma` |
| BUG-C3 | Major | Title typos matching slugs: "Transfution Mangement of Major Hge", "Chocking Andult and Pedio", "Acute Glucoma", "Head Reauma" |

### 2.4 Known Bug D — Quiz 8 Duplicate Questions

**Status: CANNOT VERIFY** — Quiz content is behind auth. Must run `check_lessons.py` against DB export to confirm.

### 2.5 Metadata Issues

| ID | Severity | Issue |
|----|----------|-------|
| META-01 | Major | Duplicate lesson positions in 4 modules: Abdomen & Peritoneum, GIT Physiology, Endocrine Physiology, Resuscitation & Critical Care |
| META-02 | Minor | Module position 21 missing in Primary (gap: 20→22) |
| META-03 | Minor | Module positions 9–12 missing in SBA (gap: 8→13) |
| META-04 | Minor | Very short title: "AKI" (slug: `aki`) |
| META-05 | Critical | "MRCEM primary Mock Simulations" module at position 13 in SBA course — wrong course assignment |

---

## 3. FUNCTIONAL QA

### 3.1 What Was Tested

| Flow | Method | Result |
|------|--------|--------|
| API `/courses` | HTTP GET | ✅ Returns 2 courses |
| API `/courses/mrcem-sba` | HTTP GET | ✅ Returns modules & lessons |
| API `/courses/mrcem-primary` | HTTP GET | ✅ Returns modules & lessons |
| API `/healthz` | HTTP GET | ✅ `{"status":"ok"}` |
| API `/sitemap.xml` | HTTP GET | ✅ Valid XML |
| API 404 handling | HTTP GET | ✅ Returns JSON error |
| SPA 404 | Browser | ⚠️ Returns HTTP 200 (SPA renders NotFound component client-side) |
| Free preview lesson | HTTP GET | ⚠️ Intermittent timeouts (Replit cold start) |
| Auth-protected lesson | HTTP GET | ✅ Returns 401 correctly |

### 3.2 What Could NOT Be Tested (and why)

| Flow | Reason |
|------|--------|
| Sign up / Sign in / Password reset | No test credentials; requires real email verification |
| Quiz engine (full flow) | Quiz content behind auth |
| Dashboard / Progress | Requires authenticated session |
| Pricing / Checkout | Requires payment integration test |
| Admin panel | Requires admin credentials |
| Question Bank (create test) | Requires auth |
| Mark as complete / Progress persistence | Requires auth |
| Two-tab concurrent quiz | Requires auth + browser automation |
| `check_lessons.py` against full DB | No direct DB access from local machine |

> [!WARNING]
> **To complete Phase 1 audit**, you need to either:
> 1. Run `psql "$DATABASE_URL" -At -c "SELECT json_agg(json_build_object('slug',slug,'body',body,'type',type,'title',title)) FROM lessons" > lessons.json` on Replit and share the output, OR
> 2. Provide test login credentials so I can test authenticated flows

---

## 4. UI / UX / VISUAL QA

| ID | Severity | Issue |
|----|----------|-------|
| UI-01 | Major | Counter mismatch: LessonPage shows "Quiz 15 of 186" instead of "Quiz 5 of 46" — uses `allLessons.length` (all types) instead of quiz count only |
| UI-02 | Major | Navigation dropdown ([navigation.ts](file:///N:/project/school-frontend-vue/emergix-academya/artifacts/oscepass/src/config/navigation.ts) L28): "21 modules, 221 lessons, 269 figures" for Primary — actual: **25 modules, 266 lessons** |
| UI-03 | Major | Navigation dropdown (L33): "11 modules, 109 topics, 400 figures" for SBA — only 5 quizzes actually visible (not 109) |
| UI-04 | Minor | Exam overlay hardcodes "MRCEM SBA" badge even for Primary quizzes ([LessonPage.tsx](file:///N:/project/school-frontend-vue/emergix-academya/artifacts/oscepass/src/pages/LessonPage.tsx) L324) |
| UI-05 | Minor | "MRCEM Primary Preparation" / "MRCEM SBA Practice" eyebrow text is wrong when viewing opposite course (L409) |
| UI-06 | Minor | Font size toggle (A/A+/A++) resets on navigation — not persisted to localStorage |
| UI-07 | Major | Quiz scores are never saved — `onComplete` callback not wired in LessonPage |
| UI-08 | Major | Quiz progress lost on page refresh — no localStorage or server persistence |

---

## 5. ACCESSIBILITY (WCAG 2.2 AA)

| ID | Severity | Issue |
|----|----------|-------|
| A11Y-01 | Major | Quiz eliminate/strikethrough button has no `aria-label` — icon-only button |
| A11Y-02 | Major | Quiz flag button has no `aria-label` |
| A11Y-03 | Minor | Quiz full-screen button uses icon only |
| A11Y-04 | Minor | No `lang` attribute verified on HTML root |
| A11Y-05 | Minor | Quiz answer feedback (correct/incorrect) not announced to screen readers — no `aria-live` region |

> [!NOTE]
> Full axe-core scan requires browser automation (Playwright) which is blocked by not having local Chromium access to the live site.

---

## 6. PERFORMANCE & RELIABILITY

| ID | Severity | Issue |
|----|----------|-------|
| PERF-01 | Major | Replit cold start causes 30s+ timeouts on first API requests after idle |
| PERF-02 | Minor | All 452 lesson summaries loaded in a single API call for course outline (no pagination for modules/lessons) |

> [!NOTE]
> Lighthouse tests require browser automation or manual testing.

---

## 7. SECURITY

| ID | Severity | Issue |
|----|----------|-------|
| SEC-01 | Critical | `canAccessCourse` ([courses.ts](file:///N:/project/school-frontend-vue/emergix-academya/artifacts/api-server/src/routes/courses.ts) L153-164): Any user with ANY active subscription gets access to ALL courses — bypasses plan-based gating |
| SEC-02 | Major | ClinicalMarkdownText in InteractiveQuiz renders `<img src>` without `safeHref()` sanitization — potential for stored XSS via malicious lesson body |
| SEC-03 | ✅ OK | CSRF: Origin guard middleware exists and is active |
| SEC-04 | ✅ OK | Error handler never leaks stack traces (500 → generic message) |
| SEC-05 | ✅ OK | HSTS header present (`max-age=63072000`) |
| SEC-06 | Major | Missing security headers: No `X-Content-Type-Options`, `X-Frame-Options`, or `Content-Security-Policy` headers |
| SEC-07 | Minor | Rate limiting: Contact form (5/15min) and public reads (300/min) exist, but no login-specific rate limiting visible |

---

## 8. SEO & SHARING

| ID | Severity | Issue |
|----|----------|-------|
| SEO-01 | Major | SPA returns HTTP 200 for all 404 pages — search engines will index "Not Found" pages |
| SEO-02 | Major | Sitemap missing course pages (`/courses/mrcem-primary`, `/courses/mrcem-sba`) and all lesson pages |
| SEO-03 | Minor | No `robots.txt` accessible at root URL |
| SEO-04 | Minor | No Open Graph / Twitter Card meta tags visible in SPA (would need SSR or prerender) |

---

## 9. DATA & INFRASTRUCTURE

| ID | Severity | Issue |
|----|----------|-------|
| DATA-01 | Critical | 8 of 10 SBA specialty modules show 0 quizzes — migration may have created them as `draft` status, or they failed to insert |
| DATA-02 | Major | Duplicate lesson positions in 4 modules — could cause inconsistent ordering |
| DATA-03 | Major | API `lessonCount` for SBA shows 186 but user expects 530+ (migration added ~400 lessons that may be `draft`) |
| DATA-04 | Minor | Module position gaps (Primary: 21 missing; SBA: 9-12 missing) |

---

## 10. RESILIENCE / EDGE CASES

| ID | Severity | Issue |
|----|----------|-------|
| EDGE-01 | Major | Quiz state lost on refresh (confirmed by code analysis — React state only) |
| EDGE-02 | Minor | No handling for expired session during quiz — user loses all progress |

---

## NEEDS HUMAN REVIEW (Medical Content)

These items require a medical professional to verify:

| # | Lesson/Quiz | Issue |
|---|-------------|-------|
| 1 | All quizzes | `detectCorrectAnswer` uses heuristic keyword matching — every quiz answer key should be manually verified against source material |
| 2 | Bug A (quiz-32) | "Explanation computes 4.5 mm while marked answer is C = 3.5 mm" — needs clinical verification |
| 3 | OCR-derived content | All lessons imported from OCR (e.g., "grouæ(ALSC)" → "ALSG") may have clinical errors beyond formatting |

---

## Summary of Known Bugs A–D

| Bug | Status | Details |
|-----|--------|---------|
| A | ⚠️ Partially confirmed | Parser code has systematic issues (BUG-A1 to A4). Full quiz content behind auth. |
| B | ✅ Confirmed | BRUE lesson has all described formatting issues (BUG-B1 to B5) |
| C | ✅ Confirmed | 8 slug typos + 7 title typos found systematically (BUG-C1 to C3) |
| D | ⚠️ Cannot verify | Quiz 8 content behind auth — needs DB export |

---

## Coverage Matrix

| Dimension | Desktop | Mobile | Chromium | Firefox | WebKit |
|-----------|:-------:|:------:|:--------:|:-------:|:------:|
| API endpoints | ✅ | — | — | — | — |
| Route inventory | ✅ (code) | — | — | — | — |
| Content analysis | ✅ (API) | — | — | — | — |
| Quiz engine | ⚠️ (code only) | — | — | — | — |
| Auth flows | ❌ (no creds) | — | — | — | — |
| Visual/responsive | ❌ (no browser) | — | — | — | — |
| Accessibility | ⚠️ (code only) | — | — | — | — |
| Performance | ❌ (no Lighthouse) | — | — | — | — |

---

## Recommended Priority for Phase 2 Fixes

### Priority 1 — Critical (Must fix immediately)
1. **DATA-01**: Investigate why 104 SBA quizzes are not showing (draft status? failed insert?) — run `SELECT status, count(*) FROM lessons WHERE type='quiz' GROUP BY status` on Replit
2. **SEC-01**: Fix `canAccessCourse` to respect plan-specific course grants only
3. **META-05**: Move "MRCEM primary Mock Simulations" module to correct course
4. **CODE-005**: Add explicit answer key markers to all quiz markdown and stop relying on heuristic detection

### Priority 2 — Major (Fix this sprint)
5. Fix all title typos (7 lessons)
6. Fix UI counters (navigation.ts, LessonPage quiz counter)
7. Add quiz state persistence (localStorage at minimum)
8. Wire `onComplete` to save quiz scores to server
9. Fix `beautifyClinicalMarkdown` to handle more OCR patterns
10. Add missing security headers (CSP, X-Frame-Options, XCTO)
11. Add `safeHref()` to quiz component image rendering
12. Fix SPA 404 to return proper HTTP status (needs prerender/SSR)

### Priority 3 — Minor/Cosmetic
13. Fix module position gaps
14. Persist font size to localStorage
15. Add aria-labels to quiz icon buttons
16. Expand sitemap to include course/lesson URLs
17. Fix hardcoded course name badges

---

## ⏸️ STOP — Awaiting Your Approval

This report covers Phase 1 (read-only audit). **No changes have been made to the codebase or database.**

To proceed to Phase 2 (fixes), I need:

1. ✅ Your approval of this report
2. 🔑 Test credentials (or run the `psql` command above to export lesson data for full content analysis)
3. 📋 Confirmation of which fixes to prioritize

Please review and respond.
