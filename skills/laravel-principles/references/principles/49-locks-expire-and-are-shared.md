# Locks expire and are shared

**Rule:** Every lock, uniqueness key or throttle counter must carry an expiry longer than the longest normal run, be released in a finally path, and live in a store every app instance can reach.

**Why:** A crash otherwise holds the lock forever, and a per-machine store only protects that machine. For long work take a short lease and renew it. Commands that must not overlap (migrations, imports) take one lock across hosts, and the loser exits quietly with success so the deploy does not fail.

**Do:**
```
lock = locks.acquire("report", ttl = 60)
if lock:
  try: for item in items: work(item); lock.renew(60)
  finally: lock.release()
config: coordination.store = shared_redis              # not a local file or process memory
command migrate (single_flight): if not lock.acquire(command_name, 1h): print "already running"; exit(0)
```

**Don't:** Acquiring without a ttl, releasing only on the success path, or leaving the default store local on a multi-server deploy.

**Break it when:** Exactly one instance ever runs.

**Source:** https://laravel.com/docs/cache, https://laravel.com/docs/artisan, https://laravel.com/docs/queues, https://laravel.com/docs/migrations ; code: src/Illuminate/Console/CacheCommandMutex.php, src/Illuminate/Console/Command.php, src/Illuminate/Queue/Middleware/WithoutOverlapping.php
