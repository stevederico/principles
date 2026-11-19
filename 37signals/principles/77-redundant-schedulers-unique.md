# Make redundant schedulers safe with a unique record written with the enqueue

**Rule:** When several scheduler instances may fire the same recurring task, enqueue the job and record (task, scheduled time) in one transaction under a unique index so only one wins.

**Why:** Redundancy for availability must not produce duplicates, and no leader election is then needed.

**Do:**
```
transaction: job = enqueue(task) ; insert run(task_key, run_at)   # unique index
on duplicate: abort and skip
```

**Don't:** Elect a leader by hand or rely on timing to avoid duplicates.

**Break it when:** The task runs on an adapter that does not track it; accept duplicates.

**Source:** https://github.com/rails/solid_queue README.md (Recurring tasks) ; code: app/models/solid_queue/recurring_execution.rb, lib/generators/solid_queue/install/templates/db/queue_schema.rb.
