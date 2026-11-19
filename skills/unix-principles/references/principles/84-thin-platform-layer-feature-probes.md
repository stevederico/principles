# Isolate platform differences in a thin layer chosen by feature probes

**Rule:** Confine platform-specific code to one thin layer exposing only the narrow operations you need, select implementations by probing for a feature rather than naming a platform, probe at build time instead of asking the installer, and keep conditional compilation out of the middle of logic.

**Why:** Platforms vary along several axes, so per-platform branches multiply and rot. A thin layer lets a platform specialist port without understanding the rest, and a narrow operation such as "does this file exist" avoids misuse of a broad system call. Users cannot answer questions about the environment correctly. Never take names that belong to other parts of the system.

**Do:**
```
portability_layer.exposes(file_exists, now)
facts = probe(system); generate_config(facts); build
at top, once: if feature_x: include(module_a) else: include(module_b)
```

**Don't:** Sprinkle platform conditionals through application code, or write one layer per platform.

**Break it when:** One platform is supported and will stay that way, or a choice is a real preference such as install prefix.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Recommended C/C++ Portability Practices) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Use GNU Autotools) ; http://www.catb.org/esr/writings/taoup/html/ch17s05.html (Tools for Portability). Book only.
