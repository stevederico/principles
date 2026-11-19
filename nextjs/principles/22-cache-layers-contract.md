# Layers differ in freshness but share identity

**Rule:** When server cache, router cache and a client library cache hold the same data, give each its own freshness policy but define one shared key and tag contract (free of server-only or client-only imports) and invalidate every layer from the same mutation.

**Why:** Durations need not match, but mismatched identities cause stale or duplicated data. An uncached server read has no tag to expire, and a fallback keyed differently from the hook is silently ignored.

**Do:**
```
contract = { key(id): "/items/" + id, tag(id): "item:" + id }
server read: cache(tag = contract.tag(id))
mutation: client.optimistic(contract.key(id)); server.expire(contract.tag(id))
roll back the client value if the write fails
```

**Don't:** Let the fallback key and the hook key drift, or import server-only code into the shared contract.

**Break it when:** Only one cache layer exists.

**Source:** https://nextjs.org/docs/app/guides/client-side-data-fetching; code: packages/next/src/server/web/spec-extension/revalidate.ts
