# Test the instant-UI contract by pausing dynamic work

**Rule:** Assert what the user sees immediately (shell, prefetched UI, loading states) while request-time content is held back by a test hook, then release the hold and assert the final page, always releasing on failure; add it as a regression test for both initial load and client navigation, filter by visibility when hidden pages stay in the DOM, and write it so it fails before the fix.

**Why:** Structure checks say a shell exists, not that the right content is inside it. The test captures the intended shell without measuring cold-cache latency, and a boundary covering one path may not cover the other. Wait for the destination URL before asserting so shared selectors do not match the source page.

**Do:**
```
with paused_dynamic_work():
  click(link); wait_for_url(dest)
  assert visible(shell) and visible(skeleton)
release; assert visible(final_content)
```

**Don't:** Assert before the URL changes, nest or run concurrent holds in one browser context, or count elements without filtering visibility.

**Break it when:** Measuring cold-cache or prefetch latency; the test assumes a warm cache.

**Source:** https://nextjs.org/docs/app/guides/testing/playwright, https://nextjs.org/docs/app/guides/optimizing-the-static-shell, https://nextjs.org/docs/app/guides/instant-navigation, https://nextjs.org/docs/app/guides/preserving-ui-state; docs only
