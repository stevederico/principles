# Start independent reads together

**Rule:** Start independent reads immediately and wait for them together; wait one after another only when the second needs the first's result, preload when blocking work comes first, and keep independent suspending reads in sibling components.

**Why:** Sibling segments render in parallel but two waits in one function run serially, and a suspending read stops its component so a second read in it starts late. Nesting boundaries changes reveal order, not request order. A preload must share one deduplicated call or it doubles the work.

**Do:**
```
a = start(get_artist); b = start(get_albums)
[artist, albums] = wait_all([a, b])
start(get_item)                              # preload, same memoized call
ok = wait(check_available())
```

**Don't:** Wait for call one then call two when they are independent, or put two suspending reads in one component.

**Break it when:** The second call depends on the first; isolate that part behind its own boundary.

**Source:** https://nextjs.org/docs/app/getting-started/fetching-data, https://nextjs.org/docs/app/guides/optimizing-the-static-shell, https://nextjs.org/docs/app/guides/client-side-data-fetching/swr; docs only
