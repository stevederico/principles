# Deprecate with a pointer, remove later, keep an opt-in helper

**Rule:** Deprecate with a pointer to the replacement and a note on exactly what differs, remove in a later breaking release, keep an opt-in helper for people who relied on the removed behaviour, and make retired syntax fail loudly rather than change meaning.

**Why:** One middleware adapter was deprecated then replaced; host and scheme extractors were deprecated then removed; the slash redirect moved to an extras helper; the old colon and star capture syntax panics with a hint instead of silently meaning something else. The extras form extractor stays deprecated with an explanation of how it differs from the main crate.

**Do:**
```
v1: deprecated(use = new_thing, note = what differs)
v2: removed; "use the extras helper for the old behaviour"
```

**Don't:** Silently change the behavior of an old type or delete it in a minor release.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.7 and 0.8 removals, path syntax change); https://github.com/tokio-rs/axum/blob/main/axum-extra/CHANGELOG.md; https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/form.rs (deprecation docs); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/routing/mod.rs (validated path macro).
