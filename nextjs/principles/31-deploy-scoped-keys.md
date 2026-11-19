# Cache entries never outlive the code that wrote them

**Rule:** Mix the build or deployment id into cache keys, treat every release as starting cold, and use a separate, deliberately versioned store for anything that must survive deploys.

**Why:** A refactor or dependency bump can change output shape, and old entries could feed malformed data to new code. The default in-process cache is also per instance and lost when the instance goes, so migrating from a persistent cache silently changes persistence.

**Do:**
```
key = hash(build_id, function_id, args, captured_values)
warm critical routes after release; accept first-hit cost
```

**Don't:** Depend on a long-lived cache for correctness or capacity across releases, or assume migration preserved cross-deploy persistence.

**Break it when:** Entries are independent of code and carry their own version in a store you control.

**Source:** https://nextjs.org/docs/app/getting-started/caching, https://nextjs.org/docs/app/api-reference/directives/use-cache-remote, https://nextjs.org/docs/app/guides/migrating-to-cache-components; code: packages/next/src/server/use-cache/use-cache-wrapper.ts
