# Deprecate with a window, a shim, a warning and a codemod

**Rule:** When an API changes shape (sync to async, an extra required argument), keep the old form working for one release with a visible deprecation, ship an automated migration, point warnings at the replacement, and remove the old form completely in the next major.

**Why:** Callers get time to move and the runtime warning names the replacement. Flipping implicit caching to opt-in is the same pattern at larger scale: surprising users with stale data from invisible defaults is worse than a clear opt-in. Removed items should have been inert warnings or no-ops for several releases first.

**Do:**
```
release N:   old form works + dev warning + typed "unsafe" shim + codemod
release N+1: old form removed
```

**Don't:** Break callers silently, keep the shim forever, or remove public API in a minor with no warning period.

**Break it when:** A security fix demands immediate removal.

**Source:** https://nextjs.org/docs/app/guides/upgrading/version-15, https://nextjs.org/docs/app/guides/upgrading/version-16, https://nextjs.org/docs/app/api-reference/functions/revalidateTag, https://nextjs.org/docs/pages/guides/upgrading/version-11; code: packages/next/src/server/web/spec-extension/revalidate.ts
