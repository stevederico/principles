# Break hard problems into testable pieces

**Rule:** When tests and code balloon on a hard problem, solve a smaller piece first and rely on its passing test when you build the next piece.

**Why:** Kent Beck's story: a half day on payment booking with many special cases got nowhere because each passing test revealed three more. Testing just whether a payment can be booked took 15 minutes, and booking it took 5, giving a cleaner design with two simple objects. Look for pieces you can trust; if you cannot find them yet, keep the tests for the imperfect design until insight lets you retrofit it.

**Do:**
```
ask: what pieces, if each is trusted, make the whole trustworthy?
test and code piece 1 (e.g. can this payment be booked at all?)
assume piece 1 passes; test and code piece 2 on top of it
```

**Don't:** Writing tests for every special case at once.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/stories/testfirst.html, http://www.extremeprogramming.org/rules/simple.html
