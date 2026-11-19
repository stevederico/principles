# Enqueue only after the surrounding transaction commits

**Rule:** Defer enqueueing a job until the transaction that wrote its data has committed.

**Why:** A worker may start before commit and see missing or older data, and a rollback would leave a job pointing at nothing. This matters most when the queue lives in a different database from the data, where no shared transaction can help.

**Do:**
```
transaction: write record ; schedule enqueue to run on commit
after commit: enqueue job(record.id)
```

**Don't:** Enqueue inside a transaction against a queue stored elsewhere and hope timing works, or rely on "job exists only if the transaction committed" and later move the queue.

**Break it when:** Queue and data share one database and you deliberately want atomic enqueue; document the choice.

**Source:** https://github.com/rails/solid_queue README.md (Jobs and transactional integrity), UPGRADING.md ; code: lib/active_job/queue_adapters/solid_queue_adapter.rb.
