# Keep error types opaque and open; seal extension traits

**Rule:** Do not expose a third-party error type inside your public error type, mark error enums and reason enums open so new variants are not breaking, and seal extension traits so you can add methods later; callers match with a default arm.

**Why:** Built-in extractors hide inner errors so implementations can change; callers who dig through the cause chain accept that it may break without a major version. Rejection types and the path error kind are marked open, and the path error wraps its deserializer error so the library's trait does not leak. A changelog notes adding a path variant was non-breaking for that reason.

**Do:**
```
type PathError { kind: ErrorKind (open set) }            # inner details private
match kind { known..., _ => (500, "Unhandled rejection: " + rejection) }
```

**Don't:** Return the parser library's error from your API, or let callers exhaustively match your variants.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/extract.md ("Accessing inner errors"); https://github.com/tokio-rs/axum/blob/main/axum/src/extract/path/mod.rs (PathRejection, ErrorKind); https://github.com/tokio-rs/axum/blob/main/axum-core/src/macros.rs (non_exhaustive on rejections); https://github.com/tokio-rs/axum/blob/main/axum-core/src/ext_traits/request.rs (sealed trait); https://github.com/tokio-rs/axum/blob/main/examples/customize-path-rejection/src/main.rs.
