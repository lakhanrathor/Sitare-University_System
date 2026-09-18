-- The bell's own query, served by one index instead of three that miss it.
--
-- It reads a user's notifications newest first. PostgreSQL cannot use
-- created_at as a sort key across a skipped middle column, so
-- (user_id, read, created_at) narrowed to the user and then sorted in memory
-- on every poll — on the table that takes the most writes in this system.
-- (read) on its own served nothing: it is never queried without user_id.
-- (user_id) alone is a prefix of the new index and therefore redundant.
DROP INDEX "notifications_user_id_read_created_at_idx";
DROP INDEX "notifications_read_idx";
DROP INDEX "notifications_user_id_idx";

CREATE INDEX "notifications_user_id_created_at_idx"
  ON "notifications"("user_id", "created_at" DESC);
