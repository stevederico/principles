# Shape application protocols as typed text lines with status plus message

**Rule:** Model new protocols on durable designs: a command word with arguments, a reply starting with a machine-readable status followed by human text, an explicit terminator for multi-line payloads, and an error reply instead of a crash for unknown commands.

**Why:** Readable dialogue lets people interpret dumps, write test loads by hand and probe a server by typing. Adding a request type barely changes the parser, and tolerating unknown requests let long-lived protocols grow with few interoperability breaks.

**Do:**
```
on line: verb = first_word(line)
    if verb in handlers: handlers[verb](rest)
    else: reply("5xx unknown command")            # connection stays alive
payload: either send length first, or end with a lone terminator line (escape any payload line equal to it)
```

**Don't:** Invent a new request layout per service, or pack unlabelled binary fields and assume both ends upgrade together.

**Break it when:** Data volume is large, the server must push asynchronous messages, or latency demands compact typed binary framing.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch05s03.html (Application Protocol Design) ; http://www.catb.org/esr/writings/taoup/html/ch05s04.html (The Classical Internet Application Metaprotocol) ; http://www.catb.org/esr/writings/taoup/html/ch05s03.html (Case Study: SMTP and Case Study: POP3). Book only.
