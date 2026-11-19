# Turn a validating extractor into a gate when the handler needs no value

**Rule:** When a check produces nothing the handler needs (auth, validation), run the same extractor as a gate in front of the route that returns the extractor's rejection and never calls the inner service on failure.

**Why:** The doc says the extracted value is discarded and the inner service is skipped on failure, which removes the repeated parameter from every handler signature.

**Do:**
```
gate(validator):
    result = validator(request.head, state)
    if result.failed: return result.rejection.to_response()
    return inner(request)
router.route_layer(gate(require_auth))
```

**Don't:** Copy the same auth parameter into every handler, or let the handler run and check later.

**Break it when:** A handler that needs the value uses a normal parameter, and a gate whose extractor consumes the body leaves the body empty for later steps (from_extractor docs).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/middleware/from_extractor.rs (docs, call impl).
