# Keep startup settings in forgiving, human-readable files named after the program

**Rule:** Store startup settings in a plain text file named for the program, with a system copy and a per-user hidden copy, comments, tolerant whitespace, simple tokens, quoted strings, standard escapes; read shared credentials from an established common file; avoid one global shared store.

**Why:** The file is read once, so readability beats speed. A shared host-and-login file saves users from learning another format and from duplicating secrets. A single giant registry that every program touches makes the whole machine fragile: one program's fault can corrupt it, and access slows as it grows. If the program is itself an interpreter, the startup file is just commands in its own language.

**Do:**
```
path = system_dir/<program>.conf, then ~/.<program>
parse: strip_comment; split_tokens; allow "quoted token with escapes"
credentials = lookup(shared_credentials_file, host)       # explicit flag overrides
```

**Don't:** Attach meaning to tab versus blank or invisible characters, or invent a private password store where a shared one exists.

**Break it when:** The shared file's permissions or format cannot meet your security needs, or a central store is needed for transactional fleet policy with per-key isolation and backup.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch10s03.html (Run-Control Files) ; http://www.catb.org/esr/writings/taoup/html/ch10s03.html (Case Study: The .netrc File) ; http://www.catb.org/esr/writings/taoup/html/ch03s02.html (Windows NT). Book only.
