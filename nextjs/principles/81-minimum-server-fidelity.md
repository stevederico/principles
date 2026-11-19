# One server is the baseline; platform extras are performance

**Rule:** Define the minimum deployment as one long-running server process that gives every feature, treat CDN, edge shell delivery and shared caches as performance and multi-instance consistency layers, and verify a platform with a public conformance suite through its scripts or typed build manifest.

**Why:** Functional fidelity is binary and testable; performance fidelity is a spectrum. A platform that streams supports the model, and the shell-at-the-edge variant only improves first-byte time. Public conformance leaves no private hooks for any vendor. Splitting a page into separate routes just to isolate one dynamic element moves complexity into app code that the platform could carry.

**Do:**
```
baseline: single server process, origin-only
add: CDN shell + origin compute, shared cache with tag sync
adapter consumes typed build manifest (outputs, routing phases, hashes); test through scripts
```

**Don't:** Require CDN features for correctness, mix "works" and "is fast" in one support claim, or run many instances with local caches and expect invalidation to reach all.

**Break it when:** First-byte latency is a hard requirement.

**Source:** https://nextjs.org/docs/app/guides/deploying-to-platforms, https://nextjs.org/docs/app/guides/rendering-philosophy, https://nextjs.org/docs/app/guides/ppr-platform-guide, https://nextjs.org/docs/app/api-reference/adapters/creating-an-adapter; code: packages/next/src/build/adapter/build-complete.ts
