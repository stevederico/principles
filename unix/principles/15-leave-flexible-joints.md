# Leave flexible joints, not speculative features

**Rule:** Assume you do not have the final answer: place seams where change is likely and note how to extend there, but do not build the extension before it is needed.

**Why:** Designers cannot foresee every use, so a rigid structure costs a rewrite later, while speculative features waste effort now and add complexity that must later be removed.

**Do:**
```
make_seam(where_change_is_likely)
add_note("to support X, implement handler here")
do_not_write(handler_for_X)
```

**Don't:** Implement the speculative feature itself, or weld the design shut around today's use.

**Break it when:** The change is already known and imminent; then just build it.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Diversity and Rule of Extensibility). Book only.
