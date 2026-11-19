# Build ahead unless the request matters

**Rule:** Default each page to being built ahead of time and cached at the edge; use per-request rendering only when output must differ on every request, and never attach a request-time loader to the shared wrapper.

**Why:** Ahead-of-time output is built once and served fast and cheaply. A page is static exactly when it declares no request-time data, so one global request hook silently turns off static output for every page that lacks build-time data. Contradictory declarations (both build-time and request-time data) are rejected at build.

**Do:**
```
page has no request loader        -> built once, served from edge
page has request loader           -> rendered on demand
both on one page                  -> build error
app wrapper has request loader    -> every page becomes on-demand (avoid)
```

**Don't:** Add one small global loader (a session lookup) and lose static output everywhere, or use request-time rendering for marketing, blog or listing pages.

**Break it when:** Personalization or per-request freshness is the product.

**Source:** https://nextjs.org/docs/pages/building-your-application/rendering/automatic-static-optimization, https://nextjs.org/docs/pages/building-your-application/rendering/static-site-generation, https://nextjs.org/docs/pages/building-your-application/routing/custom-app; code: packages/next/src/build/utils.ts
