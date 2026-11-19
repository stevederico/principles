# Read metadata freely, consume the body once and last

**Rule:** Split input extractors into two kinds: those that only look at request metadata (any number, any order) and those that consume the one-shot body (at most one, always last).

**Why:** A body is a stream that can be read once. Extraction runs left to right, and the framework enforces the split structurally: every argument but the last must be a metadata extractor, and a metadata extractor is automatically usable in the last slot too.

**Do:**
```
handler h(method, headers, state, body_json):   # body extractor last
    # metadata extractors run in order, then the body extractor gets the rest
```

**Don't:** Let two extractors both consume the body and discover at runtime that the second one saw nothing.

**Break it when:** A wrapper extractor that must work in either position implements both modes and forwards to the inner extractor (extract.md, "Wrapping extractors"). To read the body twice, buffer it in middleware and rebuild the request (the consume-body example).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/extract.md ("The order of extractors", "Wrapping extractors"); https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/mod.rs (FromRequestParts, FromRequest); https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/tuple.rs (parts first, body last); https://github.com/tokio-rs/axum/blob/main/examples/consume-body-in-extractor-or-middleware/src/main.rs.
