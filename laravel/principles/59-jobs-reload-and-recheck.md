# Jobs reload and recheck

**Rule:** Put identifiers, not snapshots, in deferred work, and reload at run time, decide in advance what a vanished record means, and re-check "should this still happen" on the worker.

**Why:** Payloads stay small and the work runs on current data. Between enqueue and run the record may be deleted, or the world may change (invoice paid, user opted out). Reloaded relations come back in full, so constraints put on them before queueing are lost. Sensitive payloads can be encrypted.

**Do:**
```
enqueue(SendReceipt(order_id = 42))
run(job): o = Order.find(job.order_id)
          if o is gone: discard or fail, per declared policy
          if not job.should_still_run(o): record "skipped"; return
```

**Don't:** Queuing whole object graphs or closures that capture live objects, or deciding once at enqueue and trusting it hours later.

**Break it when:** A point-in-time copy is the point (audit, receipt): pass immutable values. A decision that can never change.

**Source:** https://laravel.com/docs/queues, https://laravel.com/docs/events, https://laravel.com/docs/notifications, https://laravel.com/docs/upgrade ; code: src/Illuminate/Queue/SerializesAndRestoresModelIdentifiers.php, src/Illuminate/Queue/CallQueuedHandler.php, src/Illuminate/Notifications/NotificationSender.php
