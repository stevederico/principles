# Keep test-control hooks out of user-facing builds

**Rule:** Compile test-control APIs into a build only when a dedicated flag is on, tie the flag to the feature it tests, refuse to start if that feature is off, and never enable it on user-facing deployments.

**Why:** An API that can pause rendering or inspect internals is an attack and reliability surface in production. A separate test build keeps release artifacts clean, and the prerequisite check catches a flag that would have no effect.

**Do:**
```
test build: expose_testing_api = on at build and start
release build: off; config load errors if the flag is on without its feature
```

**Don't:** Enable the flag only at start time on an existing build (it does not add the API), or leave it on for real traffic.

**Break it when:** Preview or local environments that never face users.

**Source:** https://nextjs.org/docs/app/guides/testing/playwright, https://nextjs.org/docs/app/api-reference/config/next-config-js/exposeTestingApiInProductionBuild; code: packages/next/src/server/config.ts, packages/next/src/server/base-server.ts
