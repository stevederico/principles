# Give script-less crawlers a complete head in the first response

**Rule:** Stream metadata after the content for browsers, but for crawlers that read only the first response wait for it and put it in the head, keep the user-agent list configurable, keep first-paint-critical settings (viewport) out of the streamed set, and make sure data the prebuilt shell used at build is also reachable at request time.

**Why:** Streaming improves speed, but social and search previews expect metadata in the first bytes, while script-capable crawlers read the final page. Such bots skip the prebuilt shell and re-render dynamically, so build-time-only data sources that work for people can return an error to them. Oversized or empty agent strings skip detection to bound regex work on untrusted input.

**Do:**
```
if user_agent matches html_only_bots(config): wait for metadata, put in head, no streaming
else: stream metadata after the content
```

**Don't:** Stream preview tags to a client that never runs script, hard-code one bot list, or rely on build-only environment in shell code.

**Break it when:** All traffic is known script-capable, or metadata is fully prerendered.

**Source:** https://nextjs.org/docs/app/getting-started/metadata-and-og-images, https://nextjs.org/docs/app/getting-started/caching, https://nextjs.org/docs/app/api-reference/functions/generate-metadata, https://nextjs.org/docs/app/guides/streaming; code: packages/next/src/shared/lib/router/utils/html-bots.ts, packages/next/src/server/lib/streaming-metadata.ts, packages/next/src/server/base-server.ts
