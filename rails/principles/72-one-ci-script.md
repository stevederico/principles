# One script runs every check

**Rule:** Define the full pipeline (setup, style, dependency and code security audits, tests, seeds) as data in one version-controlled file with one command, and have CI call that same command.

**Why:** Checks stay consistent locally and in CI, and a passing local run can sign off a change. Modern machines run mid-sized suites quickly, so a hosted pipeline is optional for small and mid-size apps.

**Do:**
```
ci file:
  step "Setup": bin/setup
  group "Checks" parallel: style, dependency_audit, static_security_scan
  group "Tests": unit, seeds
  on success: mark_commit_ok     on failure: print "Do not merge"
CI job: run ci        # not a second command list in the vendor's config
```

**Don't:** Keep the pipeline only in a hosted vendor's config where nobody can run it locally.

**Break it when:** A step needs remote-only hardware or services, or a team needs independent verification of builds; keep the shared script for the common part.

**Source:** Guides: https://guides.rubyonrails.org/getting_started.html (Continuous Integration with bin/ci, CI Steps DSL); https://guides.rubyonrails.org/8_1_release_notes.html (Local CI). Code: railties/lib/rails/generators/rails/app/templates/config/ci.rb.tt:1-30.
