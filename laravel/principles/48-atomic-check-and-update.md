# Atomic check and update

**Rule:** To enforce a limit or claim a slot, do one atomic step (increment and compare, add if absent, or a server-side script) instead of reading, deciding, then writing.

**Why:** With concurrent callers, several pass the check before any of them records. The convenience form that checks first and records after is not atomic; the increment that returns the new count is. A queued transaction in a key-value store cannot read inside it, so read-then-decide logic needs a script that runs atomically on the server.

**Do:**
```
n = counter.increment(key, window_seconds)           # atomic, returns new value
if n > limit: reject(retry_after = counter.ttl(key))
if not store.add_if_absent(key, owner, ttl): skip    # claim once
script: n = incr(k1); if n > 5: incr(k2); return n   # read and decide on the server
```

**Don't:** if counter.get(key) < limit: do_work(); counter.increment(key) under concurrency.

**Break it when:** A single process, or approximate counters where overshoot is harmless.

**Source:** https://laravel.com/docs/rate-limiting, https://laravel.com/docs/cache, https://laravel.com/docs/redis ; code: src/Illuminate/Cache/RateLimiter.php, src/Illuminate/Redis/Connections/PhpRedisConnection.php
