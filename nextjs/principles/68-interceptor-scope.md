# Keep the request interceptor fast, stateless and complete

**Rule:** Run only cheap decisions (rewrite, redirect, header change, coarse optimistic check) in the pre-routing hook, keep it decoupled from app state, scope it with a literal matcher that excludes assets, and make any guard cover every representation of a resource (the page, its data variants) and behave the same for soft navigation and full load.

**Why:** The hook sits in front of every matched request so slowness multiplies, and it may run at the edge in another runtime, so shared modules and cache scopes do not apply. The framework appends the data-route variants to each matcher so "protected page, unprotected data" cannot happen. One file keeps layered interceptors from growing.

**Do:**
```
hook(request):
  if cheap_condition(request): return redirect(target)
  return pass_through
matcher = only the needed paths, as a build-time literal
real authorization lives in the data layer
```

**Don't:** Query the database or call slow APIs in the hook, import app singletons into it, return different content for soft versus full loads based on internal headers, or make it the only auth check.

**Break it when:** A lookup is unavoidable; use an external fast store rather than the framework cache. A variant is intentionally public: list it explicitly.

**Source:** https://nextjs.org/docs/app/getting-started/proxy, https://nextjs.org/docs/app/api-reference/file-conventions/proxy, https://nextjs.org/docs/app/api-reference/config/next-config-js/skipProxyUrlNormalize; code: packages/next/src/build/analysis/get-page-static-info.ts, packages/next/src/lib/constants.ts
