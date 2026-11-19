# Generate repetitive code from a simpler specification

**Rule:** When code is detailed or repetitive, write a generator whose input is simpler than its output, and treat the generated output as read-only: fix the generator or the specification, never the output.

**Why:** People err on details, and a shorter specification means fewer lines that can harbor defects. A hand patch to generated text vanishes at the next regeneration and drifts from its source, which becomes an endless time sink.

**Do:**
```
spec -> generator -> output            # output regenerated on every build
bug in output? change generator or spec; rebuild
```

**Don't:** Edit and commit the generated file, or build a generator whose input is as complex as what it emits.

**Break it when:** The generator is one-off scaffolding explicitly meant to be taken over by hand.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Generation) ; http://www.catb.org/esr/writings/taoup/html/generationchapter.html (Chapter 9 introduction) ; http://www.catb.org/esr/writings/taoup/html/ch09s01.html (Data-Driven Programming) ; http://www.catb.org/esr/writings/taoup/html/ch15s03.html (Special-Purpose Code Generators). Book only.
