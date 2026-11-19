# Guard shared writes

**Rule:** When several writers touch a row, use a version check or a row lock, and keep transaction scope explicit: an inner block joins the outer one, and an early exit rolls back.

**Why:** A decision made on a stale copy lies. Partial updates built from stale reads can mix states. A nested block that "rolls back" without a savepoint undoes nothing, and an early return that commits half the work is data corruption.

**Do:**
```
update row set ... where id = X and version = seen_version
0 rows changed -> stale error (map to HTTP 409)
cancel(order): transaction { order = reload_with_lock(order); if shipped fail; update }
transaction { a; transaction(own_savepoint) { b; rollback } }   # only b undone
early return, timeout or kill inside a transaction -> rollback; only reaching the end commits
```

**Don't:** Last-write-wins on shared records, partial updates with no version column, or reading a row, deciding in memory, and writing later with no lock.

**Break it when:** Tiny commutative counters (use an atomic increment), single-writer data, or high contention where a plain lock beats retries.

**Source:** Guides: https://guides.rubyonrails.org/active_record_querying.html (Optimistic Locking, Pessimistic Locking); https://guides.rubyonrails.org/3_2_release_notes.html (with_lock); https://guides.rubyonrails.org/2_3_release_notes.html (Nested Transactions); https://guides.rubyonrails.org/7_0_release_notes.html (rollback on early exit); https://guides.rubyonrails.org/configuring.html (partial_updates). Code: activerecord/lib/active_record/locking/optimistic.rb:77,130-160; activerecord/lib/active_record/locking/pessimistic.rb:101-117; activerecord/lib/active_record/connection_adapters/abstract/transaction.rb:667-693.
