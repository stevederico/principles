# Migrate in place, one page at a time

**Rule:** Run the old and new systems side by side and move one page at a time: first move the existing component unchanged into the new system's client-side mode, then lift data fetching to the server, then shrink the client part; to adopt a new framework first host the whole old app as one client-only entry, and add a last-phase fallback that forwards unowned paths to the legacy site.

**Why:** Several new concepts at once raise risk, and splitting keeps behavior comparable. Because the fallback phase runs after files and dynamic routes, each migrated page takes over without config changes. Crossing between the two routers is a hard navigation with no cross-router prefetch, so keep pages visited together on one side. Capture the behavior you must preserve in a test against a production-like build and require it to pass unchanged.

**Do:**
```
baseline test green -> move page X as-is -> lift data to server -> shrink client part -> same test green
routing: ... files, dynamic routes, then fallback_rewrite -> legacy_origin
```

**Don't:** Rewrite behavior and move structure in one change, delete the old shell early, put the proxy in an early phase where it shadows migrated pages, or edit the test to fit the new behavior.

**Break it when:** A small app where one cutover is cheap, or a greenfield rewrite.

**Source:** https://nextjs.org/docs/app/guides/migrating/app-router-migration, https://nextjs.org/docs/app/guides/migrating/from-create-react-app, https://nextjs.org/docs/app/guides/migrating/from-vite, https://nextjs.org/docs/app/api-reference/config/next-config-js/rewrites, https://nextjs.org/docs/app/guides/adopting-partial-prefetching; code: packages/next/src/server/lib/router-utils/resolve-routes.ts
