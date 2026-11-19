# Client caches and speculative loads must obey writes

**Rule:** After any non-read request, clear held page caches and prefetched pages and pause new speculation until it ends; prefetch only after a short hover, keep results a few seconds, mark such requests, and allow opt-out.

**Why:** Cached previews and prefetched pages would show stale data, and a speculative GET during a mutation can race with cookies it changes. A short delay avoids loading for passing hovers, the marker lets the server skip side effects, and opt-out protects expensive pages and data-saver users.

**Do:**
```
on unsafe request start: pause speculation, clear it ; on response: clear page cache
on pointer-enter(link): after ~100 ms if still hovered and allowed: fetch with a "prefetch" purpose header, ttl ~10 s
skip if link, ancestor or page opts out, or data-saver is on
```

**Don't:** Prefetch every visible link at load, give prefetch requests side effects, or serve cached snapshots after a successful POST.

**Break it when:** You have precise per-key invalidation you trust, or a few top pages justify explicit eager preloading.

**Source:** https://turbo.hotwired.dev/handbook/drive (Prefetching links on hover) ; https://turbo.hotwired.dev/reference/drive ; code: https://github.com/hotwired/turbo src/core/drive/prefetch_cache.js, src/observers/link_prefetch_observer.js.
