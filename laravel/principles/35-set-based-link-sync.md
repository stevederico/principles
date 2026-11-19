# Sync links as a set

**Rule:** To make a many-to-many link set equal a target, send the full desired set to one sync call that computes the additions and removals, use the additive form when existing links must stay, and wrap multi-step changes in a transaction.

**Why:** Hand-written delete-then-insert loops are error-prone and race with other requests, while one call states the end state. The plain sync is not transactional by itself; the fail-safe form wraps it in a transaction.

**Do:**
```
user.roles.sync([1, 2, 3])                 # removes others, adds missing
user.roles.sync_without_removing([4])      # additive variant
user.roles.sync_in_transaction([1, 2])     # all or nothing
```

**Don't:** Deleting all links and re-inserting them one by one.

**Break it when:** Per-link data not in the payload must survive: use the additive form and update links individually.

**Source:** https://laravel.com/docs/eloquent-relationships ; code: src/Illuminate/Database/Eloquent/Relations/Concerns/InteractsWithPivotTable.php
