# Streaming only works if no layer buffers

**Rule:** Check every proxy, load balancer, CDN, compression layer and runtime between client and app for buffering, and verify with real chunk timing rather than a tiny demo or line-buffered tools.

**Why:** One buffering layer turns progressive output into one delayed response and the first-byte benefit disappears. Compression can hold chunks, some serverless modes need explicit streaming, and some browsers buffer the first kilobyte.

**Do:**
```
test: request a route with two timed regions; log arrival time of each chunk
every hop: buffering off, compression flushes per chunk
```

**Don't:** Assume streaming works behind any proxy or judge it from a small local demo.

**Break it when:** Static export has no streaming at all; platforms that buffer still work, minus progressive delivery.

**Source:** https://nextjs.org/docs/app/guides/streaming, https://nextjs.org/docs/app/guides/self-hosting; docs only
