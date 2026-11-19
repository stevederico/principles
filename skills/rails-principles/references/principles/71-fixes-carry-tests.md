# Fixes carry a failing test, optimizations carry a benchmark

**Rule:** Ship every fix with a test that fails without it. Ship every optimization with its benchmark script and results from several realistic scenarios. A layer that claims several backends runs its tests on all of them, and new warnings fail CI.

**Why:** The test proves the bug existed and stays fixed. A benchmark of one case can regress others, and a runtime improvement may make the change unnecessary. A single-backend patch cannot back a portability claim.

**Do:**
```
commit message: problem, fix, benchmark script, before/after for 3+ scenarios
CI matrix: sqlite, postgres, mysql   # same suite; a backend-specific change gets tests under that backend
new warning -> CI fails
squash to one commit, easy to revert and backport
```

**Don't:** Optimize one hot case and ship without measuring the rest, or claim portability from a suite that runs on one engine.

**Break it when:** Documentation or comment-only changes; a backend declared unsupported or experimental.

**Source:** Guides: https://guides.rubyonrails.org/contributing_to_ruby_on_rails.html (Write Your Code, Benchmark Your Code, Warnings, Commit Your Changes); https://guides.rubyonrails.org/development_dependencies_install.html (Install Additional Tools and Services note). Code: activerecord/Rakefile:21-34.
