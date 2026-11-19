# Spend machine time to save programmer time

**Rule:** Choose the implementation language and tools that minimize debugging and maintenance effort, mixing languages through narrow interfaces where each fits best, and drop to low-level code only for measured hot spots.

**Why:** Hardware has become far cheaper than people. Manual resource management consumes a large share of development effort and is a prime source of persistent faults, while most real programs wait on input, output and the network rather than computing. A fast core with scripted orchestration on top is slower but far easier to read, change and extend.

**Do:**
```
core       = fast_language(only proven hot kernel)
orchestration = high_level_language(calls core over a narrow interface)
profile first; move a module down a level only if the profile demands it
```

**Don't:** Default to the lowest-level language by habit, or reject a high-level language on speed grounds without measuring.

**Break it when:** Resources are tightly bounded (embedded, real time), scale makes machine cost dominant, or a small team cannot sustain several languages.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Economy) ; http://www.catb.org/esr/writings/taoup/html/why_not_c.html (Why Not C?) ; http://www.catb.org/esr/writings/taoup/html/ch14s01.html (Unix's Cornucopia of Languages) ; http://www.catb.org/esr/writings/taoup/html/ch14s03.html (Interpreted Languages and Mixed Strategies) ; http://www.catb.org/esr/writings/taoup/html/ch14s04.html (Language Evaluations). Book only.
