# Build routers without their state, supply it once, finalize before serving

**Rule:** Let sub-routers declare the state they still need, supply that state once at the top, and finalize the table before serving so assembly work happens once, not per request.

**Why:** The router's type records the missing state, so an unfinished router cannot be served. Routes are held as erased callables that accept state later; finalizing binds handlers to state and layers eagerly. The docs recommend returning the unfinished router from helpers and calling the state step last, even with an empty state before serving, for fewer allocations.

**Do:**
```
function user_routes() -> RouterMissing(AppState): return Router().route(...)
app = Router().nest("/users", user_routes()).provide(AppState(...))   # now complete
serve(app)
```

**Don't:** Create global singletons for handlers to reach, or build handler stacks per request or per connection.

**Break it when:** A library that needs a self-contained router returns a finished one.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/with_state.md ("What S in Router<S> means", "A note about performance"); https://github.com/tokio-rs/axum/blob/main/axum/src/boxed.rs (BoxedIntoRoute); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/mod.rs (with_state, into_make_service, finalized flag).
