# Run non-critical work after the response

**Rule:** Schedule logging, analytics and similar side work to run after the response is sent, read any request-scoped values before scheduling, and expect the callback to run even after an error or redirect.

**Why:** It keeps the response fast. In render code the framework must know which part of the tree reads request data, and deferred callbacks run outside that tracking, so reading ambient request data inside them throws. Serverless hosts must provide a way to extend the invocation's lifetime.

**Do:**
```
page():
  ua = read_header("user-agent")             # before scheduling
  after_response(() -> log(ua))
```

**Don't:** Call request accessors inside the deferred callback during rendering, or wait for slow logging before replying.

**Break it when:** The work is required for correctness of the reply (a payment record); do it before replying.

**Source:** https://nextjs.org/docs/app/api-reference/functions/after, https://nextjs.org/docs/app/guides/self-hosting; code: packages/next/src/server/after/after.ts, packages/next/src/server/request/cookies.ts
