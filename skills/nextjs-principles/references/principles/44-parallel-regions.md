# Parallel regions need an explicit fallback

**Rule:** When a page is composed of independently navigated regions, declare what each region shows when its state cannot be recovered after a full load, and keep modal content addressable by a real URL that is intercepted on in-app navigation and rendered as a full page on refresh.

**Why:** Client navigation remembers each region's state, but a hard load knows only the URL. Per the code a missing fallback is a build error, not a 404 (the docs say both; the code wins): it is skipped for leaf segments and slots under a catch-all, and the children slot has a built-in default.

**Do:**
```
@modal/default            -> render nothing
@modal/(.)photo/[id]/page -> overlay on soft navigation
photo/[id]/page           -> full page on refresh or shared link
```

**Don't:** Assume the previous region state survives a refresh, or keep modal state only in client memory with no URL.

**Break it when:** The region sits under a catch-all that already provides a fallback, or the content is ephemeral (a confirm dialog).

**Source:** https://nextjs.org/docs/app/api-reference/file-conventions/default, https://nextjs.org/docs/app/api-reference/file-conventions/parallel-routes, https://nextjs.org/docs/app/api-reference/file-conventions/intercepting-routes; code: packages/next/src/build/webpack/loaders/next-app-loader/index.ts
