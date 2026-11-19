# Nest error boundaries; the nearest one catches

**Rule:** Place error boundaries at several levels of the route tree so a failure replaces the smallest region that owns it, give each a retry that redoes the failed work and a logging hook, and make the root fallback self-contained with its own document shell, styles and theme.

**Why:** Errors bubble to the nearest boundary, so segment-level ones keep layouts and siblings alive. The root fallback replaces the shell, and the global not-found bypasses layouts, so inherited styles and theme are absent. A reset that only clears the error flag replays the same failed server result.

**Do:**
```
segment/error_ui(error, retry): log(error); button("Try again") -> refetch_then_rerender()
root/global_error: full document (html, body, own styles), light
```

**Don't:** Rely on one top-level boundary, assume theme classes reach the root fallback, or import heavy interactive code into it.

**Break it when:** A small app where one boundary is enough.

**Source:** https://nextjs.org/docs/app/getting-started/error-handling, https://nextjs.org/docs/app/api-reference/file-conventions/error, https://nextjs.org/docs/app/api-reference/functions/catchError; code: packages/next/src/client/components/error-boundary.tsx, packages/next/src/client/components/builtin/global-error.tsx
