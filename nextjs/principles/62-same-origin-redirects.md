# Redirect targets from input must be same-origin

**Rule:** Before redirecting to a destination taken from request input, parse it against your own base and reject any whose origin differs; for callback and preview flows redirect to a path your content source returns, never to the raw query value.

**Why:** An unchecked redirect target is an open redirect that makes your domain vouch for an attacker's page. Programmatic client navigation likewise must not receive untrusted script-scheme URLs.

**Do:**
```
dest = parse_url(input or "/", base = request.url)
if dest.origin != request.origin: return 400
set_session_cookie(...); redirect(dest)
preview: post = cms.get(slug); redirect(post.path)
```

**Don't:** Redirect to a query parameter as-is, or hand untrusted values to a navigation call.

**Break it when:** A vetted allowlist of external hosts exists.

**Source:** https://nextjs.org/docs/app/guides/backend-for-frontend, https://nextjs.org/docs/app/guides/draft-mode, https://nextjs.org/docs/app/api-reference/functions/use-router; code: packages/next/src/client/components/app-router-instance.ts
