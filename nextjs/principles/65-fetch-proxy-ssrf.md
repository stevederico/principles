# Server-side fetch proxies are allowlist-only and SSRF-hardened

**Rule:** Any endpoint that fetches a caller-named URL must match explicit allowlists (protocol, host, port, path, query), reject everything else with a plain client error, resolve and pin the address and refuse private ranges, cap size, time and redirect depth, detect the real file type from bytes, and not serve script-capable formats from your origin.

**Why:** An open image optimizer is a free proxy and a way to probe internal networks; omitted pattern fields default to wildcards, redirects are not re-checked against patterns, and a name check followed by a second resolution allows DNS rebinding. Upstream headers can lie, SVG can carry script, and optimization is an enhancement so failure should return the original.

**Do:**
```
allow: { protocol: https, host: "bucket.example.com", path: "/my-bucket/**", query: "" }
ip = resolve(host); if private(ip): return 400; connect to that pinned ip
type = sniff(bytes); if scriptable and not opted in: refuse or force download + strict CSP
```

**Don't:** Use a bare host allowlist or leave fields blank, follow unlimited redirects, or enable the dangerous flag to silence a 400.

**Break it when:** A private network where every source is trusted, with an explicit, named opt-in.

**Source:** https://nextjs.org/docs/app/getting-started/images, https://nextjs.org/docs/app/api-reference/components/image, https://nextjs.org/docs/app/api-reference/functions/image-optimizer-transform, https://nextjs.org/docs/app/guides/upgrading/version-16; code: packages/next/src/server/image-optimizer.ts, packages/next/src/shared/lib/match-remote-pattern.ts, packages/next/src/shared/lib/image-config.ts, packages/next/src/server/image-optimizer/transform.ts
