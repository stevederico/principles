# Design protocols and services for latency first, and overlap requests

**Rule:** Minimize dependent round trips before worrying about bandwidth, let clients stream requests tagged with identifiers so replies may return in any order, and let receivers reject cheaply before bulky payloads.

**Why:** Bandwidth problems can be patched later, for example by compressing a stream, but latency built into a design is very hard to remove, and a handshake per transaction multiplies connection latency. Lockstep request and reply makes waiting the dominant cost.

**Do:**
```
for item in items: send(request(id=new_tag(), item))
on reply(tag): complete(pending[tag])
large message: send(header) ; if accepted: send(body)
```

**Don't:** Wait for each answer before sending the next independent request.

**Break it when:** Requests depend on each other's results, the server cannot interleave, or bandwidth is the proven constraint.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch12s04.html (Throughput vs. Latency) ; http://www.catb.org/esr/writings/taoup/html/ch05s03.html (Case Study: IMAP) ; http://www.catb.org/esr/writings/taoup/html/textualitychapter.html (Chapter 5 introduction). Book only.
