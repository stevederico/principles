# Separate authentication, session and authorization

**Rule:** Design identity as three distinct concerns (prove who you are, remember it across requests, decide what you may touch), use a vetted library for as much as you can, and do cheap cookie-only checks early while making the real permission decision next to the data on every access.

**Why:** Each has its own failure mode and hand-rolled flows grow complex quickly. The early request hook runs on every route including prefetches, so database checks there are costly and it cannot protect actions or nested segments reached other ways; static pages that share data across users still need it to exist at all.

**Do:**
```
authenticate(credentials) -> user
create_session(user.id)   -> token
hook:       if protected(path) and not cookie_valid: redirect(login)   # optimistic
data layer: verify_session_against_store(); check role or ownership    # secure
```

**Don't:** Merge them into one "isLoggedIn" flag, treat the early hook as the only defense, or query the database inside it.

**Break it when:** A trivial internal tool; keep authorization at the data layer even there.

**Source:** https://nextjs.org/docs/app/guides/authentication, https://nextjs.org/docs/app/getting-started/proxy; docs only
