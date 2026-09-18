-- One move or cancel per period per date, enforced by the database.
--
-- resolveOccurrences keys departures as `dateKey|entryId` in a Map, so a second
-- change against the same period and date silently overwrites the first — and
-- the change list is unsorted, so which one survives is whatever order the
-- database happened to return. Two requests arriving together could both pass
-- the controller's 409 check and both write, leaving a grid that resolves
-- differently on each read.
--
-- The controller check stays: it is what produces a readable "that class has
-- already been moved" instead of a constraint violation. This is the backstop
-- underneath it, for the case the check cannot see.
--
-- Hand-written and invisible to `prisma migrate diff`, like the other
-- constraints here: Prisma cannot express a partial index, so it will neither
-- generate nor drop this one.
--
-- 'extra' is excluded deliberately — an extra class is an addition, and two of
-- them against the same period and date is a legitimate thing to book.
CREATE UNIQUE INDEX "schedule_changes_one_per_entry_date"
  ON "schedule_changes"("entry_id", "date_key")
  WHERE "kind" IN ('move', 'cancel');
