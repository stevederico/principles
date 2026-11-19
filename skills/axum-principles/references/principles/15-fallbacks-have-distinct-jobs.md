# Keep "no route", "wrong method" and "handler said 404" separate

**Rule:** Treat three cases differently: no path matched, path matched but method unsupported, and a handler that itself returned 404. Give nested routers the outer fallback unless they define their own, and keep the real status when serving a shell page.

**Why:** The router fallback runs only when nothing matches; a handler's own 404 never triggers it. The wrong-method case has its own hook that replaces only default behaviour, never a path's own fallback. A nested router inherits the outer fallback; defining one replaces it inside its prefix; two custom fallbacks in one merge are an error. A single-page-app index served for unknown paths is still wrapped to return 404.

**Do:**
```
router.fallback(not_found)                     # nothing matched
router.method_not_allowed_fallback(h405)       # path matched, method not
spa_index = with_status(serve_file("index.html"), 404)
```

**Don't:** Treat all 404 and 405 responses as one case, or return 200 for unknown paths because a shell page renders.

**Break it when:** Hosting that treats a 404 shell as an error needs a 200 for the client-side router; the static-file example documents the choice.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/fallback.md; https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/method_not_allowed_fallback.md; https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/nest.md ("Fallbacks"); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/fallback.rs; https://github.com/tokio-rs/axum/blob/main/examples/static-file-server/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/mod.rs (Fallback::merge).
