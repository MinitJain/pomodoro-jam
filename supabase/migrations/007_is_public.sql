-- Add is_public column to sessions
-- true  = shows on explore (default, backwards-compatible)
-- false = invite-link only; still visible on explore but locked/limited preview
ALTER TABLE sessions ADD COLUMN IF NOT EXISTS is_public boolean NOT NULL DEFAULT true;

-- Only the host may change room visibility.
-- The existing session_mode_control policy (migration 006) permits jam participants
-- to update other columns; this additional policy restricts is_public to host-only.
CREATE POLICY "sessions_update_is_public_host_only" ON public.sessions
  FOR UPDATE USING (auth.uid() = host_id)
  WITH CHECK (auth.uid() = host_id);
