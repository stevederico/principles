# Make line-framed streams injection-proof and chunking-independent

**Rule:** Any text written into a line-framed stream (server-sent events) must be split or rejected so user data cannot inject fields or events, and the encoder's output must be identical for any split of the same input.

**Why:** Newlines in data become repeated data-prefixed lines (CR, LF and CRLF each handled), while event name, id and comment panic on line breaks and id also rejects NUL. A pending-CR flag handles a CR at a chunk end, and a test tries every pair of split points against one expected string.

**Do:**
```
data(text): for line in split_on_any_line_ending(text): write("data: " + line)
event(name): assert no CR or LF in name
test: for every way to split input into 3 pieces: assert encode(pieces) == expected
```

**Don't:** Write user text into event or id fields unchecked, or assume one write call.

**Break it when:** The raw-event escape hatch sends bytes verbatim with no framing or validation, so you own the protocol correctness then (sse.rs module docs).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/response/sse.rs (Event, EventDataWriter, tests).
