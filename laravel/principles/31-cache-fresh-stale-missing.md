# Fresh, stale and missing

**Rule:** For expensive cached values keep a fresh window and a longer stale window, and inside the stale window return the old value at once and refresh it once after the response, and remember the cache cannot tell a stored null from a missing key.

**Why:** Removes the slow request that pays for every expiry while bounding staleness. The refresh takes a per-key lock and rechecks a created-at marker before writing. A stored null counts as absent, so a negative result recomputes every time unless you store a sentinel. Reads inside one request can be memoized in memory and die with the request.

**Do:**
```
value = cache.get_with_grace(key, fresh = 5s, stale_until = 10s, compute)
# fresh: return ; stale: return old, refresh after response ; expired: compute now
v = cache.get(key); if v is missing: v = lookup() or EMPTY; cache.put(key, v, ttl)
c = memoized(redis_cache)          # same key in one request hits memory
```

**Don't:** Every caller recomputing at expiry, stale data with no upper bound, or cache.put(key, null) expecting has(key) to be true.

**Break it when:** Data must never be stale (balances, stock). Another process changes the key mid-request and you must see it.

**Source:** https://laravel.com/docs/cache ; code: src/Illuminate/Cache/Repository.php, src/Illuminate/Cache/CacheManager.php, src/Illuminate/Cache/MemoizedStore.php
