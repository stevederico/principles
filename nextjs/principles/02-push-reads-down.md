# Read request data in the deepest component that needs it

**Rule:** Read params, cookies, headers and uncached fetches in the smallest component that uses them, behind its own fallback, and pass unresolved promises down instead of waiting at the top.

**Why:** A wait near the root makes everything below it request-time. A wait deep in the tree lets the surrounding layout, navigation and sibling content be built ahead and served first.

**Do:**
```
layout(children, params_promise):
  sidebar()                                 # static
  boundary(fallback): heading(params_promise)   # resolves the promise here
  children
```

**Don't:** Unpack request data in a layout "for convenience", or wait for a request-derived value before rendering independent siblings.

**Break it when:** Every child needs the value and it is cheap; the extra indirection then costs more than it saves.

**Source:** https://nextjs.org/docs/app/getting-started/caching, https://nextjs.org/docs/app/guides/optimizing-the-static-shell, https://nextjs.org/docs/app/guides/streaming; code: packages/next/src/server/request/cache-stages.ts
