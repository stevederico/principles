# Do not gate access in layouts

**Rule:** Put authorization checks in the data layer or in the component that renders the protected content, never solely in a shared layout, and remember that choosing which server-rendered region to show is not access control.

**Why:** Layouts are not re-rendered on client navigation, so a check there does not run per route change, and they do not control whether child segments or parallel slots render. Every region still executes on the server, so a conditional changes only what the user sees. A wait on session data at the top of a layout holds all children behind it, and an auth redirect after streaming starts cannot change the 200 status.

**Do:**
```
layout: chrome + boundary(fallback): user_menu()   # reads the user in the child
page: user = get_user_or_redirect()
each region's data function authorizes itself
```

**Don't:** Return nothing from a layout when unauthorized, wait for the session at the top of a layout, or fetch privileged data in a region and rely on the layout to hide it.

**Break it when:** Cosmetic hiding only.

**Source:** https://nextjs.org/docs/app/guides/authentication, https://nextjs.org/docs/app/guides/optimizing-the-static-shell, https://nextjs.org/docs/app/api-reference/file-conventions/parallel-routes; docs only
