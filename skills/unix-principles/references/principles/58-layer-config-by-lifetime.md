# Layer configuration from global to local, matched to how long a setting lasts

**Rule:** Read settings in order system file, system environment, user file, user environment, command line, later overriding earlier, and place each setting by lifetime: site facts system-wide, personal preferences per user, per-run and per-instance values on the command line.

**Why:** Earlier layers can compute where later ones live. Settings that differ between concurrent instances cannot come from files all instances share, and a preference shared by many programs is tedious to repeat in each one's file, which is what environment variables are for, along with values handed down a process tree and per-process debugging overrides. Variables are poor for structured data, are scattered, and may be absent under background services.

**Do:**
```
cfg = defaults
merge(cfg, system_file); merge(cfg, system_env); merge(cfg, user_file); merge(cfg, user_env); merge(cfg, cli_args)
```

**Don't:** Put a per-run option in a file, encode a whole option dialect in one variable, or rely on variables existing under a daemon.

**Break it when:** An administrator must lock a setting; enforce it in the system layer and ignore overrides.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch10s02.html (Where Configurations Live) ; http://www.catb.org/esr/writings/taoup/html/ch10s04.html (Environment Variables) ; http://www.catb.org/esr/writings/taoup/html/ch10s06.html (How to Choose among the Methods). Book only.
