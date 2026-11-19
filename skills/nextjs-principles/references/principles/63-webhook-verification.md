# Authenticate webhooks before acting, over the raw body

**Rule:** A webhook endpoint that triggers invalidation or side effects must verify a shared secret or the provider's signature before doing anything, compute the signature over the unparsed request bytes, validate its parameters, and cap how many bytes it will read.

**Why:** Handlers are public, so anyone could trigger revalidation or effects. Signatures cover exact bytes and re-serializing a parsed body can change them; an unbounded body is a memory and denial-of-service risk.

**Do:**
```
webhook(request):
  raw = read_bytes(request, max = limit)
  if not verify_signature(raw, header): return 401
  if missing(tag): return 400
  invalidate(tag); return ok
```

**Don't:** Leave webhook URLs unauthenticated, parse then re-serialize JSON to verify, or put long-lived secrets in a URL that gets logged when a header works.

**Break it when:** The payload is not signed by the provider; use a shared secret header instead.

**Source:** https://nextjs.org/docs/app/guides/backend-for-frontend, https://nextjs.org/docs/app/api-reference/file-conventions/route, https://nextjs.org/docs/pages/building-your-application/routing/api-routes; code: packages/next/src/server/api-utils/node/api-resolver.ts
