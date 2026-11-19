# Stream large bodies; buffer only when the size is bounded

**Rule:** Pass large request and response bodies through streams (to disk, from upstream, field by field) instead of loading them whole, and offer both whole-value and chunked reading for uploads.

**Why:** The upload example copies each chunk to a file through a buffered writer; the proxy examples forward the upstream body as a stream through a shared pooled client; files are served as chunked streams with a length only when known; multipart is read one field at a time, with only one live field allowed because a second would corrupt the underlying stream. Streamed multipart still honors the default body limit and maps size errors to 413.

**Do:**
```
extractor = stream_to_reader(request.body_stream())
copy(extractor, buffered_file_writer)
for field in fields: while chunk = field.next_chunk(): write(chunk)      # one live field
```

**Don't:** Collect an upload into memory to write it out, or hold earlier multipart fields while reading the next.

**Break it when:** When you need the whole body (signature check, replay), apply a size limit first (consume-body example).

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/stream-to-file/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/reqwest-response/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/reverse-proxy/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/multipart.rs ("Field Exclusivity"); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/file_stream.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/extract/multipart.rs (default limit, 413 mapping).
