# Route protected reads through one server-only data layer

**Rule:** Send every read of protected data through a single server-only module that verifies the session first and returns only the fields the caller may see.

**Why:** The check runs wherever the data function is called, so no developer can forget it, and auditors review one place. Projected fields keep password hashes and contact details out of client code. A per-request memo of the verify step avoids repeated lookups in one render but does nothing in actions or handlers, which always re-run it.

**Do:**
```
verify_session = per_request_memo(read_cookie -> decrypt -> redirect if invalid)
get_profile(slug):
  viewer = verify_session()
  row = db.select(only_needed_columns)
  return { name: can_see_name(viewer) ? row.name : null }
```

**Don't:** Return whole database rows, scatter session checks across components, or export a raw query that takes a user id from callers.

**Break it when:** A throwaway prototype; still check at the data call. An organization whose API layer already enforces this.

**Source:** https://nextjs.org/docs/app/guides/authentication, https://nextjs.org/docs/app/guides/data-security; docs only
