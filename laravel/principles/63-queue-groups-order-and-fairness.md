# Group keys for order and fairness

**Rule:** When order or fair sharing matters, give each task a group key derived from the owner (customer, tenant): tasks in one group run one at a time in order, different groups run in parallel, and one noisy group cannot starve the others.

**Why:** A plain queue offers no per-owner ordering. With a group key, one customer's updates stay in sequence while other customers proceed. A deduplication id lets the broker drop a repeated send. On the SQS driver an unset group falls back to the queue name, which serializes everything in that queue. Listeners, mail and notifications on such a queue need a group too.

**Do:**
```
dispatch(ProcessOrder(order)).group("customer-" + order.customer_id)
task.deduplication_id = "renewal-" + subscription.id
no group given -> group = queue name    # whole queue runs one at a time
```

**Don't:** Leaving the default group on an ordered queue and wondering why throughput collapsed, or ordering across owners that do not need it.

**Break it when:** Independent tasks with no ordering need: a plain queue is simpler.

**Source:** https://laravel.com/docs/queues ; code: src/Illuminate/Queue/SqsQueue.php
