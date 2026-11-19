# Cached code forwards opaque values and returns expected failures

**Rule:** A cached unit may accept values it cannot key (child content, callbacks) only by forwarding them untouched, and it should return expected failures as plain result values rather than throwing custom error types.

**Why:** The key covers only serializable inputs, so inspecting an opaque value would change output without changing the key. Thrown errors are serialized across the boundary: custom classes and fields do not survive, and in production the message becomes a generic one with a correlation digest.

**Do:**
```
cached_wrapper(children):
  return layout(children)                    # forwarded, never read or called
cached_lookup(id):
  if missing: return { found: false }        # a value, not a thrown custom error
```

**Don't:** Call a passed-in callback or read fields of a passed-in slot inside the cached body, or branch on a custom error class thrown from within a cache.

**Break it when:** The failure is truly unexpected; let it reach the error boundary and be logged.

**Source:** https://nextjs.org/docs/app/api-reference/directives/use-cache; code: packages/next/src/server/use-cache/use-cache-wrapper.ts
