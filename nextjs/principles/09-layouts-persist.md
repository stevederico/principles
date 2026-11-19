# Layouts persist, so keep per-navigation inputs out

**Rule:** Put chrome that should keep state in a layout, and read per-navigation values (path, query, request) only in leaf components that re-render on navigation.

**Why:** A layout is reused across sibling pages and not re-rendered, so any value computed from the current URL goes stale; the framework withholds the query from layouts and hands it only to pages.

**Do:**
```
layout(nav, children)                        # persistent
nav_link():                                  # small leaf reads live path
  active = (current_path == href)
```

**Don't:** Compute active-nav state or search filters in the layout body, or expect a layout to update on every navigation.

**Break it when:** State must reset on navigation; use the keyed variant that remounts per segment.

**Source:** https://nextjs.org/docs/app/getting-started/layouts-and-pages, https://nextjs.org/docs/app/api-reference/file-conventions/layout, https://nextjs.org/docs/app/api-reference/functions/use-search-params; code: packages/next/src/server/app-render/create-component-tree.tsx
