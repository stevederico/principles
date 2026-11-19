# Automate safe changes, flag the rest, verify the result

**Rule:** A migration tool transforms the safe cases and, where the fix is ambiguous, inserts a marker (and an explicitly unsafe temporary cast) that fails the build until a human resolves it; it supports dry run and print, reports zero matched files visibly, accepts defaults when no terminal is attached, and upgrades follow a named policy with a guarded target and a verification step.

**Why:** Silent guesses hide breakage. A wrong path reports zero changes instead of an error, prompts hang CI and agents, and major jumps need every intermediate guide. Checklists repeat that image restrictions, cache semantics and fallbacks show up at runtime, not in the build.

**Do:**
```
codemod --dry-run --print; check files_matched > 0
upgrade: policy = security | latest; refuse if no upgrade needed; separate worktree
after: run checks and exercise affected runtime paths
```

**Don't:** Treat markers or unsafe casts as finished work, treat zero errors as success, or jump majors without every intermediate guide.

**Break it when:** A trivial patch bump with a test suite in CI.

**Source:** https://nextjs.org/docs/app/guides/upgrading/codemods, https://nextjs.org/docs/app/guides/upgrading/agent-upgrade, https://nextjs.org/docs/app/guides/upgrading/version-16; code: packages/next/src/cli/next-upgrade.ts
