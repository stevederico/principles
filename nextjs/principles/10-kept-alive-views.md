# Kept-alive views need bounds and deliberate resets

**Rule:** When navigation hides previous pages instead of destroying them, keep only a small number of them, reset transient UI (menus, popovers, status messages) explicitly, key stateful subtrees by the identity that owns them, and keep ids unique per instance.

**Why:** Hidden pages retain local state, form input and DOM, so unmount-based cleanup no longer runs; retention without a bound grows memory. The bound of three kept views is stated in the docs only.

**Do:**
```
on_hide(): close_menus(); clear_success_message()
draft_form(key = user.id)                    # new user, new state
id = unique_per_instance()
tests: filter by visible elements
```

**Don't:** Rely on unmount for cleanup, hard-code element ids in reusable components, or let one user's draft appear for the next.

**Break it when:** Every visit must start fresh; reset on submit in the handler.

**Source:** https://nextjs.org/docs/app/guides/preserving-ui-state, https://nextjs.org/docs/app/api-reference/config/next-config-js/cacheComponents; code: packages/next/src/client/components/layout-router.tsx
