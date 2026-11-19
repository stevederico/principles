# Hand unresolved promises to the client

**Rule:** When an interactive child needs server data, start the fetch without waiting, pass the pending promise across the boundary inside a fallback boundary, and let the child resolve it; share it through a provider scoped to the smallest subtree that needs it.

**Why:** Waiting in the parent holds back the parent's stable UI, while the pending value lets the shell stream at once and removes client-side waterfalls. A promise created high in the tree re-runs whatever created it, so scope matters.

**Do:**
```
posts = start(get_posts())                   # not waited on
boundary(fallback = skeleton):
  client_list(posts)                         # resolves it here
```

**Don't:** Wait before passing the value just to hand it down, pass non-serializable values, or put an app-wide data provider in the root for one subtree.

**Break it when:** The parent needs the value to decide its own output, or data is cheap and needed for a meaningful first paint.

**Source:** https://nextjs.org/docs/app/getting-started/fetching-data, https://nextjs.org/docs/app/guides/optimizing-the-static-shell, https://nextjs.org/docs/app/guides/single-page-applications; docs only
