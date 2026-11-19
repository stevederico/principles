# Let scripts pin behavior, and offer one generic set-option flag

**Rule:** Provide a switch that makes a program ignore ambient configuration files and environment so scripted runs are well defined, and for rare overrides take a single flag that sets any named key as if it were in the config file, instead of mirroring each key as its own flag.

**Why:** Pipeline use is configured entirely by arguments, while large interactive programs rely on files and environment, so a script needs a way to be independent of local settings. A tool that mirrored its whole config language on the command line found almost no option used and paid for it in code, manual and interaction bugs.

**Do:**
```
precedence: defaults < system < user < env < flags
--config FILE or --no-rc    # ignore ambient files
--set key=value             # generic override; scripts may generate a temporary config
```

**Don't:** Let user settings change the result of a scripted invocation, or add parallel flags reflexively whenever the config grows.

**Break it when:** A setting changes on nearly every invocation, so it earns its own flag; or it is a security policy users may not override.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch10s06.html (How to Choose among the Methods) ; http://www.catb.org/esr/writings/taoup/html/ch10s06.html (Case Study: fetchmail). Book only.
