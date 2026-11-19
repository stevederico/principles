# Dispatch after commit

**Rule:** An event, job, mail or broadcast raised inside a transaction must run only after that transaction commits and be dropped if it rolls back, and with no open transaction it runs immediately.

**Why:** A fast worker can pick the task up before the commit and find missing or old rows, and a handler can announce something that is later rolled back.

**Do:**
```
transaction:
  order.save()
  enqueue_after_commit(SendReceipt(order.id))      # held; discarded on rollback
no transaction open: dispatched at once
event OrderPlaced marked "after commit"
```

**Don't:** Enqueuing inside the transaction and hoping the worker is slow.

**Break it when:** The task does not read data written in that transaction, or the event is about the attempt itself (an audit of "payment tried").

**Source:** https://laravel.com/docs/queues, https://laravel.com/docs/events, https://laravel.com/docs/eloquent, https://laravel.com/docs/mail, https://laravel.com/docs/notifications, https://laravel.com/docs/broadcasting ; code: src/Illuminate/Queue/Queue.php, src/Illuminate/Events/Dispatcher.php, src/Illuminate/Database/Concerns/ManagesTransactions.php
