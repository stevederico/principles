# Transactions and races

**Rule:** Run multi-step writes inside a wrapper that commits on success and rolls back on error, retries only deadlocks at the outermost level, takes row locks inside it, and lets a unique constraint decide races for find-or-create and upsert.

**Why:** Manual begin and commit leaks on exceptions. A nested block cannot retry, because the engine already rolled everything back. A row lock lasts until commit, so outside a transaction it protects nothing. Two requests can both miss a lookup; only the constraint picks the winner, and the loser must re-read the winner's row.

**Do:**
```
transaction(attempts = 5):
  a = accounts.lock_for_update().find(1)
  if a.balance < 100: raise
  update(a)
r = find(keys); if none: try insert(keys) catch unique_violation: r = find_on_primary(keys)
upsert(rows, unique_by = [a, b], update = [price])      # needs a unique index on a, b
```

**Don't:** Retrying on any exception, running schema statements that commit implicitly inside it, or treating insert-ignore as validation.

**Break it when:** Non-idempotent work: one attempt. A single atomic statement (decrement where balance is enough) needs no lock.

**Source:** https://laravel.com/docs/database, https://laravel.com/docs/queries, https://laravel.com/docs/eloquent ; code: src/Illuminate/Database/Concerns/ManagesTransactions.php, src/Illuminate/Database/Query/Builder.php, src/Illuminate/Database/Eloquent/Builder.php
