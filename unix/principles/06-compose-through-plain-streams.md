# Make programs composable through plain streams

**Rule:** Have each program read an ordinary stream and write an ordinary stream, independent of where either end comes from, so it can be wired to programs that do not exist yet.

**Why:** If programs cannot talk to each other you end up writing monoliths. A narrow stream also enforces encapsulation, whereas richer sharing makes each side learn the other's internals; when programs cooperate through shared complex structures, the integration work is redone for every newcomer and grows with the square of the number of programs.

**Do:**
```
tool = filter(read(input_stream) -> write(output_stream))
pipeline = stage_a | stage_b | stage_c      # swap any stage, others unchanged
```

**Don't:** Hard-wire a program to one source, one sink or one specific peer, or let suite members import each other's internal types.

**Break it when:** The data is inherently non-linear or binary, so a stream is unnatural; then expose the primitives as a documented library instead.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Composition) ; http://www.catb.org/esr/writings/taoup/html/ch01s08.html (Applying the Unix Philosophy) ; http://www.catb.org/esr/writings/taoup/html/ch03s01.html (Cooperating Processes). Book only.
