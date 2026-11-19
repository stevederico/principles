# Detect or try alternatives instead of adding a setting

**Rule:** Replace configuration switches with autodetection or try-each-alternative-until-one-verifies, unless the adaptive step adds noticeable latency.

**Why:** Switches burden users and manuals, and often users cannot answer correctly. A reader that retried with the opposite byte order after a checksum failure removed a common mistake. Below roughly seven tenths of a second users do not perceive the delay, and refusing to adapt for speed is probably premature optimization.

**Do:**
```
result = try(method_a)
if not verified(result): result = try(method_b)
fail only if every method fails
```

**Don't:** Ask the user for an encoding, byte order or protocol variant you can determine, or the installer for facts about the system.

**Break it when:** Detection is slow, unreliable, or might silently choose wrong with destructive effect.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch10s01.html (What Should Be Configurable?) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Use GNU Autotools). Book only.
