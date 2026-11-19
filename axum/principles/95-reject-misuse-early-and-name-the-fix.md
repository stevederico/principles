# Reject misuse before runtime and say how to fix it

**Rule:** Where the type system or build step can reject misuse, reject it, and make the message name the cause, point at the offending argument and give the workaround; point panics at the caller's line.

**Why:** Version 0.6 turned runtime failures into compile errors for state and body consumption. The handler check says which type consumes the body and must be last, names both when two do, and tells you to nest arguments in a tuple past 16. The derives reject unknown or duplicate attribute keys and unsupported shapes with a message naming what is supported. Core traits carry a custom "not a valid extractor" note with a docs link, and misleading suggestions are hidden.

**Do:**
```
error("{T} consumes the body so it must be last")
error("too many arguments (max 16); group them in a tuple")
```

**Don't:** Leave users with a wall of generic bound errors, or silently accept a typo in configuration.

**Break it when:** Dynamic languages use build-time validation errors instead (the same principle without types).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.6 compile-time errors); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/debug_handler.rs (check_input_order, argument limit); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/attr_parsing.rs; https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/mod.rs (on_unimplemented notes); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/from_request/mod.rs.
