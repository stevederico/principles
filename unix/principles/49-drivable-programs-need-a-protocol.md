# If another program will drive yours, offer a protocol instead of a conversation

**Rule:** Give a program that other programs will control an explicit end-of-output marker (or a length prefix, with marker lines escaped) and no prompts only a human could parse, and let callers override the child command they launch.

**Why:** People see where output ends; programs cannot, and buffered input can make a reader consume past the boundary and deadlock the pair. Driving a child over two-way pipes needs a state machine on both sides and is far harder to debug than a one-way hand-off. An overridable child command lets you slot a logging harness between them during development.

**Do:**
```
protocol_mode: after each response print(sentinel_line); escape(payload lines equal to sentinel)
child_command = flag or env["CHILD_CMD"] or default
```

**Don't:** Make callers guess end-of-output from prompt text, or scrape human-oriented output as a lasting protocol.

**Break it when:** A few easily recognized values come back and parse breakage is cheap; or the tool is for humans only.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch08s03.html (Language or Application Protocol?) ; http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Slave Processes) ; http://www.catb.org/esr/writings/taoup/html/ch11s06.html (The ed pattern). Book only.
