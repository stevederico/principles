# One shared shell per route, URL data behind a boundary

**Rule:** Build a single URL-independent shell per route that every link to it shares, and keep anything derived from path or query parameters behind a loading boundary; session-scoped data may live in the shell because it varies per user, not per link.

**Why:** Many links point at one route, so per-link artifacts multiply server work with link count while shells scale with route count. A shared shell cannot hold URL-specific data. Per-link preloading stays available as an opt-in for a few high-value destinations.

**Do:**
```
page(params_promise):
  product_layout()                           # shared shell
  boundary(skeleton): details(params_promise)   # URL data inside
```

**Don't:** Wait for params or query at the top of a page, or mark every card in a grid for per-link preloading.

**Break it when:** A destination's top content depends on the URL and must be ready before the click; cache it keyed by the value and opt that link in.

**Source:** https://nextjs.org/docs/app/guides/adopting-partial-prefetching, https://nextjs.org/docs/app/api-reference/config/next-config-js/partialPrefetching; code: packages/next/src/server/config.ts
