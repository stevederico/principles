# All tests pass before release

**Rule:** Release code only when the entire suite passes at 100 percent; when it fails, debug it or back it out at your own workstation.

**Why:** The suite guards the whole repository, so everything keeps working and no individual owner is needed. At VCAPS a manager's deadline worry won a one-time exemption; the work was based on obsolete versions, 32 developer hours went into tracking it down, and later adapting the tests took one hour.

**Do:**
```
before release: run the combined latest suite
if all pass: commit
else: debug it, or back it out, at your own workstation
```

**Don't:** Granting a deadline exemption from testing, as the VCAPS manager did.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/unittests.html, http://www.extremeprogramming.org/rules/dedicated.html, http://www.extremeprogramming.org/rules/collective.html, http://www.extremeprogramming.org/stories/unittests.html
