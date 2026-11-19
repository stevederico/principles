# Make the build verify what it can

**Rule:** Fail the production build on type errors (or run the checks in CI if you skip them), generate a route table so links are checked at compile time, require config the build reads to be literals, and reject contradictory or dependent options at startup with a message naming the fix.

**Why:** Skipping the check removes it entirely rather than hiding errors. The build reads route-level cache and matcher values by static analysis before running code, so an expression cannot be evaluated. Silent mis-combinations (a feature without its prerequisite, one package both bundled and external) otherwise fail deep in the pipeline. On two contradictory cache directives the safe fallback is to drop both and warn.

**Do:**
```
build: type_check() -> fail
link(route_type)        # only known routes, explicit cast for computed paths
revalidate = 600        # literal, not 60 * 10
config load: if feature_b and not feature_a: error("enable A first")
```

**Don't:** Set ignore to unblock a deploy with no CI stage, cast everything to the route type, or compute config from the environment.

**Break it when:** A monorepo validating other teams' code you do not control; use a relaxed config for the build only. Routes come from a CMS at runtime.

**Source:** https://nextjs.org/docs/app/api-reference/config/typescript, https://nextjs.org/docs/app/api-reference/config/next-config-js/typescript, https://nextjs.org/docs/app/api-reference/config/next-config-js/typedRoutes, https://nextjs.org/docs/app/guides/caching-without-cache-components; code: packages/next/src/build/type-check.ts, packages/next/src/build/segment-config/app/app-segment-config.ts, packages/next/src/server/config.ts, packages/next/src/server/lib/patch-fetch.ts
