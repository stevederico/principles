# Infer from usage when unambiguous; demand a choice when not

**Rule:** Infer a type from usage when exactly one candidate appears, accept an explicit override, fall back to a neutral default when none appears, and when several differ, fail with a message that names the fix instead of guessing.

**Why:** The handler macro collects the state types named in arguments: one is used, none means unit, several give "can't infer state type, set it explicitly". The derive follows the same rule for its state, with fail tests for the ambiguous case.

**Do:**
```
states = distinct(state types in arguments)
0 -> default; 1 -> that one; >1 -> error("can't infer state type, please set it explicitly")
```

**Don't:** Silently pick one of several candidates.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-macros/src/lib.rs (state inference docs); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/debug_handler.rs; https://github.com/tokio-rs/axum/blob/main/axum-macros/src/from_request/mod.rs (state inference).
