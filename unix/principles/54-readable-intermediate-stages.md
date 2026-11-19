# Let multi-stage tools expose each stage's readable output

**Rule:** Build multi-stage processors so stages pass readable text and the driver can reveal any intermediate result.

**Why:** Visible intermediates let you inspect every step, and regression tests can compare intermediate output with an ordinary text comparison instead of specialist dump analyzers that need their own upkeep. Only stages that must handle binary are excused.

**Do:**
```
driver runs stage1 | stage2 | stage3
flag --dump-after=stageN prints that stage's output
test: compare(actual_intermediate, golden_intermediate)
```

**Don't:** Pass opaque in-memory structures between stages with no way to look at them.

**Break it when:** A stage's data is inherently binary or too large to print.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch06s01.html (Case Study: GCC) ; http://www.catb.org/esr/writings/taoup/html/ch08s02.html (Case Study: The Documenter's Workbench Tools). Book only.
