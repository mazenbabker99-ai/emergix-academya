DO $$
DECLARE
  v_user_id text := gen_random_uuid()::text;
  v_hash text := 'df26fece7a8e0dea9a71abd3b7d53d75:36990caee163eccd8d7fb429df5706d3b04d542bf2e9a0d891e1ff729f20eaf8a1390df7049987afc955545b1a717f01f8b57794745d0ae6882fe1c327ca998a';
BEGIN
  INSERT INTO users (id, name, email, email_verified, role, status, created_at, updated_at)
  VALUES (v_user_id, 'Dr. Elmokashfy Elnoor', 'elmokashfy93@gmail.com', true, 'superadmin', 'active', now(), now())
  ON CONFLICT (email) DO UPDATE SET
    role = 'superadmin',
    status = 'active',
    email_verified = true,
    updated_at = now()
  RETURNING id INTO v_user_id;

  INSERT INTO accounts (id, user_id, account_id, provider_id, password, created_at, updated_at)
  VALUES (gen_random_uuid()::text, v_user_id, 'elmokashfy93@gmail.com', 'credential', v_hash, now(), now())
  ON CONFLICT (id) DO UPDATE SET password = v_hash, updated_at = now();

  UPDATE accounts SET password = v_hash, updated_at = now()
  WHERE user_id = v_user_id AND provider_id = 'credential';

  INSERT INTO user_profiles (user_id, country, specialty, grade, daily_goal_questions, created_at, updated_at)
  VALUES (v_user_id, 'Sudan', 'Emergency Medicine', 'Consultant', 50, now(), now())
  ON CONFLICT (user_id) DO UPDATE SET specialty = 'Emergency Medicine', grade = 'Consultant', updated_at = now();

  -- Grant access to courses for 5 years
  INSERT INTO course_entitlements (id, user_id, course_id, starts_at, ends_at, created_at, updated_at)
  SELECT gen_random_uuid(), v_user_id, c.id, now(), now() + interval '5 years', now(), now()
  FROM courses c WHERE c.status = 'published' AND c.deleted_at IS NULL
  ON CONFLICT DO NOTHING;
END $$;
