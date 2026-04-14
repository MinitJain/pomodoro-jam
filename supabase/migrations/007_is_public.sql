-- Add is_public column to sessions
-- true  = shows on explore (default, backwards-compatible)
-- false = invite-link only; still visible on explore but locked/limited preview
ALTER TABLE sessions ADD COLUMN IF NOT EXISTS is_public boolean NOT NULL DEFAULT true;
