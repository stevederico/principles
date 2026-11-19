# Allow explicit origins and methods for cross-origin access

**Rule:** Configure cross-origin access with an explicit origin list and method list rather than a wildcard, and remember that posting JSON requires allowing the content-type header.

**Why:** The CORS example allows one origin and GET only, and its comment warns that a JSON post needs the content-type header allowed.

**Do:**
```
cors = Cors().allow_origin("http://localhost:3000").allow_methods([GET]).allow_headers([CONTENT_TYPE])
```

**Don't:** Allow every origin on authenticated endpoints.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/cors/src/main.rs.
