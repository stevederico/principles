# Choose invalidation strength by who is waiting

**Rule:** After a write, use immediate expiry only inside the mutation handler where the writer must see the result at once; elsewhere (webhooks, passive updates) mark data stale and serve it while refreshing, with an explicit stale window.

**Why:** Immediate expiry makes the next read wait and also refreshes the caller's current view in the same round trip, so it is restricted to mutation entry points and throws elsewhere. Marking stale keeps latency low and spreads recomputation across real traffic. Refresh alone re-renders uncached reads and leaves cached ones untouched.

**Do:**
```
user_write():  expire_now(tag)               # mutation handler only
webhook():     mark_stale(tag, window = max) # or expire(tag, 0) if it must be gone now
untagged dynamic view: refresh()
```

**Don't:** Expire everything immediately from every endpoint, call the immediate form from a webhook, or call invalidate with no profile.

**Break it when:** Slightly stale data is fine everywhere; use time-based expiry alone.

**Source:** https://nextjs.org/docs/app/getting-started/revalidating, https://nextjs.org/docs/app/api-reference/functions/updateTag, https://nextjs.org/docs/app/api-reference/functions/revalidateTag, https://nextjs.org/docs/app/guides/server-actions; code: packages/next/src/server/web/spec-extension/revalidate.ts
