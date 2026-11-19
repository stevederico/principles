# Build a small language when primitives are stable and combinations vary

**Rule:** Create a domain notation when the domain's primitives are simple and stable but the combinations users want keep changing, keep it as small as the domain allows, and make it learnable from one example, with the common interactive use feeling familiar.

**Why:** A good notation lifts the problem to a higher level and replaces hundreds of lines of fussy code; the test is whether a newcomer can modify a sample without the manual. Restricting a language to save machine resources is a bad reason, since space in heads is scarcer; a notation should be either very dense or fully general, not narrow and wordy.

**Do:**
```
notation: one construct per domain concept; nesting for containment; properties as name-value
review: show a sample to a newcomer; can they predict an edit's effect?
interactive use: one line in -> one result out
```

**Don't:** Invent a notation whose relations require chasing name references, or build a general-purpose language for a narrow task.

**Break it when:** Only a handful of options exist, so a flat config file is enough; or the domain has many primitives and intricate structure that need real power.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch08s03.html (Designing Minilanguages) ; http://www.catb.org/esr/writings/taoup/html/ch08s02.html (Case Study: awk) ; http://www.catb.org/esr/writings/taoup/html/ch08s02.html (Case Study: bc and dc). Book only.
