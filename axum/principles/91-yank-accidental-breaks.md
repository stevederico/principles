# Pull a release that breaks compatibility by accident

**Rule:** If a release turns out to contain an unintended breaking change or does not build, yank it and re-release rather than leaving it resolvable.

**Why:** The changelogs record yanked releases for accidental breaks in the core, in two axum releases and in a release candidate that did not compile in release mode, each with a line explaining the breakage.

**Do:**
```
mark release yanked; changelog line pointing to the issue that explains the breakage
```

**Don't:** Patch forward and leave the bad version resolvable.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-core/CHANGELOG.md (0.5.1 yank); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.8.2, 0.5.14 and release candidate yanks).
