# Outside effects wait for the commit

**Rule:** Anything that tells the outside world (enqueue a job, send mail, broadcast, clear a cache) is registered inside the transaction but fires only after it commits, and is dropped on rollback.

**Why:** A worker can start before the row is visible, or act on data that rolls back. Rails now defers job enqueue to commit by default for new apps. A queue that shares your database hides the problem until you move it.

**Do:**
```
transaction t:
  update article published = true
  enqueue NotifyJob(article)        # held; discarded on rollback
  t.on_commit: broadcast(article)
code that may or may not be in a transaction:
  after_all_transactions_commit: send_notification()   # runs now if none open
bulk enqueue(jobs): jobs flagged "after commit" wait; others go at once
```

**Don't:** Call external systems from the transaction body, or enqueue inside a transaction on a backend that starts work at once and trust that "it works locally".

**Break it when:** The effect must happen whatever the outcome (log a failed attempt): enqueue outside, or turn deferral off for that job. A queue inside the same database transaction commits or rolls back with the data. The job layer's class default is off; new-app defaults turn it on.

**Source:** Guides: https://guides.rubyonrails.org/active_job_basics.html (Transactional Integrity on Jobs); https://guides.rubyonrails.org/7_2_release_notes.html (per-transaction commit callbacks); https://guides.rubyonrails.org/8_2_release_notes.html; https://guides.rubyonrails.org/configuring.html (enqueue_after_transaction_commit). Code: activejob/lib/active_job/enqueue_after_transaction_commit.rb:8-45; activejob/lib/active_job/enqueuing.rb:26,43-48; activerecord/lib/active_record/transactions.rb:206-208,596-630; railties/lib/rails/application/configuration.rb:407.
