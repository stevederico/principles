# Parse the API version once and reject unknown ones

**Rule:** Put the API version in the path, convert it once in an extractor into a closed set of versions, and answer 404 for any version you do not serve.

**Why:** The versioning example maps the segment to an enum inside an extractor and returns 404 with a fixed message for anything else, and a test pins both the supported and the unknown case. Handlers then branch on a typed value instead of a string.

**Do:**
```
route("/{version}/foo", handler)
extractor Version: match segment { "v1" -> V1, "v2" -> V2, _ -> reject(404, "unknown version") }
```

**Don't:** Compare version strings inside handlers, or accept any version by default.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/versioning/src/main.rs (Version extractor and tests).
