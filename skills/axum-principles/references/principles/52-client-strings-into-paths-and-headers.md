# Never put client-controlled strings into paths or headers unchecked

**Rule:** Validate or escape every client-supplied string that reaches the filesystem or a protocol header: filenames must be one plain path component, quoted header parameters must have backslash and quote escaped, and line breaks are rejected.

**Why:** The upload example blocks traversal by requiring exactly one normal path component. The extras crate fixed parameter injection in download filenames and multipart field names, and tests show an injected extra parameter stays inside the quoted value; the multipart writers require boundaries and header values without line breaks. Invalid optional metadata is logged and dropped rather than failing the request.

**Do:**
```
valid(name) = path_components(name).count == 1 and first is Normal
header = 'attachment; filename="' + replace(replace(name, "\\", "\\\\"), "\"", "\\\"") + '"'
```

**Don't:** Join an uploaded filename onto a directory and open it, or interpolate user text into headers.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/stream-to-file/src/main.rs (path_is_valid); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/content_disposition.rs; https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/attachment.rs; https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/multiple.rs; https://github.com/tokio-rs/axum/blob/main/axum-extra/CHANGELOG.md (header-parameter fixes).
