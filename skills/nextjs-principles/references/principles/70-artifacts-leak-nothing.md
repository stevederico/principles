# Ship secrets at start, not inside the artifact

**Rule:** Package only traced files plus non-secret defaults, supply secrets as process environment at start, and keep browser source maps off in production unless you upload them to a private error tracker.

**Why:** Anything copied into the packaged output ships with it, and environment set at launch overrides copied defaults. Source maps expose original code, and enabling them raises build time and memory.

**Do:**
```
build: emit server files + non-secret defaults
start: process env supplies secrets
source maps: off, or uploaded privately and removed from the public host
```

**Don't:** Bake secrets into an image, assume local env files reach request-time code, or upload maps to a public host.

**Break it when:** Immutable single-tenant images built in a trusted private pipeline.

**Source:** https://nextjs.org/docs/app/api-reference/config/next-config-js/output, https://nextjs.org/docs/app/api-reference/config/next-config-js/productionBrowserSourceMaps; code: packages/next/src/server/config-shared.ts
