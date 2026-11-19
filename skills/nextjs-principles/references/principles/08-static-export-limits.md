# Static output rejects server needs; browser APIs wait for mount

**Rule:** In an all-static output mode, reject at build any route that needs a server (request reads, mutations, regeneration, unenumerated dynamic params), and touch browser-only APIs only after mount or behind a browser-only boundary, because client code is also prerendered.

**Why:** A file host cannot compute per request, and silent degradation (a quiet 404 on unlisted params) is found only after deploy. Browser APIs do not exist during prerender, and values only the client knows (locale, saved theme) cause mismatches unless a tiny pre-paint script fixes them.

**Do:**
```
mode = static_files
route reads request data   -> build error
dynamic route, no params   -> build error
on_mount(): width = window.width()          # never at render
```

**Don't:** Read window or storage at render time, or put indexable content inside a browser-only region.

**Break it when:** You also run a server for those routes; use the normal mode.

**Source:** https://nextjs.org/docs/app/guides/static-exports, https://nextjs.org/docs/app/guides/single-page-applications, https://nextjs.org/docs/app/guides/preventing-flash-before-hydration; code: packages/next/src/build/index.ts
