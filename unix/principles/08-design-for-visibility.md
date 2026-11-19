# Design programs so they can show that they work

**Rule:** Build inspection and debugging facilities in from the first design, and use input and output forms simple enough that a person can judge whether the output is right for a given input.

**Why:** Debugging dominates the schedule, so early investment in being understandable at a glance (transparency) and in exposing internal state (discoverability) is repaid many times. Simple interfaces also let others write test and monitoring harnesses.

**Do:**
```
program.provides(state_dump, trace_mode)     # designed in, not bolted on
io_format = simple_enough_to_eyeball
```

**Don't:** Treat debug options as an afterthought that gets added after the first mysterious failure.

**Break it when:** Exposing state would leak secrets; then redact or gate it rather than remove the facility.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Transparency) ; http://www.catb.org/esr/writings/taoup/html/ch06s02.html (Designing for Transparency and Discoverability). Book only.
