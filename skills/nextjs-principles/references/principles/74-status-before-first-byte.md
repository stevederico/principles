# Decide the status code before streaming starts

**Rule:** Run existence and permission checks that decide a 404, 401, 403 or redirect before the first byte is sent; for a failure found later, render the fallback UI in place with a no-index marker, because the response is already a 200.

**Why:** Headers go out with the first chunk. A not-found raised inside a streamed region becomes in-stream error UI (crawlers may call it a soft 404, hence the robots marker), and a redirect from there becomes a client-side one. A real status needs the check to come first, even if it delays the shell.

**Do:**
```
route(request):
  if not exists(id): return 404              # before any boundary or fallback
  stream shell
late failure: render error ui + noindex
```

**Don't:** Call not-found from inside a streamed child and expect a 404 status, or stream a protected page and then try to send 401.

**Break it when:** The latency of a pre-check outweighs the value; keep such checks cheap and avoid fetching full content in the interceptor.

**Source:** https://nextjs.org/docs/app/guides/streaming, https://nextjs.org/docs/app/api-reference/file-conventions/loading, https://nextjs.org/docs/app/api-reference/functions/not-found, https://nextjs.org/docs/app/guides/optimizing-the-static-shell; code: packages/next/src/server/app-render/app-render.tsx, packages/next/src/server/app-render/make-get-server-inserted-html.tsx
