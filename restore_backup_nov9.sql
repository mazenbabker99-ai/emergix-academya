-- ==========================================================================
-- RESTORE EXACT BACKUP FROM C:\Users\mazen\Downloads\pdf\backup.sql
-- ==========================================================================

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

\i backup.sql

SET search_path = public;

-- Ensure lesson_images table exists
CREATE TABLE IF NOT EXISTS public.lesson_images (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  filename text NOT NULL,
  mime_type text NOT NULL,
  size_bytes integer NOT NULL,
  data text NOT NULL,
  lesson_id uuid REFERENCES public.lessons(id) ON DELETE SET NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_lesson_images_created_at ON public.lesson_images (created_at DESC);
CREATE INDEX IF NOT EXISTS lesson_images_lesson_idx ON public.lesson_images (lesson_id);

-- Restore Superadmin user Dr. Elmokashfy (elmokashfy93@gmail.com)
INSERT INTO public.users (id, name, email, email_verified, role, status, created_at, updated_at)
VALUES (
  '7dd3e02d-5d12-4342-9b01-3d383e8a7be2',
  'Dr. Elmokashfy',
  'elmokashfy93@gmail.com',
  true,
  'superadmin',
  'active',
  now(),
  now()
) ON CONFLICT (id) DO UPDATE SET role = 'superadmin', status = 'active';

INSERT INTO public.accounts (
  id, user_id, account_id, provider_id,
  access_token, refresh_token, id_token,
  access_token_expires_at, refresh_token_expires_at,
  scope, password, created_at, updated_at
) VALUES (
  'b344af87-51b9-41b9-ae09-cea59151ec77',
  '7dd3e02d-5d12-4342-9b01-3d383e8a7be2',
  '7dd3e02d-5d12-4342-9b01-3d383e8a7be2',
  'credential',
  NULL, NULL, NULL,
  NULL, NULL,
  'df26fece7a8e0dea9a71abd3b7d53d75:36990caee163eccd8d7fb429df5706d3b04d542bf2e9a0d891e1ff729f20eaf8a1390df7049987afc955545b1a717f01f8b57794745d0ae6882fe1c327ca998a',
  'df26fece7a8e0dea9a71abd3b7d53d75:36990caee163eccd8d7fb429df5706d3b04d542bf2e9a0d891e1ff729f20eaf8a1390df7049987afc955545b1a717f01f8b57794745d0ae6882fe1c327ca998a',
  now(),
  now()
) ON CONFLICT (id) DO UPDATE SET password = EXCLUDED.password;

INSERT INTO public.user_profiles (user_id, target_exam, created_at, updated_at)
VALUES (
  '7dd3e02d-5d12-4342-9b01-3d383e8a7be2',
  'MRCEM SBA',
  now(),
  now()
) ON CONFLICT (user_id) DO NOTHING;

DELETE FROM public.auth_lockouts WHERE email = 'elmokashfy93@gmail.com';

INSERT INTO public.course_entitlements (id, user_id, course_id, starts_at, ends_at, created_at, updated_at)
SELECT gen_random_uuid(), '7dd3e02d-5d12-4342-9b01-3d383e8a7be2', id, now(), now() + interval '5 years', now(), now()
FROM public.courses
ON CONFLICT DO NOTHING;
