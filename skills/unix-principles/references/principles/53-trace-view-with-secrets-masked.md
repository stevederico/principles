# Ship a trace of real exchanges, with secrets masked and detail kept quiet

**Rule:** Provide a verbose or trace switch that shows the actual exchanges with the outside world, designed in from the start, masking credentials automatically; where the audience is mixed, show detail in a quiet place rather than hide it.

**Why:** Dumping every protocol transaction let a reader diagnose most bug reports in seconds from a pasted transcript, and the author credits much of the tool's robustness to it. Masking secrets makes transcripts safe to post without hand editing. A mail client that echoed protocol lines into a small status bar was ignorable for beginners and decisive for troubleshooters; hiding is different from making inaccessible.

**Do:**
```
if verbose: for each message: log(direction, redact_secrets(message))
ui.status_line.append(raw_event)            # small, dim, never modal
default: quiet
```

**Don't:** Treat debug output as a throwaway, rely on users to scrub passwords from logs, or suppress error detail because it may frighten people.

**Break it when:** Even a redacted transcript is unacceptable for the data involved; then provide a structured diagnostic summary.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch06s01.html (Case Study: fetchmail's -v option) ; http://www.catb.org/esr/writings/taoup/html/ch06s01.html (Case Study: kmail) ; http://www.catb.org/esr/writings/taoup/html/ch06s02.html (Transparency and Avoiding Overprotectiveness). Book only.
