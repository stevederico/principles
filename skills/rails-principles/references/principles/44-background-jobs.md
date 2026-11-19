# Slow work goes to a queue

**Rule:** Run slow, failure-prone or non-urgent work as a background job. Send references, not copies, declare per error kind whether to retry or discard, and use a durable queue outside development.

**Why:** Users should not wait on mail, files or third-party calls. A job that fails and has no declared policy is simply marked failed, not retried. The framework serializes a record argument as a reference and reloads a fresh copy when the job runs.

**Do:**
```
enqueue SendReceipt(order)          # sent as a reference, reloaded at run time
SendReceipt:
  retry on Timeout: backoff, max 5
  discard on RecordGone             # order deleted, nothing to do
  other errors: marked failed, visible to a human
msg = Notifier.welcome(user)        # nothing runs yet
msg.deliver_later()                 # or deliver_now(); the caller chooses
queues named by promise: within_30_seconds, within_1_hour; alert when the oldest job exceeds its name
dev: in-process queue (loses jobs on restart); test: capturing queue; prod: durable
```

**Don't:** Assume a queue retries for you, discard the broad "could not load arguments" error (it hides transient database errors), ship a snapshot of state, or run production on the in-memory queue.

**Break it when:** The result is needed in the response: keep it inline with a timeout. Best-effort work (cache warmup) may use a volatile queue. Enqueue timing is principle 45.

**Source:** Guides: https://guides.rubyonrails.org/active_job_basics.html (Supported Argument Types for perform, Retrying or Discarding Failed Jobs, Missing Records, Naming Queues, Development Environment); https://guides.rubyonrails.org/4_2_release_notes.html (Active Job, deliver_later); https://guides.rubyonrails.org/5_0_release_notes.html (default adapter). Code: activejob/lib/active_job/arguments.rb:10-52,74,104-107,155; activejob/lib/active_job/exceptions.rb:24,69 (defaults: 3 s wait, 5 attempts; only the polynomial backoff exists, though the guide names an exponential one); actionmailer/lib/action_mailer/message_delivery.rb:6-40; activejob/lib/active_job/railtie.rb:55.
