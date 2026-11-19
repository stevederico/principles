# Fuzz parsers that face the network

**Rule:** For code that parses attacker-controlled paths, add a randomized test whose only assertion is that it completes.

**Why:** The prefix-stripping module generates random URIs and prefixes with and without captures and trailing slashes, next to a 30-case table of fixed examples.

**Do:**
```
property: for random (uri, prefix): strip_prefix(uri, prefix) completes
```

**Don't:** Rely only on hand-picked examples for parsers on the network edge.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/routing/strip_prefix.rs (does_not_panic property test).
