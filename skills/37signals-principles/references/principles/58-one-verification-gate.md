# Define the verification gate in one script

**Rule:** One CI script runs style, dependency and static security checks, unit tests, browser tests and seed replay, and ends with an explicit sign-off or a "do not merge" message; tests run against the built output in real browsers; conventions live in an agent-facing file.

**Why:** Contributors and agents run one command before pushing, and conventions reduce review noise. Unit tests and browser tests exercise different layers, and built output is what users get.

**Do:**
```
ci: setup ; style ; dependency audit ; static analysis (fail on warning) ; tests ; browser tests ; seeds ; signoff
build first, then run unit tier and browser tier across several engines ; serve fixtures locally to debug
conventions file: reuse fixtures, use path helpers, short assertions
```

**Don't:** Keep CI that exists only on the server, or test source in a single engine.

**Break it when:** The repo has no automated tests yet, or the logic has no DOM.

**Source:** https://github.com/basecamp/once-campfire config/ci.rb, docs/development.md ; https://github.com/basecamp/writebook AGENTS.md ; https://github.com/hotwired/turbo CONTRIBUTING.md, web-test-runner.config.mjs, playwright.config.js.
