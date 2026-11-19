# Optimistic updates rest on server truth

**Rule:** Render a temporary value over the server-provided one for the life of the pending mutation, cancel in-flight reads of that key first, keep a snapshot, restore it on failure, and use one pure reducer for both the client prediction and the server transition.

**Why:** An in-flight read could overwrite the optimistic value, rollback keeps correctness, and a shared reducer stops the prediction and the real result from diverging. Reading the optimistic value (not the stale prop) makes rapid repeats correct.

**Do:**
```
on_mutate(): cancel(key); prev = get(key); set(key, reduce(prev, action))
on_error(): set(key, prev)
on_success(): refetch if the server result may differ
```

**Don't:** Apply optimistic data with no rollback path, mirror server data into local state and sync it by hand, or write separate client and server transition logic.

**Break it when:** Outcome is likely to fail or irreversible (payments); show pending state instead of a guessed result.

**Source:** https://nextjs.org/docs/app/guides/interactive-apps, https://nextjs.org/docs/app/guides/single-page-applications, https://nextjs.org/docs/app/guides/client-side-data-fetching/tanstack-query; docs only
