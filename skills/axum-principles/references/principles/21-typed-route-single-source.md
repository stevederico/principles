# Make one type the route, the extractor and the URL builder

**Rule:** Define each route as a type that carries its path template, parses captures into its fields on the way in, and formats itself with percent-encoding on the way out, so links and handlers cannot drift apart.

**Why:** The derive generates the path constant, the extractor (through the path extractor) and a formatter that encodes captures. The router infers the path from the handler's first argument, so no string is repeated at registration. Query parameters append to an existing "?" and never leave a dangling one.

**Do:**
```
type UserMember { id } at "/users/{id}"
router.get(handler(UserMember, ...))
link = UserMember{id: "foo bar"}.to_string()      # "/users/foo%20bar"
```

**Don't:** Build URLs by string concatenation, or register routes with strings that must match a different extractor definition.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-extra/src/routing/typed.rs (TypedPath, "Percent encoding", with_query_params); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/typed_path.rs.
