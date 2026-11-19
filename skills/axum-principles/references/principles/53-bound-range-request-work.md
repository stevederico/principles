# Parse range requests leniently on unit, strictly on values, and bound the work

**Rule:** For a Range header, ignore it when the unit is not bytes, the header is malformed at the outer level, the file is empty or the method is not GET; return 416 with a total-size content range for invalid or unsatisfiable values; cap how many ranges are honored.

**Why:** The code and tests serve the whole file for a non-bytes unit and for an empty file, ignore Range on HEAD, reject plus signs, spaces and overflowing digits, and honor at most eight ranges while examining at most twice that many elements, so a long list cannot amplify work. A single range gets 206 with a content range; several ranges become a multipart body without a top-level content range. Totals use checked arithmetic.

**Do:**
```
spec = parse_all(range_value)          # non-digits and overflow rejected
ranges = normalize(spec, size)[:MAX_RANGES]
if empty: 416 elif one: 206 + content_range else: 206 multipart/byteranges
```

**Don't:** Accept unbounded range lists or numerics with signs and whitespace.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/file_stream/range.rs (MAX_RANGES); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/file_stream.rs (416, 206 handling, tests); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/multipart.rs (checked size sums).
