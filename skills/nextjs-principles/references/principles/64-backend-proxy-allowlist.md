# Proxy to a backend through a fixed table and an allowlist of headers

**Rule:** When a handler forwards to an upstream, map caller-supplied keys to a fixed table of upstream paths, attach a server-held credential, forward only an allowlist of headers, refuse redirects, and return a generic message on upstream failure.

**Why:** If the upstream path or host comes from the request, a caller can point your credential at another destination; copying every incoming header forwards the user's cookie and authorization. Response headers set from request headers leak, and a response header shorthand can override framework-owned content types. A handler buffers whole bodies, so stream large payloads through the platform instead.

**Do:**
```
ENDPOINTS = { "checkout": "/v1/checkout" }
path = ENDPOINTS[key]; if none: return 404
resp = fetch(UPSTREAM + path, redirect = "error", headers = { auth: server_token, accept: ... })
if not resp.ok: return 502 "generic"
```

**Don't:** Build the upstream URL from request input, pass the raw header set, or copy incoming headers onto the response.

**Break it when:** Large or streaming payloads; use a rewrite instead of a buffering handler.

**Source:** https://nextjs.org/docs/app/guides/backend-for-frontend, https://nextjs.org/docs/app/api-reference/functions/next-response; code: packages/next/src/server/web/spec-extension/response.ts
