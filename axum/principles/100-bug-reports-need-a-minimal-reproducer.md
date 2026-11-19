# Ask for the behavior and a minimal failing test

**Rule:** Ask for a description of the behavior plus a minimal test case before triaging a bug, and ask help-seekers to contribute documentation back.

**Why:** The guide says these two items matter most and that an unreproducible issue is hard to fix.

**Do:**
```
report = { observed behavior, minimal failing test }
```

**Don't:** File "it does not work" with a whole application attached.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/CONTRIBUTING.md ("Submitting a Bug Report", "Asking for General Help"). Docs only.
