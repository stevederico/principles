# Batch by key, not by offset

**Rule:** When a batch loop changes the column it filters on, page by "key greater than the last one seen" instead of by offset, and stream rows lazily when memory matters.

**Why:** Offset pages skip or repeat rows as the filtered set shrinks while you update it. A key cursor stays correct and each page is an indexed range query. Lazy streaming keeps memory flat for large reads.

**Do:**
```
last = 0
loop: rows = where(departed = true and id > last).order_by(id).limit(200)
      if rows is empty: stop
      update(rows, departed = false); last = max(rows.id)
```

**Don't:** Offset paging while updating the filter column, or loading the whole table into memory.

**Break it when:** A loop that only reads and filters on columns it does not change.

**Source:** https://laravel.com/docs/eloquent, https://laravel.com/docs/collections ; code: src/Illuminate/Database/Concerns/BuildsQueries.php
