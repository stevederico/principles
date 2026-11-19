# Cache a page's HTML and data payload as one unit

**Rule:** Store the HTML and the client-navigation payload for a route under one entry with one lifetime, set Vary for every request header that changes the body, and fold such inputs into a hash carried in the URL for caches that ignore Vary.

**Why:** If separate renders get mixed, client navigation shows content that disagrees with the document. Many CDNs ignore Vary, so a hashed parameter keeps variants distinct, and stripping it or the header that selects the payload format serves the wrong body. Format negotiation by Accept follows the same rule.

**Do:**
```
key_param = hash(prefetch_kind, segment, state_tree, next_url)
cdn cache key includes key_param; forward the format header unchanged
response: vary = Accept                       # one URL, several representations
```

**Don't:** Give HTML and payload separate TTLs at the CDN, strip query parameters from the cache key, or rely on the host happening to include the header.

**Break it when:** Each representation already has its own URL path.

**Source:** https://nextjs.org/docs/app/guides/cdn-caching, https://nextjs.org/docs/app/guides/how-revalidation-works, https://nextjs.org/docs/app/guides/backend-for-frontend; code: packages/next/src/shared/lib/router/utils/cache-busting-search-param.ts, packages/next/src/client/components/app-router-headers.ts
