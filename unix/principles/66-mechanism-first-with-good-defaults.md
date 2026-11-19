# If you favor mechanism, ship sensible defaults and a way back

**Rule:** When you lean toward flexible mechanism over fixed policy, provide defaults that cover the common case, a one-step reset, and guidance for the usual tasks, keeping advanced features present but inconspicuous.

**Why:** Expressiveness avoids patronizing users whose needs you cannot know, but finishing the flexible interface is not finishing the job: an interface nobody can use without study has failed. Small, orthogonal interfaces let simple uses stay simple while unplanned combinations remain possible.

**Do:**
```
defaults cover the common case; restore_defaults() exists
quick-start recipes for the most common tasks
implement the full standard option set; hide rarely needed options from the default view
```

**Don't:** Declare done when the flexible interface works but only its author can use it.

**Break it when:** The audience is certainly non-technical and a fixed policy is acceptable.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch11s05.html (Transparency, Expressiveness, and Configurability) ; http://www.catb.org/esr/writings/taoup/html/ch11s02.html (History of Interface Design on Unix) ; http://www.catb.org/esr/writings/taoup/html/ch01s05.html (Flexibility All the Way Down). Book only.
