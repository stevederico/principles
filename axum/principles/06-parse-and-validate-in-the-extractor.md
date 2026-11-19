# Validate in the extractor, not the handler body

**Rule:** Convert raw request data into typed, validated domain values inside an extractor, so handlers only ever receive values that are already correct.

**Why:** The validator example deserializes and validates in one extractor and answers 400 with per-field messages; the versioning example maps a path segment to a closed set; auth extractors produce the verified principal. Validation lives once instead of in every handler.

**Do:**
```
extractor ValidatedForm(T): v = parse_form(request); v.validate(); return v
handler(ValidatedForm(input)): ...    # input is valid here
```

**Don't:** Re-validate the same input at the top of each handler body.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/validator/src/main.rs (ValidatedForm); https://github.com/tokio-rs/axum/blob/main/examples/versioning/src/main.rs (Version); https://github.com/tokio-rs/axum/blob/main/examples/jwt/src/main.rs (Claims extractor).
