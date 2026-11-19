# Add a client data library only for shared revalidating state

**Rule:** If a client component reads server data once, hand it a pending promise; adopt a client data library only for focus revalidation, polling, cross-component dedupe or optimistic updates, and then seed it from the server with a per-request cache and stable keys.

**Why:** Each extra cache layer must be kept consistent. A cache object shared across server requests leaks between users, fallback data counts as stale and refetches after hydration unless given a freshness window, and render-time values in a key create a new entry on every mount.

**Do:**
```
client_cache = new_cache_per_request()
start(client_cache.prefetch(key, server_loader))
hydrate(client_cache, include_pending = true, stale_after = 30s)
key = ["search", normalized_query]           # stable inputs only
```

**Don't:** Share one client cache across server requests, key by the current time, or add a library for data that never revalidates.

**Break it when:** A cross-component client cache and mutations are central to the feature.

**Source:** https://nextjs.org/docs/app/guides/client-side-data-fetching, https://nextjs.org/docs/app/guides/client-side-data-fetching/swr, https://nextjs.org/docs/app/guides/client-side-data-fetching/tanstack-query; docs only
