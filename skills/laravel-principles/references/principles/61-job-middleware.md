# Job middleware

**Rule:** Put cross-cutting run rules for background tasks (rate limit, no overlap, exception throttle, skip when a group was cancelled) in reusable layers declared on the task, so the task body holds only the business step.

**Why:** The same rule is written once and attached anywhere, the way request middleware is. A layer may release the task for a later try, drop it, or let it through. Released tasks still count as attempts, so the failure budget must allow for them. A named lock key can be shared across different task classes that touch one resource.

**Do:**
```
task SyncAccount:
  middleware = [rate_limited("backups"), without_overlapping(key = account.id, release_after = 60)]
  run(): sync(account)               # no limiter code here
layer(task, next): if cancelled(task.group): return else next(task)
```

**Don't:** Hand-writing lock and limiter code at the top of every task body, or letting a rate-limited task burn its only attempt.

**Break it when:** A one-off task with a single special rule that nothing else shares.

**Source:** https://laravel.com/docs/queues ; code: src/Illuminate/Queue/Middleware/RateLimited.php, src/Illuminate/Queue/Middleware/WithoutOverlapping.php, src/Illuminate/Queue/Middleware/Skip.php
