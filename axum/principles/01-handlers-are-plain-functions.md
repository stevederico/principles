# A handler is a plain function of declared inputs

**Rule:** Write a request handler as an ordinary function whose parameters name the data it needs from the request and whose return value is anything the framework can turn into a response.

**Why:** The docs define a handler as an async function taking any number of extractors and returning a response-convertible value, so parsing and serialization stay out of application logic.

**Do:**
```
handler create_user(body: JsonBody(NewUser), db: State(Db)) -> (Status, JsonBody(User)):
    user = db.insert(body.value)
    return (201, JsonBody(user))
```

**Don't:** Pass one raw request object to every handler and hand-parse path, query, headers and body inside it.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/handlers_intro.md (whole page); https://github.com/tokio-rs/axum/blob/main/axum/src/handler/mod.rs (per-arity Handler impl).
