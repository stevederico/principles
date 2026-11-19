# Give every request an id and a span with the route template

**Rule:** Wrap the app in a trace layer whose span carries a request id (assigned if absent and echoed in the response), the method and the matched route template, and log inside handlers within that span.

**Why:** Three examples build this. The span carries the template, not the filled-in path, so one route groups together; the request-id example sets, logs and propagates the id; and the error example puts the trace layer outermost so inner events inherit the span.

**Do:**
```
layers = [set_request_id(uuid), trace(span = {id, method, matched_path}), propagate_request_id]
```

**Don't:** Log request lines without a correlating id.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/request-id/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/tracing-aka-logging/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/error-handling/src/main.rs.
