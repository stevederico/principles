# Match Cache-Control to output kind and purge the CDN yourself

**Rule:** Give content-hashed assets a one-year immutable public lifetime that config cannot override, give time-revalidated output a shared max-age plus a stale window, give per-request output private no-store, publish only the hashed static directory to a CDN, and purge the CDN yourself on invalidation.

**Why:** A hash in the name is its own invalidation, but tag and path invalidation clear only the server cache, so the edge keeps old copies until its TTL unless HTML and payload variants are purged. Unhashed public files can change, so they stay revalidatable. Derived assets with no purge path need short lifetimes.

**Do:**
```
/static/app.<hash>.js   cache-control: public, max-age=1y, immutable
revalidating page:      s-maxage = revalidate, stale-while-revalidate = expire - revalidate
dynamic page:           private, no-store
on change: invalidate(tag); cdn.purge(html + payload variants)
```

**Don't:** Assume tag invalidation reaches the CDN, long-cache unhashed files, sync the whole build folder to a public bucket, or overwrite an object under the same hashed name.

**Break it when:** Very short TTLs make staleness acceptable; or public files are versioned by name.

**Source:** https://nextjs.org/docs/app/guides/cdn-caching, https://nextjs.org/docs/app/guides/self-hosting, https://nextjs.org/docs/app/api-reference/config/next-config-js/headers, https://nextjs.org/docs/app/api-reference/config/next-config-js/assetPrefix; code: packages/next/src/server/lib/router-server.ts, packages/next/src/server/lib/cache-control.ts, packages/next/src/server/base-server.ts
