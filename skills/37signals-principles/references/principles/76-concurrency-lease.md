# Cap concurrent runs with an expiring lease bound to the holder

**Rule:** Limit simultaneous jobs for a key with a counter lease that carries an expiry as failsafe, record which lease each job acquired so only that lease is released, and treat such limits as expensive.

**Why:** A crashed holder never releases, so expiry frees the key; but without recording, a late finisher would bump a newer lease past the limit. The bookkeeping forces one-by-one enqueue, adds blocked and semaphore rows, and defeats bulk paths.

**Do:**
```
acquire(key): lease = find_or_create(key, value = limit) ; if value > 0: decrement, expires = now + D ; job.record(lease.id)
release(job): increment lease where id == job.lease_id only
plain throttling: a dedicated queue with fixed threads instead
```

**Don't:** Release by key alone, treat the expiry as a job timeout, or add a limit to every job class.

**Break it when:** Per-key exclusivity is a correctness requirement.

**Source:** https://github.com/rails/solid_queue README.md (Concurrency controls), UPGRADING.md ; code: app/models/solid_queue/semaphore.rb, app/models/solid_queue/job/concurrency_controls.rb.
