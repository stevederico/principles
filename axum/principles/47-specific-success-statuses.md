# Return the specific success status

**Rule:** Return 201 with the created item on create, an explicit no-content status on delete, and 404 when the target does not exist; name 204 explicitly rather than relying on an empty value.

**Why:** The README and todos examples use created and no-content explicitly. The empty value returns 200 for historical reasons, so the docs point to the dedicated no-content type for 204.

**Do:**
```
create -> (201, json(item))
delete -> removed ? NoContent : 404
```

**Don't:** Return 200 with an empty body for every outcome.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/readme/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/todos/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/response/mod.rs (NoContent docs and test).
