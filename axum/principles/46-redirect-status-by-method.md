# Choose the redirect status by what must happen to the method

**Rule:** Use 303 to make the follow-up a GET (after a form post), 307 to repeat the same method and body temporarily, 308 for permanent moves; do not use 301 or 302 for requests that carry a body.

**Why:** The changelog replaced 301 with 308 for slash redirects so clients stop converting non-GET requests to GET. The constructors map only to 303, 307 and 308, and 304 is excluded because it has no Location. A redirect may also carry a body, which the RFC recommends for 303.

**Do:**
```
after_form_post -> redirect.see_other(url)        # 303
moved_for_good  -> redirect.permanent(url)        # 308
```

**Don't:** Guess between 301 and 302, or allow an arbitrary status in a redirect type.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/response/redirect.rs (constructors, docs); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (301 to 308); https://github.com/tokio-rs/axum/blob/main/examples/tls-rustls/src/main.rs.
