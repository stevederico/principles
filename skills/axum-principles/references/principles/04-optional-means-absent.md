# Optional input is empty only when absent

**Rule:** An optional extractor returns "none" only when the input is truly absent; if it is present but malformed, it still rejects the request.

**Why:** A blanket "ignore every error" optional would silently swallow bad bodies, bad headers and bad queries. The source moved optionality into a per-extractor contract so each type decides what absent means, and offers a separate "result of extractor" form to catch every failure explicitly.

**Do:**
```
if header absent: return None
if header present and parse fails: reject(400)
```

**Don't:** Map every extraction failure to none; clients then see silent misbehaviour and validation is skipped.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/extract.md ("Optional extractors"); https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/option.rs (OptionalFromRequestParts); https://github.com/tokio-rs/axum/blob/main/axum/src/json.rs (Option form); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/query.rs (optional query keeps parse errors); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/typed_header.rs (optional header).
