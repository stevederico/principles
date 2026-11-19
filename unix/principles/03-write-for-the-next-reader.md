# Write the code for the next reader, not for the machine

**Rule:** Treat the person who will maintain the code, often yourself later, as its main audience, and decline small speedups that cost a lot of readability.

**Why:** Maintenance is the dominant cost. Obscure code hides defects and is re-deciphered on every visit, while graceful code is understood at a glance. A comment written the moment you notice you had to rederive something saves every later reader the same effort.

**Do:**
```
if faster_version.speedup is small and faster_version.is_much_harder_to_read:
    keep(simple_version)
if you_had_to_rederive_the_logic:
    add_comment(why_it_works)
```

**Don't:** Give up a lot of clarity for a marginal gain, or leave subtle logic unexplained.

**Break it when:** Measurement shows this exact code dominates cost and no clearer approach reaches the target; then isolate the ugly part and document it.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Clarity). Book only.
