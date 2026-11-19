# Ambiguous or malformed routes abort at startup

**Rule:** Validate the route table as it is built and abort with a message naming the cause, instead of finding conflicts per request or silently picking a winner.

**Why:** Overlapping paths, paths not starting with a slash, empty or wildcard nest prefixes, nesting at the root, merging two routers that both set a fallback, binding the same method twice on one path, and a route-scoped layer added before any route (a no-op) all fail at construction. Registering a different method on an existing path merges with it; only the same method twice conflicts. The error points at the caller's line, which a dedicated test pins.

**Do:**
```
router.add(path, methods):
    if invalid(path) or same_method_already_bound(path): abort("route conflict: " + path)
router.merge(other): if both have custom fallback: abort
```

**Don't:** Silently drop or shadow the second registration, or rely on "first registered wins".

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/routing/mod.rs (panic_on_err, merge, nest); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/path_router.rs (route, nest); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/method_routing.rs (overlap panic, merge by method); https://github.com/tokio-rs/axum/blob/main/axum/tests/panic_location.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.6 routing notes).
