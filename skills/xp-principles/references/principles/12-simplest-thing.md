# The simplest thing that could work

**Rule:** Always do the simplest thing that could possibly work next, and replace anything complex with something simple as soon as you see it.

**Why:** A simple design takes less time to finish than a complex one, and replacing complex code early is cheaper than after more time is sunk into it. Simple designs often beat complex ones that are optimized in theory. Simplicity is subjective, so the team decides what it means in context; a technology that simplifies one application can wreck another. Count net complexity: the coffee-maker team accepted threads because they removed about two levels of interface complexity.

**Do:**
```
before adding code: what is the simplest thing that works for today's story?
when you meet something complex: replace it with something simple now
judge by net complexity of the whole design, not one local piece
```

**Don't:** Trying to measure simplicity with a number, or treating one person's taste as the standard.

**Break it when:** The site gives none, and warns that keeping a design simple is hard work.

**Source:** http://www.extremeprogramming.org/rules/simple.html, http://www.extremeprogramming.org/lessons.html, http://www.extremeprogramming.org/example/crcsim.html
