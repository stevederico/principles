# Describe builds as dependencies and rebuild only what is out of date

**Rule:** Express each derived file in terms of what it depends on and how to make it, keep the descriptions in plain text that tools can read or generate, use one build graph rather than recursive sub-builds, and let the tool rebuild the minimum.

**Why:** Hand-entered build commands are tedious and error-prone, and a stale derived file wastes debugging time on a bug already fixed. The same mechanism ties generated code and documents to their masters. Recursive sub-builds hide cross-directory dependencies.

**Do:**
```
target: sources
    recipe        # rebuild if any source is newer than target
include(subdirectory_descriptions) into one graph
generated_build_file = template + probe_results       # still plain text
```

**Don't:** Build everything by hand, chain sub-builds by shelling out, or hide build state in an opaque store.

**Break it when:** The build is tiny and one command is clearer; subprojects are truly independent products; or a generator's complexity exceeds the problem.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch15s04.html (make) ; http://www.catb.org/esr/writings/taoup/html/ch15s04.html (Basic Theory of make) ; http://www.catb.org/esr/writings/taoup/html/ch15s04.html (Generating Makefiles). Book only.
