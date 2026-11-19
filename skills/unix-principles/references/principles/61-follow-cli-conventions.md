# Follow the command-line option conventions

**Rule:** Use single-dash short letters that can be combined, double-dash long words with the value after a space or equals sign, a lone dash for the standard input, and a double dash to end options; reuse the established meaning of common letters and names.

**Why:** Users carry expectations across tools, and contradicting a strong convention in a mature domain earns scorn. Supporting both styles lets a tool start simple and add long names later without a flag day. Selecting behavior by the name a program was invoked under is generally considered unclean; take an explicit mode argument.

**Do:**
```
accept: -v, --verbose ; -o FILE, --output=FILE ; "-" = standard input ; "--" = end of options
use a standard argument-parsing library
if you break a convention: make the conventional attempt fail with an error naming the right form
```

**Don't:** Assign an unrelated meaning to a letter peers use for something else, or accept the conventional syntax and silently do something different.

**Break it when:** Your domain has its own entrenched incompatible conventions, or compatibility with a long-standing multi-name convention is required.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch10s05.html (Command-Line Options) ; http://www.catb.org/esr/writings/taoup/html/ch10s06.html (How to Choose among the Methods) ; http://www.catb.org/esr/writings/taoup/html/ch10s07.html (On Breaking These Rules). Book only.
