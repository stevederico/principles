# If you must use binary, specify every detail and let readers skip what they do not know

**Rule:** Give a binary format an exact specification of byte order, word sizes and padding, self-describing typed chunks with explicit lengths, a flag saying whether a chunk may be ignored, and a header that reveals common corruption.

**Why:** Length-prefixed typed chunks let new kinds of data appear without a release number, and the ignorable flag lets old readers pass over them. A distinctive header exposes damage such as altered line endings or stripped high bits. A tightly designed format with no rule for skipping trivial extensions makes extension painful.

**Do:**
```
chunk = type + length + data
type.flags.ignorable = may_old_readers_skip?
header = magic_bytes_that_break_visibly_if_newlines_or_high_bits_are_mangled
```

**Don't:** Leave endianness or padding implicit, or ship a tight format with no skip rule.

**Break it when:** Never; apply all of it whenever binary is chosen.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch05s01.html (Case Study: The PNG Graphics File Format) ; http://www.catb.org/esr/writings/taoup/html/ch05s01.html (The Importance of Being Textual (X protocol extensibility)). Book only.
