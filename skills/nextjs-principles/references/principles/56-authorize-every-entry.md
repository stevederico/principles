# Authorize inside every mutation and endpoint

**Rule:** Treat every server-callable mutation and endpoint as publicly reachable and, inside it, authenticate, authorize against the specific resource, validate input and return distinct "unauthenticated" and "forbidden" results; never decide access from client-supplied values such as a query flag or a hidden id.

**Why:** A mutation is an ordinary POST route anyone can call without the UI, and the framework only guards its origin, not who the caller is. Schema validation checks shape, not ownership, so a well-formed object may point at someone else's row. Hiding a button controls the interface, not the data.

**Do:**
```
mutate(item_id, change):
  s = verify_session();   if none: return 401
  if not s.may_edit(item_id): return 403
  validate(change); write(item_id, change)    # owner comes from the session
```

**Don't:** Accept the whole record (id and owner included) from the client, gate only the page that renders the form, or return 200 with an empty body for forbidden.

**Break it when:** A deliberately public action (a newsletter signup) still validates input and rate-limits.

**Source:** https://nextjs.org/docs/app/getting-started/mutating-data, https://nextjs.org/docs/app/guides/data-security, https://nextjs.org/docs/app/guides/server-actions, https://nextjs.org/docs/app/api-reference/directives/use-server; code: packages/next/src/server/app-render/action-handler.ts
