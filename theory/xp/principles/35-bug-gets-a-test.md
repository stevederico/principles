# A bug gets a test first

**Rule:** When you find a bug, write a failing acceptance test for it first, then failing unit tests, then fix until both go green.

**Why:** The acceptance test lets the customer define the problem concisely and tells the programmers when it is fixed. Unit tests show the defect from the source-code side and give immediate feedback during the repair. The tests also guard against the bug returning.

**Do:**
```
bug reported:
    write acceptance test that fails (customer-visible)
    write unit tests that fail (code-level)
    fix until unit tests pass at 100%
    rerun the acceptance test to validate
```

**Don't:** Debugging without first capturing the bug as a failing test.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/bugs.html
