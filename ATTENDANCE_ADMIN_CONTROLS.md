# Attendance admin controls (V2)

This V2 keeps the **single check-in / mark-present kiosk flow unchanged**. The update only adds admin controls to Attendance History.

## Admin calendar controls

For a present day, an admin can:

- **Edit** the check-in time.
- **Clear** the attendance. The calendar cell becomes a blank white cell and the day is excluded from both Present and Absent totals.
- **Delete** the attendance record. The record is permanently removed; an eligible working day without a record is then counted as Absent.

A cleared day can be marked present again from the calendar, or the employee can check in again that same day. The app reuses the cleared row rather than creating a duplicate attendance row.

## One-time Supabase migration

Apply:

`supabase/migrations/20260924140000_add_attendance_status.sql`

This adds `attendance.status` with the values `present` and `cleared`. Existing attendance records become `present` automatically.

The existing RLS policy `Admins manage attendance` already permits authenticated admins to update and delete attendance records. The existing storage policy `Admins can delete attendance photos` permits cleanup of attendance photos when a record is cleared or deleted.
