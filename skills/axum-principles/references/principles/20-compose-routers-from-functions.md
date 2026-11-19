# Build each feature as a router-returning function

**Rule:** Build each feature as a function that returns a router of the common type, then combine with merge or nest; attach group-specific layers inside each function.

**Why:** Since 0.3 the router type is the same however many routes or layers it holds, so groups can be named and returned. Nested routers must share the state type. Giving each group its own router lets it carry its own guards without touching the others.

**Do:**
```
function users() -> Router: return Router().route("/users", get(list))
function admin() -> Router: return Router().route("/keys", delete(clear)).layer(bearer_guard)
app = Router().merge(users()).nest("/admin", admin())
```

**Don't:** Build one giant route chain in main so groups cannot have their own middleware.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.3, single Router type); https://github.com/tokio-rs/axum/blob/main/examples/routes-and-handlers-close-together/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/key-value-store/src/main.rs.
