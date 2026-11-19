# Soft deletes as a default filter

**Rule:** When deleted rows must be recoverable, mark them with a deletion timestamp, hide them from every query through one default filter, and make seeing them, restoring them and removing them permanently separate explicit verbs.

**Why:** Recovery is possible and no query leaks deleted data by forgetting a condition. The default filter lives in one place, so callers cannot drift. Related checks must be told about it: uniqueness rules count soft-deleted rows unless they are excluded.

**Do:**
```
delete(): set deleted_at = now
default filter on every query: deleted_at is null
with_trashed(); only_trashed(); restore(); force_delete()
unique(email).without_trashed()
```

**Don't:** Writing the null-check by hand in each query, or expecting a soft delete to free a value that a uniqueness rule still sees.

**Break it when:** Rows that must really disappear: use the permanent-removal verb or prune them.

**Source:** https://laravel.com/docs/eloquent, https://laravel.com/docs/validation ; code: src/Illuminate/Database/Eloquent/SoftDeletes.php, src/Illuminate/Database/Eloquent/SoftDeletingScope.php
