# Code the unit test first

**Rule:** Write one small failing test, watch it fail, write the simplest code that passes it, then write the next test, until nothing is left to test.

**Why:** Test plus code takes about as long as code alone, and the tests need not be written later. A test nails the requirement as executable code, shows when you are done, stops scope creep, and shapes the design to be testable. Other developers learn the new code by reading its tests, and undefined inputs are visibly missing. Running the test first guards the test: an unexpected pass means the code already works or the test checks the wrong thing.

**Do:**
```
loop:
    write a test for one small aspect
    stub the method; run -> must FAIL
    write the simplest code that passes; run -> green
    refactor if the code looks messy; run -> still green
until nothing left to test
```

**Don't:** Adding code beyond what the current test needs.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/testfirst.html, http://www.extremeprogramming.org/rules/unittests.html, http://www.extremeprogramming.org/example/piacode.html, http://www.extremeprogramming.org/example/simcode8.html
