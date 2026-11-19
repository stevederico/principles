# Sandbox any embedded language that can run untrusted code

**Rule:** Restrict an embedded language's reach to files, network and processes to what its purpose needs, and route all access to the host through one narrow object.

**Why:** Browser scripting avoids direct file writes and its own network connections to prevent attacks from pages, and a transformation-language processor reads input and writes output but opens no sockets. A single binding object to the host was judged a well-designed model for embedding.

**Do:**
```
host = { limited_read, limited_write, ui_calls }       # the only door
deny: raw sockets, subprocess launch, arbitrary file writes
```

**Don't:** Hand the scripting layer the full privileges of the host process.

**Break it when:** Scripts are fully trusted and written by the same team.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch08s02.html (Case Study: JavaScript) ; http://www.catb.org/esr/writings/taoup/html/ch08s02.html (Case Study: XSLT) ; http://www.catb.org/esr/writings/taoup/html/ch08s03.html (Choosing the Right Complexity Level). Book only.
