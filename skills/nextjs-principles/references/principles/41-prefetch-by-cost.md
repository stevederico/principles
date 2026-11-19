# Prefetch by cost: the link states intent, the target caps work

**Rule:** Prefetch in the background but limit the work: the whole payload for static routes, only the shared shell for dynamic ones, none (or on hover) for very long link lists, and let the destination cap how much a preload may do; defer cacheable-but-expensive work to the later stage a user actually reaches.

**Why:** Dynamic prefetch costs real server work for routes the user may never open, and a destination cannot know who links to it. The queue is bounded: visible links first, user-intent links next, newer replacing older, off-screen dropped. A stage marker defers work without making it request-dependent, so it stays cacheable.

**Do:**
```
link(href)                       # static: full, dynamic: nearest shell
link(href, prefetch = off)  in an infinite list; upgrade on hover
destination: opt out of preload for rare, authenticated, expensive routes
expensive cached work: mark_after(prefetch_stage)
```

**Don't:** Use plain anchors for internal navigation, prefetch everything in a big table, or judge prefetch behavior in development where it does not run.

**Break it when:** A critical, personalized path where speed outweighs per-view server cost.

**Source:** https://nextjs.org/docs/app/getting-started/linking-and-navigating, https://nextjs.org/docs/app/guides/prefetching, https://nextjs.org/docs/app/guides/optimizing-prefetching, https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config/prefetch; code: packages/next/src/client/app-dir/link.tsx, packages/next/src/client/components/segment-cache/types.ts, packages/next/src/server/request/cache-stages.ts
