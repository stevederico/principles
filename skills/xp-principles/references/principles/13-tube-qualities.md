# Judge simplicity with TUBE

**Rule:** Judge a design against four qualities the team agrees on: Testable, Understandable, Browsable and Explainable.

**Why:** Testable means automated unit and acceptance tests can check it, which pushes toward small units with low coupling. Browsable means you can find things when you need them, helped by good names and correct use of polymorphism, delegation and inheritance. Understandable is subjective, since people who know a system find it clear while newcomers are baffled; so Explainable adds that it is easy to show a new person how it all works.

**Do:**
```
for each design decision ask:
    can I unit-test it?          (T)
    will the team follow it?     (U)
    can I find the code quickly? (B)
    can I explain it to a new hire in minutes? (E)
```

**Don't:** Declaring a design simple because the long-time team understands it.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/simple.html
