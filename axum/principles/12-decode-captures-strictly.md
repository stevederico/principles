# Decode path captures once and fail loudly on bad text

**Rule:** Percent-decode path captures once at the boundary, require valid UTF-8, and return no value rather than lossy text; surface a decode error only when a handler asks for that parameter, and require capture counts to match strictly.

**Why:** Captures are decoded before handlers see them; invalid text gives 400 naming the parameter. The decoder returns "absent" for bad bytes, the first error is stored and never overwritten, so a bad value in a parameter nobody reads does not fail the request. A tuple whose length differs from the capture count is a programmer error (500).

**Do:**
```
decoded = percent_decode(raw); if not valid_utf8(decoded): return None
on match: if decode failed: ctx.param_error = key (keep first)
extractor Path: if target_arity != capture_count: reject(500)
```

**Don't:** Substitute replacement characters and route on the result, or decode again inside each handler.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/extract/path/mod.rs (Path, error kinds); https://github.com/tokio-rs/axum/blob/main/axum/src/extract/path/de.rs (arity checks); https://github.com/tokio-rs/axum/blob/main/axum/src/util.rs (PercentDecodedStr::new); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/url_params.rs (insert_url_params, invalid-UTF-8 handling).
