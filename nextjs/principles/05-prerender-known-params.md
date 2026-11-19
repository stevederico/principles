# Prebuild a bounded known set, build the rest lazily

**Rule:** For dynamic routes return a bounded list of known parameter values to prebuild; unlisted values render a shell or full page on first request and are then cached, and the list must not be empty when the route is validated at build.

**Why:** Prebuilding everything is unbounded in time and storage. A sample list gives instant pages for hot paths and proves the route can produce a shell; an empty list usually means a failed data source, so it errors loudly. For lazily built pages, choose a shell now (needs a loading state) or block for the full page (no flash), and give crawlers the full page.

**Do:**
```
static_params():
  return top_n(products).map(p -> { id: p.id })      # at least one
page(id): cached lookup by id
# content loader (what a page shows) is separate from path loader (which pages exist)
```

**Don't:** Return an unbounded list, return an empty one to defer everything, or trust a green build to prove branches the samples never ran.

**Break it when:** Content changes constantly or has no hot subset; render all on demand with a cache lifetime.

**Source:** https://nextjs.org/docs/app/api-reference/functions/generate-static-params, https://nextjs.org/docs/app/guides/building, https://nextjs.org/docs/app/guides/incremental-static-regeneration-cache-components, https://nextjs.org/docs/pages/api-reference/functions/get-static-paths; code: packages/next/src/shared/lib/errors/empty-generate-static-params-error.ts, packages/next/src/build/static-paths/app.ts
