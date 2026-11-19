# Routing resolves in fixed phases and by specificity

**Rule:** Apply routing rules in one published order (headers, redirects, interception, early rewrites, files, late rewrites, dynamic routes, fallback rewrites), and match overlapping routes by specificity: literal beats single dynamic segment beats catch-all beats optional catch-all, with a tie being an error.

**Why:** A fixed order lets a rule override a file, apply only if nothing else matched, or proxy leftovers to another site, and lets another platform reproduce the same behavior. Specificity must never depend on directory listing order.

**Do:**
```
/posts/new       beats  /posts/[id]  beats  /posts/[...rest]  beats  /posts/[[...rest]]
catch-all params always arrive as a list; optional catch-all has no value at the bare path
rewrite that must lose to real pages goes in the last phase
```

**Don't:** Assume rewrites run before files, place a catch-all in the wrong phase and shadow real pages, or treat a catch-all value as a string.

**Break it when:** Small apps with a single catch-all router.

**Source:** https://nextjs.org/docs/app/api-reference/config/next-config-js/rewrites, https://nextjs.org/docs/app/api-reference/adapters/routing-information, https://nextjs.org/docs/pages/building-your-application/routing/api-routes, https://nextjs.org/docs/pages/building-your-application/routing/dynamic-routes; code: packages/next/src/server/lib/router-utils/resolve-routes.ts, packages/next/src/shared/lib/router/utils/sorted-routes.ts
