# Make static guarantees fail the build

**Rule:** When a route must stay prebuilt, state the requirement per segment at the strictest level needed (shared shell, link prefetch, whole navigation); any later change that adds blocking work then fails the build and names the first blocked access with labeled exits.

**Why:** A mixed route can quietly regress into per-request compute. Children may only tighten a parent's guarantee, never loosen it, so editing one leaf cannot silently undo a promise made above it. Blocking is still allowed but must be a visible, deliberate choice.

**Do:**
```
segment.require_static = prefetch           # stricter implies weaker
build error names the access and offers:
  [stream] wrap in fallback | [cache] give it a lifetime | [block] declare the route blocking
```

**Don't:** Silence the error without choosing an exit, or mix an opt-out with a stricter requirement in the same chain.

**Break it when:** The page is truly personalized; use a fallback boundary with a static default and accept the server work.

**Source:** https://nextjs.org/docs/app/guides/keeping-pages-static, https://nextjs.org/docs/app/guides/building, https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config/ensureStatic; code: packages/next/src/server/app-render/segment-config/ensure-static.ts, packages/next/src/build/utils.ts
