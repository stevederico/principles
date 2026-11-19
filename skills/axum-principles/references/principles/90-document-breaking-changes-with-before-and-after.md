# Show old code, new code and the reason for each break

**Rule:** For each breaking change, show the old code, the new code and the reason or recommendation in the changelog, and when a default behavior changes, state the version, the new default and the explicit override.

**Why:** The 0.6 notes group changes by area and show before and after for state, fallbacks, the extractor interfaces, trailing slashes and wildcards, naming each replacement. The failed-response marker docs name the version it changed in and the force wrapper that restores the old behaviour.

**Do:**
```
"Becomes this in 0.6: ..."  +  "We recommend migrating from X to Y because it is more type safe"
doc: "since vX, A now does B; use C for the old behavior"
```

**Don't:** List "removed Foo" with no replacement.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.6.0 sections); https://github.com/tokio-rs/axum/blob/main/axum-core/src/response/mod.rs (IntoResponseFailed docs).
