# Bulk paths skip hooks

**Rule:** Treat bulk update, delete and prune statements as bypassing per-record events and callbacks, and when an invariant needs the hook, use the per-record path or enforce it in the database.

**Why:** A bulk statement never loads the records, so there is nothing to fire events for: observers, touch-parent rules and search-index sync all skip. Packages offer a pause switch for deliberate bulk imports.

**Do:**
```
records.each(r -> r.delete())               # hooks fire, one query each
where(old).delete_all()                     # hooks do NOT fire
import: without_sync(() -> import_many())   # explicit off switch for listeners
```

**Don't:** Counting on a listener to remove files or caches for rows deleted in bulk.

**Break it when:** Speed matters more and the cleanup runs another way (a scheduled sweep).

**Source:** https://laravel.com/docs/eloquent, https://laravel.com/docs/eloquent-relationships, https://laravel.com/docs/scout ; code: src/Illuminate/Database/Eloquent/Builder.php, src/Illuminate/Database/Eloquent/MassPrunable.php, src/Illuminate/Database/Eloquent/Concerns/HasEvents.php
