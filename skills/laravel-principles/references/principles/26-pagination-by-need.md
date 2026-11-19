# Pagination by need

**Rule:** Choose the paging mode by what the screen shows: totals need a count query, previous/next needs none, and large or fast-changing lists use a cursor.

**Why:** A total costs an extra count query. Previous/next can fetch one extra row to know if more exist. Offset paging scans skipped rows and can skip or repeat rows while data changes; a cursor compares against the last seen key.

**Do:**
```
with_totals: count(); rows = query.offset(...).limit(n)
prev_next:   rows = query.offset(...).limit(n + 1); has_more = len(rows) > n
cursor:      rows = query.where(key > last_key).order_by(key).limit(n)     # unique, non-null ordering
```

**Don't:** Offset with page numbers on a huge, constantly written table. A cursor without a unique ordering (the framework throws).

**Break it when:** The UI must show "page 7 of 40" or jump to a page: accept offset and the count.

**Source:** https://laravel.com/docs/pagination ; code: src/Illuminate/Database/Query/Builder.php, src/Illuminate/Database/Eloquent/Builder.php
