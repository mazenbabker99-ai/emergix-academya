-- ==========================================================================
-- EMERGENCY RESTORE SCRIPT: Reset Schema & Import backup_1.sql Cleanly
-- ==========================================================================
-- This script drops the public schema cascade and recreates it cleanly.
-- Then imports backup_1.sql from scratch with zero errors or conflicts.
-- ==========================================================================

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

\i backup_1.sql
