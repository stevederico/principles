# Give every dynamic route an instant, honest loading shell

**Rule:** Put a fallback boundary as close as possible to the slow access so navigation answers at once and the shell can be prefetched; keep stable UI outside the boundary, size the fallback like the finished content, and show a pending indicator only after a short delay in a reserved slot.

**Why:** Without a boundary the client waits for the server and the app seems frozen. A boundary only covers what it wraps: a read in the layout above a segment's loading file blocks navigation, a boundary in the root layout does not help client navigations, and mismatched skeletons shift layout. Instant spinners flicker on fast transitions.

**Do:**
```
segment/
  page: heading()                            # outside, stays visible
        boundary(skeleton_same_size): slow_list()
indicator: invisible, becomes visible after ~100ms if still pending
```

**Don't:** Fetch uncached data in a layout and rely on the same segment's loading file, wrap the heading and the list in one boundary, or insert and remove an element when pending toggles.

**Break it when:** The route is fully static, or the operation is known to be slow (uploads) and should show feedback at once.

**Source:** https://nextjs.org/docs/app/getting-started/linking-and-navigating, https://nextjs.org/docs/app/guides/optimizing-the-static-shell, https://nextjs.org/docs/app/guides/instant-navigation, https://nextjs.org/docs/app/api-reference/file-conventions/loading; docs only
