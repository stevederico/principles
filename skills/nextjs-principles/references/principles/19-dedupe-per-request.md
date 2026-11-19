# Deduplicate reads within one request, never across requests

**Rule:** Memoize identical side-effect-free reads for the duration of one render pass so many components can ask for the same data, and keep that separate from any cross-request cache; wrap database calls yourself since only HTTP reads are deduplicated for you.

**Why:** Local fetching without a shared loader is only cheap if duplicates collapse. The memo lives for one pass, applies to reads (never to mutating methods), and cannot leak between users or go stale.

**Do:**
```
get_user = per_request_memo(id -> db.find(id))
# any component calls get_user(1): one query per request
```

**Don't:** Keep a module-level variable as a cache for per-user data, hoist every read to the top to avoid duplicates, or assume the memo survives the request.

**Break it when:** You want cross-request reuse; use an explicit cache with a lifetime. Code outside render (route handlers) gets no memo.

**Source:** https://nextjs.org/docs/app/getting-started/fetching-data, https://nextjs.org/docs/app/api-reference/functions/fetch; code: packages/next/src/server/lib/dedupe-fetch.ts
