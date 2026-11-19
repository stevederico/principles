# Failure budget

**Rule:** Give every background task a bounded failure budget (attempt count or deadline, backoff list, timeout, failure hook), count every non-completion including release by a guard as an attempt, and nest timeouts so the task limit sits inside the queue's redelivery window.

**Why:** The default is one attempt, so a task released by a rate limit or overlap guard on its first try is already out of attempts. A deadline beats a count, and unlimited tries need a separate cap on real errors. Retrying a permanent error wastes attempts; a flapping dependency should pause after a streak. If the task timeout is not shorter than the redelivery window, a frozen task is handed out again and runs twice.

**Do:**
```
task.max_attempts = 25 ; task.max_errors = 3 ; task.retry_until = now + 10min
task.backoff = [1, 5, 10]                     # last value repeats
task.timeout = 60 ; queue.redelivery_after = 90 ; http.timeout = 10
on error e: if permanent(e): fail_now(e)
            else if streak[dep] >= 10: pause(dep, 5min) else retry(backoff)
on_failure(task, error): alert_ops(task, error)
```

**Don't:** Leaving the default budget of one on a task behind a lock or limiter, blind retries for every error class, or a task timeout at or above the redelivery window.

**Break it when:** A task that must run at most once: one attempt, handle failure in the hook. A queue that uses acknowledgements instead of redelivery.

**Source:** https://laravel.com/docs/queues, https://laravel.com/docs/events, https://laravel.com/docs/horizon ; code: src/Illuminate/Queue/Worker.php, src/Illuminate/Queue/Console/WorkCommand.php, src/Illuminate/Queue/Middleware/FailOnException.php, src/Illuminate/Queue/Middleware/ThrottlesExceptions.php, src/Illuminate/Queue/DatabaseQueue.php
