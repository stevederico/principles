# One table per job state, and polls your indexes fully cover

**Rule:** Keep jobs in a core table and put each in exactly one execution table (ready, scheduled, claimed, blocked, failed); allow only poll queries that an index covers (all queues, or one exact queue, each ordered by priority then id) and claim rows with a lock that skips locked rows.

**Why:** Each hot query touches a narrow table with the exact index it needs, and contention on one state does not slow others. Prefix matches and paused queues force a discovery query first. Skip-locked claims mean workers neither wait on each other nor double-claim. Queue order always wins over priority, so use one scheme, not both.

**Do:**
```
claim: transaction { ids = select job_id order by priority limit N lock skip_locked
                     insert claimed(ids, worker) ; delete ready(ids) }
queues config: ["background", "backend"]       # exact names, not "back*"
precedence by queue order OR per-job priority, not a mix
```

**Don't:** Use one big table with a status column filtered on every poll, take plain row locks, or pause queues routinely.

**Break it when:** Volume is tiny, or the database lacks the lock feature (disable it and expect waits; single-writer databases serialise anyway).

**Source:** https://github.com/rails/solid_queue README.md (Queue order and priorities, High performance requirements) ; code: app/models/solid_queue/ready_execution.rb, app/models/solid_queue/queue_selector.rb, lib/generators/solid_queue/install/templates/db/queue_schema.rb.
