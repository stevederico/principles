# Drain in-flight work, including post-response callbacks

**Rule:** On termination signals stop accepting requests, finish in-flight requests and pending after-response callbacks, and give the platform a drain period of roughly ten to thirty seconds.

**Why:** Work scheduled after the response would otherwise be lost, and a hard kill drops live requests.

**Do:**
```
on SIGTERM: stop_listening(); wait(inflight + after_callbacks, timeout = drain); exit
```

**Don't:** Hard-kill with no grace period, or start work after the response with no way to flush it on shutdown.

**Break it when:** Work is idempotent and short.

**Source:** https://nextjs.org/docs/app/guides/self-hosting, https://nextjs.org/docs/app/api-reference/functions/after; code: packages/next/src/server/lib/start-server.ts
