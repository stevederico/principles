# A new connection must cost no more than a request

**Rule:** Per-connection setup should hand out a cheap handle to an already-assembled application; finalize the router once and never deep-clone routing tables per connection.

**Why:** A regression test counts service clones and requires the first request on a new connection to clone no more than a later request. The comment records the old bug: each accepted connection deep-cloned every route and kept the copy for the connection's lifetime. Serve finalizes the router in place once so routes move rather than copy.

**Do:**
```
app = router.with_state(s)               # once
per_connection: handle = app.shared_ref()    # constant cost
test: clones(first_request_on_new_connection) == clones(later_request)
```

**Don't:** Build or clone the full handler stack per request or per connection.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (new_connection_does_not_clone_route_services test); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/mod.rs (with_state, into_make_service).
