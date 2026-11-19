# A cache key covers every input that changes the result

**Rule:** Key each cached result on the code's identity, the deployment, and every input including captured outer values; never read ambient request state (session, cookies, headers) inside the cached function, and store only successful results.

**Why:** Anything outside the key cannot vary the result safely, so two callers with different ambient state would share one entry. Server-side fetch caches match on URL, method, headers and body, and cache only successful responses. Response caches should also include the owning route so two routes rendering one URL cannot overwrite each other.

**Do:**
```
notes(user_id):                              # user_id is part of the key
  cache(tag = "notes:" + user_id)
  return db.notes(user_id)
caller reads session first, passes the extracted value in
```

**Don't:** Read the cookie inside the cached function, cache by path alone behind the framework, or store error responses.

**Break it when:** The value is constant for the process and you deliberately keep it out of the key.

**Source:** https://nextjs.org/docs/app/api-reference/directives/use-cache, https://nextjs.org/docs/app/api-reference/functions/fetch, https://nextjs.org/docs/app/api-reference/functions/unstable_cache, https://nextjs.org/docs/app/guides/optimizing-prefetching; code: packages/next/src/server/use-cache/use-cache-wrapper.ts, packages/next/src/server/lib/route-cache-key.ts, packages/next/src/server/request/cookies.ts
