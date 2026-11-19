# User stories in customer words

**Rule:** Have the customer write each requirement as a card of about three sentences in business language, saying what the system must do and never how.

**Why:** Stories replace a large requirements document, feed the time estimates, and drive acceptance tests. They carry only enough detail for a low-risk estimate, so developers get the full detail from the customer in person when they build the story. Keeping out technology, table layout, algorithms and screen layout keeps the focus on user benefit.

**Do:**
```
customer writes card: "when X happens the system does Y for me"   # ~3 sentences
card holds no technology, schema, algorithm or screen layout
at build time: developer asks the customer for detail, in person
per story: write one or more automated acceptance tests
```

**Don't:** Writing stories as a detailed specification, as interface layouts, or as database and algorithm choices.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/userstories.html, http://www.extremeprogramming.org/rules/customer.html, http://www.extremeprogramming.org/introduction.html, http://www.extremeprogramming.org/example/coffeestories.html
