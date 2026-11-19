# Name the failing field and pay for it only on failure

**Rule:** Report which field path failed validation and what type was expected, but run the slower path-tracking parser only after the fast parse has already failed.

**Why:** JSON first tries the plain deserializer and, on error, re-runs with a path-tracking one to build messages such as "item 0: missing field". Tracking allocates for every field, so successful requests never pay. Query, form and path errors also carry key or index and the expected type.

**Do:**
```
try fast_parse(bytes) -> ok: return value
err = path_tracking_parse(bytes)      # slow, error path only
return reject(422, err.path + ": " + err.message)
```

**Don't:** Return "invalid body" with no location, or always parse with the diagnostic parser.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/json.rs (from_bytes, path-tracking re-parse); https://github.com/tokio-rs/axum/blob/main/axum/src/util.rs (path-tracking comment); https://github.com/tokio-rs/axum/blob/main/axum/src/extract/query.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/extract/path/de.rs (error kinds with key and value).
