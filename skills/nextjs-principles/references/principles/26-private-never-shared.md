# Per-user data never enters a shared cache

**Rule:** Model three scopes explicitly (shared in process, shared remote, private per client), forbid nesting a private scope inside a shared one, pass per-user inputs as arguments so they become the key, and use only opaque identifiers in keys and tags.

**Why:** A shared entry computed from one person's request data would be served to others, so the framework refuses cookie and header reads in shared scopes. Keys and tags are stored as written, unhashed, in memory and in remote stores. A private scope lives only in the client's memory and is a fallback for cases where refactoring is impractical.

**Do:**
```
get_notes():                                 # exported: does the auth
  u = current_user()
  return notes_by_user(u.id)
notes_by_user(id):                           # not exported, shared cache, tag "notes:" + id
```

**Don't:** Export the inner function (callers could pass another user's id), tag with an email or token, or reach for private caching as the default.

**Break it when:** Compliance requires request data to stay out of any persistent server cache; then use the private scope.

**Source:** https://nextjs.org/docs/app/api-reference/directives/use-cache-private, https://nextjs.org/docs/app/guides/authentication-with-cache-components, https://nextjs.org/docs/app/api-reference/directives/use-cache-remote; code: packages/next/src/server/request/cookies.ts, packages/next/src/server/use-cache/use-cache-messages.ts
