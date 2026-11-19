# Ship security fixes as defaults, on every maintained line

**Rule:** When a missing limit or unsafe default is found, change the default (with a documented escape hatch) and publish the same fix, with the same wording, on every supported version.

**Why:** The body-size default appears identically in the 0.5 release, the 0.6 release candidate and in two core releases, each describing the same disable switch.

**Do:**
```
release 0.5.16, 0.6.0-rc.2, core 0.2.8, core 0.3.0-rc.2: "default 2 MB; disable explicitly per route"
```

**Don't:** Fix only the newest branch.

**Break it when:** Only one line is supported.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.5.16 and 0.6.0-rc.2 body limit entries); https://github.com/tokio-rs/axum/blob/main/axum-core/CHANGELOG.md (0.2.8, 0.3.0-rc.2).
