# Run every automated check you can before a release

**Rule:** Before release, use each tool with a reasonable chance of catching what humans overlook: strict warnings on several toolchains and word sizes, static and runtime checkers, spell-checks of documentation and messages, a single enforced code style, and strong checksums for artifacts.

**Why:** Every class of defect a tool catches is one users never meet, and different compilers and word sizes expose different problems. Sloppy warnings and typos lead users to infer sloppy engineering. Maintaining several styles costs more than any style could save, and a strong hash lets users detect tampering as well as corruption.

**Do:**
```
build with strict warnings on each toolchain; run static and runtime checkers
spell_check(docs, messages); check style automatically at commit
publish(artifact, strong_hash, the command that produced it)
```

**Don't:** Ship with known warnings or typos, or rely on legacy non-cryptographic sums against tampering.

**Break it when:** A warning is a verified false positive; suppress it narrowly and say why. Vendored third-party code keeps its own style.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Sanity-check your code before release) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Provide checksums) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Recommended C/C++ Portability Practices). Book only.
