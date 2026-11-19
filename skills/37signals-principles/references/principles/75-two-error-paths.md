# Route job errors and infrastructure errors separately

**Rule:** Keep job-level failures with the job layer (retry or discard rules, then a failed record kept for inspection) and report faults inside the queue machinery through a separate hook; a job whose class cannot be resolved is a recoverable failure, not a deletion.

**Why:** Different owners and different responses; mixing them hides which layer is broken. Enqueue failures use the queue's own error type so callers that do not control the enqueue call can still handle them. Rolling deploys leave old payloads in flight, and dropping them silently loses work.

**Do:**
```
job raises -> retry or discard policy -> else failed record
worker thread error -> on_thread_error(exception)
resolve(class_name) or fail(job, ClassMissing)       # stays visible and retriable
```

**Don't:** Send worker-thread faults into job retry logic, or delete jobs whose code is missing.

**Break it when:** The job type is retired for good; discard it explicitly.

**Source:** https://github.com/rails/solid_queue README.md (Errors when enqueuing, Failed jobs and retries) ; code: lib/solid_queue/engine.rb, app/models/solid_queue/claimed_execution.rb.
