# Only entry files expose URLs

**Rule:** Make a URL public only through an explicit entry file (a page or a route handler); everything else in the routing tree is private and safe to colocate, folder groups may organize files without changing URLs, and two groups resolving to one URL must fail the build.

**Why:** Folders define structure, but only content returned by an entry file is reachable, so components, tests and helpers can sit beside the routes that use them without accidental exposure. Two pages at one path are ambiguous, so the build rejects them rather than picking a winner.

**Do:**
```
blog/page            -> /blog is public
blog/_parts/...      -> private folder, never routed
(marketing)/about/page and (shop)/about/page -> build error, same URL
```

**Don't:** Assume a folder name alone creates an endpoint, or depend on group order to choose a winner.

**Break it when:** You prefer a strict split where the routing tree holds only routes and shared code lives outside it.

**Source:** https://nextjs.org/docs/app/getting-started/project-structure, https://nextjs.org/docs/app/api-reference/file-conventions/route-groups; code: packages/next/src/build/route-discovery.ts, packages/next/src/build/webpack/loaders/next-app-loader/index.ts
