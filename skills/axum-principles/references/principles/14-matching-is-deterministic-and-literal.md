# Route matching is deterministic and independent of order

**Rule:** Match only on literal text and capture position, with fixed precedence, independent of registration order; leave value validation to the handler.

**Why:** A static segment beats a capture, and a capture with a longer literal prefix or suffix beats a shorter one. A capture must be non-empty, a wildcard needs at least one segment, and any pair of patterns that could match the same path is rejected at registration. The router cannot constrain a segment by type or pattern, so there are no hidden overlap rules. Tests also pin that merging in any grouping gives the same routes.

**Do:**
```
route("/users/me", a)          # wins over
route("/users/{id}", b)        # handler parses id as an integer
```

**Don't:** Embed regex or type constraints in the router, or let merge order change precedence.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/route.md ("Captures", "Wildcards", "Panics"); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/path_router.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (precedence tests); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/merge.rs (grouping tests).
