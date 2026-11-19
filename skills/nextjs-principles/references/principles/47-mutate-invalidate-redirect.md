# Mutate, then invalidate, then redirect

**Rule:** Inside a mutation perform the write first, invalidate the affected data next, and redirect last; let one response carry both the return value and the refreshed view.

**Why:** A redirect is implemented as a thrown control-flow exception, so code after it never runs, while invalidation calls do not throw and leave the function able to return a value. Invalidating before the redirect makes the destination show fresh data, and one round trip avoids a follow-up fetch.

**Do:**
```
save(input):
  write(db, input)
  invalidate(tag)
  redirect(target)                           # last line, throws
```

**Don't:** Put work after the redirect, wrap it in a catch-all, or follow every mutation with a manual refetch.

**Break it when:** The destination does not depend on the changed data, or stale-while-refresh invalidation is chosen on purpose.

**Source:** https://nextjs.org/docs/app/getting-started/mutating-data, https://nextjs.org/docs/app/guides/server-actions; code: packages/next/src/client/components/redirect.ts
