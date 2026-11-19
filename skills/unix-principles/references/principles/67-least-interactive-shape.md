# Choose the least interactive interface shape that does the job

**Rule:** Default to designs needing no interaction after launch: take arguments and return a status, or only produce output, or only consume input, or take resource names and write derived resources; wrap them in an interactive layer if people want one.

**Why:** Programs driving programs cannot improvise through prompts, and a set of non-interactive tools can always be fronted by a dialogue while the reverse is hard. Fewer channels to the environment make a program easier to drive. One program may offer both a conversational mode and a plain dump mode from the same core.

**Do:**
```
program(args, input) -> output, exit_status          # default shape
if dialogue_needed: separate_wrapper.calls(program) or add a mode flag over the same core
```

**Don't:** Add prompts and menus to a tool whose job is a single transaction.

**Break it when:** The task genuinely needs a dialogue, such as a true graphical editor; then split engine and interface.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch11s06.html (The Cantrip, Source, Sink and Compiler Patterns) ; http://www.catb.org/esr/writings/taoup/html/ch11s07.html (Applying Unix Interface-Design Patterns). Book only.
