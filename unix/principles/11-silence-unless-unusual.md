# Say nothing when there is nothing unusual to say

**Rule:** When a run goes as expected, produce no output beyond the requested data; report only deviations, send them to the error channel, and keep chatter behind an off-by-default verbosity switch.

**Why:** User attention is scarce, and a quiet program is easy for a person to scan and for another program to consume. Messages about start-up, shutdown or other things the user already knows only force every caller to filter them out.

**Do:**
```
on success:   emit(requested_data_only)
on anomaly:   write(error_channel, exact_problem); exit(nonzero)
if verbose:   emit(progress_and_debug)
```

**Don't:** Print banners, "starting" and "done" lines, or narration of internal steps by default.

**Break it when:** A long operation looks hung without feedback; a progress indicator tells the user to look away and is good manners.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Silence) ; http://www.catb.org/esr/writings/taoup/html/ch11s09.html (Silence Is Golden). Book only.
