# State what the framework will not abstract

**Rule:** Document what the framework deliberately does not abstract, so users do not expect portability the design cannot deliver.

**Why:** The overview says independence from the async runtime and transport is not a goal, and the serve helper exposes few knobs with a pointer to the lower-level library.

**Do:**
```
non_goals: "single async runtime; no transport abstraction"
```

**Don't:** Promise portability the design cannot deliver.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/lib.rs (runtime and transport note); https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (docs).
