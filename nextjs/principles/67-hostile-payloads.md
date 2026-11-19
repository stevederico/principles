# Treat inbound payloads as hostile

**Rule:** Validate content type and size, set timeouts, answer with generic error messages, keep sensitive data in bodies rather than URLs, escape serialized data embedded in markup, and back rate limits with shared state when more than one instance runs.

**Why:** Public handlers leak internals through detailed errors, and raw interpolation of input into XML or HTML enables injection, including a closing tag inside embedded JSON. In-memory counters are per instance, and a public response served from a CDN never reaches your handler, so no limit or credential check runs.

**Do:**
```
if content_type not allowed or size > max: return 413 or 415
parsed = validate(body)                       # body typed as unknown
embed json: escape "<" in the serialized text
if shared_counter.incr(client_key) > limit: return 429
authenticated responses: cache-control private or no-store
```

**Don't:** Echo exception messages, put coordinates or tokens in a GET query string, or send a public max-age on user-specific data.

**Break it when:** A single-instance hobby app may keep counters in memory; internal-only endpoints still validate.

**Source:** https://nextjs.org/docs/app/guides/backend-for-frontend, https://nextjs.org/docs/app/guides/json-ld, https://nextjs.org/docs/pages/building-your-application/routing/api-routes; code: packages/next/src/server/api-utils/node/api-resolver.ts
