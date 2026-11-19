# Refactor mercilessly

**Rule:** Keep removing redundancy, unused features and obsolete design throughout the project, in small steps with the tests run before, between and after.

**Why:** Holding on to unwieldy code because it still works is not cost effective; refactoring through the whole life cycle saves time and raises quality. Simple designs need knowledge of the problem, which arrives late, so build only for current features while knowledge grows, then refactor toward the design you now see and let go of the one you pictured earlier. In the coffee-maker code each refactor starts at 100 percent, makes one small rename or extraction, and reruns the tests.

**Do:**
```
run all tests: must be 100% green
change one small thing (rename, extract method, extract class)
run all tests again; if red, undo
repeat until the code states each intention once
wait for two complete examples before merging near-duplicates
```

**Don't:** Clinging to the original design or refactoring without a green suite behind you.

**Break it when:** The site gives none; in its coffee-maker example, code that was already clean was left alone.

**Source:** http://www.extremeprogramming.org/rules/refactor.html, http://www.extremeprogramming.org/rules/simple.html, http://www.extremeprogramming.org/example/piacode3.html, http://www.extremeprogramming.org/example/simcode5.html, http://www.extremeprogramming.org/example/simcode7.html, http://www.extremeprogramming.org/example/simcode9.html
