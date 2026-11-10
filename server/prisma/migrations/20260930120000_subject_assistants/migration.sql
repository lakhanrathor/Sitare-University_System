-- Teaching assistants on a subject. Several per subject is normal, so this is
-- a table rather than a column.
--
-- Cascade on both sides: the row only records a pairing, so it has nothing
-- left to say once either the subject or the person is gone. That is the
-- opposite of Subject.faculty_id, which is SetNull precisely so a subject
-- outlives its lecturer's account.
CREATE TABLE "subject_assistants" (
    "subject_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "subject_assistants_pkey" PRIMARY KEY ("subject_id","user_id")
);

-- The primary key already serves lookups by subject; this serves the other
-- direction, which is how a lecturer's dashboard finds what they assist on.
CREATE INDEX "subject_assistants_user_id_idx" ON "subject_assistants"("user_id");

ALTER TABLE "subject_assistants" ADD CONSTRAINT "subject_assistants_subject_id_fkey"
  FOREIGN KEY ("subject_id") REFERENCES "subjects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "subject_assistants" ADD CONSTRAINT "subject_assistants_user_id_fkey"
  FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
