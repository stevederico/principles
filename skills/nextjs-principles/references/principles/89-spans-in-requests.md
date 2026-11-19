# Create spans while serving a request

**Rule:** Start custom spans in code that runs while a request is served, never at module load or in the startup hook, and always end them.

**Why:** Spans started before the tracer provider exists are dropped, and spans created in the startup hook become separate root traces instead of children of a request.

**Do:**
```
handler(request):
  span = tracer.start("load_items"); try: work() finally: span.end()
```

**Don't:** Open a span at file top level and expect it to nest under a request, or forget to end it.

**Break it when:** You are measuring startup itself; accept a standalone root trace.

**Source:** https://nextjs.org/docs/app/guides/open-telemetry; code: packages/next/src/server/lib/trace/tracer.ts
