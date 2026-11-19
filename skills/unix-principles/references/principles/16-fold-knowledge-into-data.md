# Fold knowledge into data so the logic stays dumb

**Rule:** When complexity can live in a data structure or table rather than in control flow, put it there, and keep looking for chances to move logic into data as a design evolves.

**Why:** People verify and reason about data far more easily than about branching code, and a good choice of data structure often makes the algorithm obvious. Data kept apart from code can also be edited by contributors who never touch the program, and declarative data lets tools check mistakes before runtime.

**Do:**
```
table = { key: action_or_value, ... }
run(table[key])                      # replaces a long conditional chain
validate(table) at load or build time
```

**Don't:** Encode a conversion or dispatch table as nested conditionals.

**Break it when:** The rules depend on runtime state in ways a static table cannot express without growing into an awkward language of its own.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Representation) ; http://www.catb.org/esr/writings/taoup/html/ch09s01.html (Data-Driven Programming) ; http://www.catb.org/esr/writings/taoup/html/generationchapter.html (Chapter 9 introduction). Book only.
