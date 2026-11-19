# Bound the variants a generator can produce

**Rule:** Constrain breakpoints and output formats so an on-demand generator cannot produce an unbounded set of cached files, pick the output format from the Accept header in an ordered allowed list with a fallback to the source format, and cache outputs with an expiry of at least the upstream lifetime or a configured floor.

**Why:** Every width and format is a separate cached file. Optimized outputs are served stale while refreshed, and there is no purge, so a very long floor strands a bad image until its URL changes. Derived images get short lifetimes while content-hashed imports get immutable ones. A CDN must forward Accept and cache each format apart.

**Do:**
```
device_sizes = [640, 1080, 1920]; formats = ordered list
expire = max(upstream_max_age, minimum_floor)
response status header: hit | stale | miss
```

**Don't:** Let clients request arbitrary widths, set a huge minimum lifetime and expect to fix an image in place, or strip Accept at the CDN.

**Break it when:** Source URLs carry a version or hash, so staleness is impossible.

**Source:** https://nextjs.org/docs/pages/api-reference/components/image-legacy, https://nextjs.org/docs/app/api-reference/components/image, https://nextjs.org/docs/app/guides/upgrading/version-16; code: packages/next/src/server/image-optimizer.ts, packages/next/src/shared/lib/image-config.ts
