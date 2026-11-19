# Offer an opt-in check that re-verifies each handler requirement

**Rule:** Ship an opt-in annotation for handlers that re-checks every reason a function might fail to qualify (not async, too many arguments, wrong extractor order, two body extractors, response type, thread-safety) and produces a targeted message for each; make it free in release builds.

**Why:** The baseline error is a long "does not implement the handler trait" message. The macro checks each argument against the metadata-extractor and whole-request-extractor interfaces by position, the return type against the response trait, and the future's thread-safety. It skips generic functions to avoid extra confusing errors, and does nothing in release.

**Do:**
```
debug_handler(fn): assert async; assert args <= 16; for each arg but last: assert MetadataExtractor
last: assert Extractor; assert return is Response-convertible; assert future is thread-safe
```

**Don't:** Rely on the generic bound error for user-facing diagnostics, or ship the checks in production.

**Break it when:** Generic functions are skipped, and associated functions without a receiver are unsupported (macro docs, "Limitations").

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-macros/src/lib.rs (debug_handler docs: "Performance", "Limitations"); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/debug_handler.rs.
