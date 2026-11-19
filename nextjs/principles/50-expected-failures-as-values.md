# Return expected failures as values; throw for the unexpected

**Rule:** Return validation errors and failed upstream calls to the caller as data shown inline, reserve throwing for bugs and invariant violations, and when a client handler awaits a request clear the old error at the start, treat a non-OK response as failure, and reset loading in a finally block.

**Why:** Expected errors occur in normal operation and must be recoverable inline; thrown errors replace UI at a boundary. Fetch-style calls do not throw on HTTP error status, and a loading flag set only on success leaves the button disabled after failure.

**Do:**
```
create_post(prev_state, form):
  res = call_api(form)
  if not res.ok: return { message: "Failed to create post" }
  return { ok: true }
client: error = none; loading = true; try ... finally loading = false
```

**Don't:** Throw for invalid form input, leave the previous error on screen during a retry, or wrap framework redirect and not-found calls in a catch-all.

**Break it when:** A genuine bug; throw and let the boundary handle it.

**Source:** https://nextjs.org/docs/app/getting-started/error-handling, https://nextjs.org/docs/pages/guides/forms, https://nextjs.org/docs/app/guides/interactive-apps; code: packages/next/src/client/components/not-found.ts
