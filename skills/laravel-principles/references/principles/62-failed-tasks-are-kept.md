# Failed tasks are kept and retryable

**Rule:** When a background task exhausts its attempts, record it in a failed store with enough data to run it again, give operators commands to list, retry (by id, by queue or all), forget and flush by age, run a per-task failure hook for cleanup or alerts, and declare which failures should be discarded quietly.

**Why:** Failures are normal, and a retry has to be one command rather than a hunt through logs. Tasks run inline are not stored; their error surfaces at once. A task whose record was deleted while it waited can be marked to be dropped without an error, since retrying can never succeed.

**Do:**
```
after max attempts: failed_store.insert(task, connection, queue, error, failed_at)
ops: list_failed(); retry(id | queue = q | all); forget(id); flush(older_than = 48h)
task.on_failure(error): undo_partial_work(); alert_owner()
task.discard_when_record_missing = true       # vanished record is not an error
```

**Don't:** Dropping a task after its last attempt with no record, retrying everything blindly after a bug fix without checking, or keeping the failed store forever.

**Break it when:** Work that must run at most once: handle the failure in the hook and never retry it.

**Source:** https://laravel.com/docs/queues ; code: src/Illuminate/Queue/Failed/FailedJobProviderInterface.php, src/Illuminate/Queue/Console/RetryCommand.php, src/Illuminate/Queue/CallQueuedHandler.php
