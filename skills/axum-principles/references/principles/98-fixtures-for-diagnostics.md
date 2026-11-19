# Test diagnostics with must-fail and must-compile fixtures

**Rule:** Test code generators and build-time diagnostics with small fixture programs split into "must fail with this message" and "must compile", one rule per file, with the exact error stored as a snapshot and run on a pinned toolchain.

**Why:** The macro crate has fail and pass directories per macro, run through a harness that is restricted to the nightly toolchain so compiler wording drift does not break stable CI. Pass fixtures carry regression traps, such as a case where an optional field must use the optional interface rather than turning failures into none.

**Do:**
```
fixtures/fail/<rule>.src + <rule>.expected
fixtures/pass/<case>.src            # run on a pinned toolchain
```

**Don't:** Snapshot compiler wording on every compiler version, or test generators only with happy-path examples.

**Break it when:** A language with no build-time diagnostics has no use for it.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-macros/src/lib.rs (run_ui_tests, nightly only); https://github.com/tokio-rs/axum/tree/main/axum-macros/tests/ (fail and pass directories).
