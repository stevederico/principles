# A cache holds primitives and never fails the request

**Rule:** Store plain values (ids, numbers, serialized snapshots), reload live records from them, treat any cache error as a miss, and keep timeouts short. When a hot entry expires, let one caller rebuild while others briefly serve the old value.

**Why:** A cached record can change or vanish behind the entry. Recomputing is often faster than waiting a second on a sick cache node. Many workers rebuilding one slow value at once multiply the load.

**Do:**
```
ids = cache.fetch("super_admin_ids", ttl 12h): User.super_admins.map(id)
users = load(User, where id in ids)
value = try cache.read(key) catch connection_error -> report(error); nothing
cache connect, read, write timeout: sub-second
cache.fetch(key, ttl 5m, grace 10s): expensive()    # first caller extends and rebuilds
```

**Don't:** Cache a list of full loaded objects, return 500 because a cache node is down, or clear the whole cache in production at peak.

**Break it when:** The store is the source of truth (queue, session, lock), not a cache; or stale data is unacceptable even for seconds.

**Source:** Guide: https://guides.rubyonrails.org/caching_with_rails.html (Avoid Caching Instances of Active Record Objects, ActiveSupport::Cache::RedisCacheStore, Low-Level Caching). Code: activesupport/lib/active_support/cache/redis_cache_store.rb:483-488; activesupport/lib/active_support/cache.rb:384-414.
