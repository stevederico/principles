# Check the declared content type and parse strictly

**Rule:** Before reading a body, require the declared content type to match what the parser accepts (415 otherwise), match structured suffixes but not look-alikes, and after parsing reject anything non-blank left over.

**Why:** The JSON extractor accepts the application type with a json subtype or json suffix and nothing else; matching is by prefix so parameters such as charset are tolerated. Two changelog entries fixed parsers that accepted a valid value followed by garbage, and a test pins that trailing whitespace is fine but trailing text is a syntax error.

**Do:**
```
mime = parse(content_type_header)
if not (mime.type == "application" and (mime.subtype == "json" or mime.suffix == "json")): reject(415)
value = parse(bytes); if leftover(bytes) has non_blank: reject(400)
```

**Don't:** Parse whatever "looks like" JSON, use a substring match on the header, or stop at the first complete value.

**Break it when:** Deliberately concatenated formats (newline-delimited records) use a dedicated streaming type instead.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/json.rs (content-type check, trailing bytes); https://github.com/tokio-rs/axum/blob/main/axum/src/extract/mod.rs (has_content_type); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/json_deserializer.rs (trailing garbage tests); https://github.com/tokio-rs/axum/blob/main/examples/parse-body-based-on-content-type/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md.
