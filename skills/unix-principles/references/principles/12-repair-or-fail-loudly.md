# Repair what you can; otherwise fail early, loudly and near the cause

**Rule:** Cope gracefully with bad input and your own recoverable faults, but when repair is impossible or uncertain, stop at once with a diagnosable error, and make errors impossible for callers to ignore silently.

**Why:** The worst defects come from a failed repair that quietly corrupts data and surfaces much later. Signalling failure only through a return value that hurried callers skip lets execution continue into damage far from the cause.

**Do:**
```
result = attempt(operation)
if result.failed:
    if repair_is_certain(result): apply(repair); log(repair)
    else: raise Error(context)          # or return a type the caller must handle
```

**Don't:** Swallow an exception, or return a sentinel and trust every caller to test it.

**Break it when:** A degraded answer is explicitly acceptable and clearly marked as degraded for the consumer; or a hot path or foreign boundary lacks exceptions, so wrap it in a checked layer at the border.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Repair) ; http://www.catb.org/esr/writings/taoup/html/ch20s03.html (The Unix API Doesn't Use Exceptions) ; http://www.catb.org/esr/writings/taoup/html/ch10s07.html (On Breaking These Rules). Book only.
