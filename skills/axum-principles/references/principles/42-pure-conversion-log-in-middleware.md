# Keep error conversion pure and log from one layer

**Rule:** Do not log inside the error-to-response conversion; attach the error to the response as metadata and let one logging layer report it, and do not log client-input errors as errors.

**Why:** The example comment says logging in the conversion would add a side effect to it; sharing the error inside response attachments lets it ride along whatever its inner types support, and a single layer logs server faults.

**Do:**
```
response = build_response(status, body)
if server_fault: response.meta.insert(shared(error))
logging_layer: r = next(req); if r.meta has error: log.error(error); return r
```

**Don't:** Log in every handler's error branch.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/error-handling/src/main.rs (into_response comments, logging middleware).
