# Treat the specification as primary and revise it from field use

**Rule:** Write the specification or documentation before or alongside the program, let it define correct behavior so that a mismatch means the implementation is wrong, derive the tests from its statements, and revise it through experience.

**Why:** Specifications let programs cooperate and survive changes of code, are less buggy than code, and settle arguments about bug versus feature. Exhaustive up-front specifications fail; prototyping with repeated test cycles works better. A suite built from a well-written spec found a few spec inconsistencies and gave cross-vendor interoperation.

**Do:**
```
draft spec -> prototype -> test -> revise spec
for each normative statement: write_test(statement)
mismatch(implementation, spec) -> fix_implementation or deliberately fix_spec
```

**Don't:** Let the most popular implementation define the standard, or freeze a specification before any implementation exists.

**Break it when:** The spec is shown to contain the defect (fix it and say so), or a stable interface is already widely deployed.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch17s04.html (Specifications as DNA, Code as RNA). Book only.
