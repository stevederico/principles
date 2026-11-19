# Draft preview is a secret-gated, per-viewer cache bypass

**Rule:** Implement draft preview as a per-viewer cookie that makes every cache layer run fresh and store nothing for that viewer, gate the enabling endpoint with a shared secret and a server-side lookup of the target, generate the bypass value fresh each build, and keep enable and disable out of cached scopes and link prefetch.

**Why:** Editors need live content without waiting for revalidation while everyone else keeps the cached copy. An open enable route lets anyone bypass caches for load and cost, a guessable token exposes drafts, and a prefetched disable link clears the cookie before the click. Preview data in a cookie must stay small (a hard cap of 2048 characters), and a fixed cache header on a bypassable path cannot be bypassed.

**Do:**
```
enable(request):
  if request.secret != env.SECRET or not cms.exists(slug): return 401
  set_cookie(bypass_token_for_this_build, httpOnly); redirect(cms.path(slug))
cached read: if preview_cookie: run fresh, no write
```

**Don't:** Toggle the mode inside cached code, use a static token, or set a long public max-age on pages editors must see fresh.

**Break it when:** The CMS has its own preview infrastructure writing to a separate origin.

**Source:** https://nextjs.org/docs/app/guides/draft-mode, https://nextjs.org/docs/app/api-reference/functions/draft-mode, https://nextjs.org/docs/pages/guides/preview-mode; code: packages/next/src/server/lib/patch-fetch.ts, packages/next/src/server/request/draft-mode.ts, packages/next/src/server/api-utils/node/api-resolver.ts, packages/next/src/build/preview-key-utils.ts
