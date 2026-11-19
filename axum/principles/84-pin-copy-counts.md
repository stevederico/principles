# Pin how many times state and services are cloned

**Rule:** Pin the number of times shared state or route services are copied per request, using a counting double that records a filtered stack trace on each counted copy.

**Why:** A counting state type counts only after setup finishes and prints framework frames; tests assert exactly three copies for a route, a fallback and a function middleware, and that merged service routes cost the same as direct ones.

**Do:**
```
state = CountingState(); app = build(state); state.setup_done()
send request; assert state.clone_count == 3
```

**Don't:** Assume "clone is cheap" without measuring, or assert a bare number with no clue where extra copies came from.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/test_helpers/counting_cloneable_state.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (clone count tests); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/merge.rs.
