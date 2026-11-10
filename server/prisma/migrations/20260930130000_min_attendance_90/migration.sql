-- The attendance requirement is 90%, not 75%.
--
-- Subjects already created under the old default move with it; one an admin
-- deliberately set to some other figure keeps it, which is why this is not a
-- blanket UPDATE.
ALTER TABLE "subjects" ALTER COLUMN "min_attendance" SET DEFAULT 90;

UPDATE "subjects" SET "min_attendance" = 90 WHERE "min_attendance" = 75;
