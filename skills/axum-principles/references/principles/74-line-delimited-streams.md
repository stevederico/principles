# Handle line-delimited data as a stream with per-item errors

**Rule:** Read newline-delimited JSON as a stream where each line is decoded lazily and a bad line surfaces as an error item mid-stream, and write it as one value plus a newline per item.

**Why:** The extractor's rejection type is "never"; items are results with a downcastable source, and the body limit applies to the stream. The response side notes there is no consensus on a media type, so none is set.

**Do:**
```
lines = split(body_stream, "\n"); for line in lines: yield parse(line) or Error(source = parse_error)
response: for item in stream: write(json(item) + "\n")
```

**Don't:** Buffer the whole body for line-oriented data.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-extra/src/json_lines.rs (JsonLines extractor and response, tests).
