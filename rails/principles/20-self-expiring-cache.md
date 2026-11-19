# Cache keys that change themselves

**Rule:** Build the cache key from the thing's identity and last-updated time. When it changes, the key changes, so the old entry is never read.

**Why:** You never write invalidation code. Stale data is impossible by design, and old entries simply age out.

**Do:**
```
key = "post/" + post.id + "/" + post.updated_at
cache.fetch(key): render(post)
# nested: a page's key includes its parts' keys, so one edit refreshes only what changed
```

**Don't:** Delete cache entries by hand after every change.

**Break it when:** Data changes without touching the timestamp. Then include the missing value in the key.

**Source:** Rails practice, key-based expiration and Russian doll caching.
