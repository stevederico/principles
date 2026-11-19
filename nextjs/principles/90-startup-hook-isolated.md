# Run a startup hook once, and keep reporters from taking the app down

**Rule:** Expose one startup function called once per server instance that completes before requests are accepted and is where monitoring registers, branch on the runtime there, and isolate error reporters so their own failures are logged rather than rethrown; keep early client code synchronous and fast.

**Why:** Monitoring must wrap everything from the first request, and a failed startup registration is surfaced rather than hidden. The error reporter fires after the original error was already raised, so rethrowing would mask it. Fire-and-forget async work in early client code may finish after hydration begins.

**Do:**
```
register():                                  # awaited before serving
  if runtime == "node": import monitoring
on_request_error(err): try: report(err) catch: log
early client file: static imports only
```

**Don't:** Import side-effect modules at file top for all runtimes, let reporting exceptions replace the real error, or load a polyfill by dynamic import and assume it is ready.

**Break it when:** Reporting is a compliance requirement; fail closed deliberately.

**Source:** https://nextjs.org/docs/app/guides/instrumentation, https://nextjs.org/docs/app/api-reference/file-conventions/instrumentation, https://nextjs.org/docs/app/api-reference/file-conventions/instrumentation-client; code: packages/next/src/server/next-server.ts, packages/next/src/server/lib/router-utils/instrumentation-globals.external.ts
