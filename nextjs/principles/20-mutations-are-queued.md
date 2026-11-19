# Mutations dispatch one at a time; reads stay out of them

**Rule:** Use server mutation functions only for writes, never for reads, and do not rely on the client firing several at once; batch parallel work inside one server call.

**Why:** The client queues mutation calls so the re-rendered tree always matches the result that produced it, which turns reads made this way sequential. Serverless hosts also keep no memory between calls.

**Do:**
```
reads:  render on the server, or a client data library
writes: mutate(input)                        # keep state in an external store
parallel writes: one server call does both
```

**Don't:** Fetch data with a mutation call, or start two mutations from the client expecting overlap.

**Break it when:** Long-lived server with controlled state; plain fetch for non-mutating requests.

**Source:** https://nextjs.org/docs/app/guides/server-actions, https://nextjs.org/docs/app/guides/backend-for-frontend; code: packages/next/src/client/components/app-router-instance.ts
