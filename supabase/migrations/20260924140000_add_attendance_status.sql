-- Allow admins to distinguish a normal attendance record from an intentionally cleared day.
-- Cleared days are displayed as blank/white in the admin calendar and are excluded
-- from present and absent totals.

ALTER TABLE public.attendance
  ADD COLUMN IF NOT EXISTS status text NOT NULL DEFAULT 'present';

UPDATE public.attendance
SET status = 'present'
WHERE status IS NULL;

ALTER TABLE public.attendance
  DROP CONSTRAINT IF EXISTS attendance_status_check;

ALTER TABLE public.attendance
  ADD CONSTRAINT attendance_status_check
  CHECK (status IN ('present', 'cleared'));

COMMENT ON COLUMN public.attendance.status IS
  'Attendance state: present for a marked attendance record, cleared for an admin-cleared day.';
