# Check Origin against the host on every mutation

**Rule:** Accept state-changing requests only as POST, compare the Origin header's host with the host the server believes it serves (preferring the forwarded host), reject mismatches, and allow extra hosts only through an explicit allowlist of the public hosts browsers show.

**Why:** Browsers attach cookies cross-site, so matching origin to host blocks forgery alongside same-site cookies. Proxies rewrite the host, so the allowlist admits trusted fronts without disabling the check. In the code a request with no Origin header is let through with a warning, because hand-built requests carry no ambient credentials, so this check is a browser guard and never a substitute for authentication.

**Do:**
```
origin = request.origin; host = forwarded_host or host
if origin missing: warn, allow             # no ambient credentials
elif origin.host != host and origin.host not in allowed_origins: abort
```

**Don't:** Allow GET for mutations (also breaks with prefetch), put the proxy's internal host in the allowlist, or assume the check blocks every non-browser caller.

**Break it when:** The endpoint authenticates each call with a non-cookie token, where forgery does not apply.

**Source:** https://nextjs.org/docs/app/guides/data-security, https://nextjs.org/docs/app/api-reference/config/next-config-js/serverActions, https://nextjs.org/docs/app/guides/server-actions; code: packages/next/src/server/app-render/action-handler.ts
