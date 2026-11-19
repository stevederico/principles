# Land a change that is better than the status quo

**Rule:** Accept a change when it improves on the status quo, request rather than demand changes, label non-essential nits as non-blocking, discuss large changes in an issue first, and avoid rewriting history on an open pull request.

**Why:** The guide states that incremental improvement is enough to land, orders review focus (fit, improvement, bugs, commit message), keeps reviewers' context by not rebasing an open PR, squashes at merge with links, and asks before taking over a stalled PR with credit.

**Do:**
```
review: "Nit: rename x to y. Not blocking."
large change: open an issue first, then the PR
```

**Don't:** Block on style micro-preferences or rewrite history under reviewers.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/CONTRIBUTING.md ("Review a bit at a time", "Pull Requests", "Commit Squashing"). Docs only.
