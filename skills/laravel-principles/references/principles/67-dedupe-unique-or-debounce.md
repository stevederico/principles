# Unique or debounce

**Rule:** For repeated enqueues of the same work, choose explicitly between unique (a new one is dropped while one is pending) and debounce (only the last in a window runs), never both, always with a key and a time ceiling.

**Why:** Saving a record five times should enqueue one reindex. The unique lock has a TTL as the escape hatch if the pending task never finishes, and debounce has a maximum wait. Both need a lock store every server shares.

**Do:**
```
unique:   key = "license:" + id, ttl = 1h        # release at completion or when processing starts
debounce: key = product_id, window = 30s, max_wait = 120s       # latest wins
```

**Don't:** A unique lock with no TTL, or unique and debounce on the same task.

**Break it when:** Each task carries different data that must all be applied.

**Source:** https://laravel.com/docs/queues, https://laravel.com/docs/events, https://laravel.com/docs/scout ; code: src/Illuminate/Bus/UniqueLock.php, src/Illuminate/Bus/DebounceLock.php, src/Illuminate/Events/Dispatcher.php
