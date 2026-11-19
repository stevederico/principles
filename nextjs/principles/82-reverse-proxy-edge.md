# Put a reverse proxy in front and tune it with the app

**Rule:** Terminate untrusted traffic at a reverse proxy that handles malformed requests, slow connections, payload limits and rate limits so the app server only renders, set the app's keep-alive timeout longer than the proxy's idle timeout, and compress in the framework only when nothing in front does.

**Why:** Offloading request validation frees the server for rendering. If the app closes an idle connection first, the proxy reuses a dead connection and returns errors. Double compression wastes CPU, and a proxy with a better codec should own it.

**Do:**
```
proxy: limits, slow-client protection, rate limits, compression
app.keep_alive_timeout = proxy.idle_timeout + margin
app.compress = false when the proxy compresses
```

**Don't:** Expose the app process directly, keep the shorter default timeout behind a long-lived proxy pool, or disable compression with nothing else doing it.

**Break it when:** A managed platform already provides these layers.

**Source:** https://nextjs.org/docs/app/guides/self-hosting, https://nextjs.org/docs/app/api-reference/cli/next, https://nextjs.org/docs/app/api-reference/config/next-config-js/compress; code: packages/next/src/cli/next-start.ts, packages/next/src/server/lib/start-server.ts, packages/next/src/server/lib/router-server.ts
