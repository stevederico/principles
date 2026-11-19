# Time-ordered ids

**Rule:** Use identifiers that begin with a timestamp (time-ordered UUID or ULID) for primary keys that live in an index and are exposed publicly, and give each record one unique key plus separate unique indexes rather than a composite primary key.

**Why:** Random ids scatter inserts across the index, while time-ordered ones append in order and sort by creation. A single key per record keeps relations and lookups simple; the framework does not support composite primary keys and points to extra multi-column unique indexes instead.

**Do:**
```
id = time_ordered_uuid()          # or ulid()
unique index(departure, destination)      # not a composite primary key
```

**Don't:** Fully random ids as the clustered key of a write-heavy table.

**Break it when:** Ids that must not reveal creation time, or a pure join table with no identity of its own.

**Source:** https://laravel.com/docs/eloquent, https://laravel.com/docs/strings ; code: src/Illuminate/Database/Eloquent/Concerns/HasUuids.php, src/Illuminate/Database/Eloquent/Concerns/HasUlids.php
