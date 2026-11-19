# Choose redirect status by intent and the layer by what you know

**Rule:** Use 307 or 308 so a POST stays a POST, 308 only when the canonical URL has really moved, and 303 after a form post so the browser follows with a GET; put known path moves in static config, conditional ones in a request interceptor, post-mutation ones in server code, and keep one canonical URL form with a canonical tag if you serve both.

**Why:** Legacy 301 and 302 let clients rewrite the method and drop the body; permanent redirects are cached by clients and search engines indefinitely. Config redirects run before the interceptor, which runs before render, so the earliest layer that knows the answer wins. Duplicate URL forms split caches and search signals.

**Do:**
```
moved forever:        308
auth or mutation:     307, or 303 after a form post
known old -> new:     static config
thousands of rules:   small membership filter in the hot path, full lookup on hit
```

**Don't:** Use a permanent redirect for anything conditional, redirect on the client what the server can express, or turn off the slash redirect with no canonical tag.

**Break it when:** The old URL is retired for good, or legacy clients need 301 or 302 on a GET-only resource.

**Source:** https://nextjs.org/docs/app/guides/redirecting, https://nextjs.org/docs/app/api-reference/functions/redirect, https://nextjs.org/docs/app/api-reference/config/next-config-js/redirects, https://nextjs.org/docs/app/api-reference/config/next-config-js/trailingSlash; code: packages/next/src/lib/redirect-status.ts, packages/next/src/client/components/redirect-status-code.ts, packages/next/src/lib/load-custom-routes.ts
