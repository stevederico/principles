# Run end-to-end tests against a production build

**Rule:** Build and start the production server, then run browser tests against it, and judge caching, prefetching and render classification from that build, never from the dev server.

**Why:** Development renders everything on demand and does not prefetch automatically, so cache behavior, streaming and shell output differ. Performance work needs lab audits on a production build plus field data.

**Do:**
```
ci: build; start; run browser tests; lab audit on the same build
```

**Don't:** Conclude "it is dynamic" or "it is cached" from the dev server, or judge speed from it.

**Break it when:** Fast local iteration, where a dev server with a start hook is acceptable.

**Source:** https://nextjs.org/docs/app/guides/testing/cypress, https://nextjs.org/docs/app/guides/testing/playwright, https://nextjs.org/docs/app/guides/production-checklist, https://nextjs.org/docs/app/guides/caching-without-cache-components; docs only
