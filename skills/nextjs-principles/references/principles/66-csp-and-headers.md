# A nonce policy forces per-request rendering

**Rule:** If the content security policy uses per-request nonces, render every covered page per request; if pages must stay static use build-time script hashes, and set baseline protective headers (no content sniffing, anti-framing, restrictive referrer) on all routes.

**Why:** A nonce must be unique and unguessable per response, but static pages are built with no request or response headers, so none can be injected and scripts get blocked at runtime. Hash-based integrity values are computed at build and keep pages cacheable.

**Do:**
```
strict, per-request: nonce = random(); header(csp, nonce); mark pages dynamic
static pages:        header(csp, script_hashes_from_build)
all routes:          nosniff, frame-deny, referrer = strict
```

**Don't:** Add a nonce policy and leave pages statically built or CDN-cached, or rely on per-page headers.

**Break it when:** A policy allowing inline scripts is acceptable for a low-risk app; set a fixed header and keep static caching. The page must be embedded; allow specific origins only.

**Source:** https://nextjs.org/docs/app/guides/content-security-policy, https://nextjs.org/docs/app/guides/progressive-web-apps; code: packages/next/src/server/app-render/get-script-nonce-from-header.tsx
