# Deny cross-origin access to dev servers by default

**Rule:** Block cross-origin requests to dev-only endpoints and assets unless the hostname is on an explicit allowlist (matched on hostname only, using the Referer when no Origin exists, opaque origins blocked), and publish machine-readable dev state only in development.

**Why:** A local dev server exposes source and internals, and any web page the developer visits could probe it. Narrow wildcard rules avoid accidentally wide allowances. A structured dev endpoint lets tools check errors and routes in the running app but must not appear in production.

**Do:**
```
allowed_dev_origins = ["tunnel.example.com"]
on dev request: if cross_origin and host not in allowed: return 403
dev state endpoint: on in development, off in production
```

**Don't:** Open the dev server to all origins for convenience, or expose the dev state endpoint in production.

**Break it when:** Remote device testing through a tunnel; add that host explicitly.

**Source:** https://nextjs.org/docs/app/api-reference/config/next-config-js/allowedDevOrigins, https://nextjs.org/docs/app/guides/mcp; code: packages/next/src/server/lib/router-utils/block-cross-site-dev.ts, packages/next/src/server/mcp/get-mcp-middleware.ts
