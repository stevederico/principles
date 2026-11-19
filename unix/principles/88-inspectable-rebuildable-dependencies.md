# Depend on components you can inspect, rebuild and vet

**Rule:** Prefer reused components whose source you can read, trace into and fix, with a way to rebuild them, and before adopting a package read its docs, skim its code, and check signs of life such as credited contributors, activity, ports and inclusion elsewhere; then test it yourself.

**Why:** You cannot fix what you cannot see, and with a nontrivial interface you cannot use it properly either, since documentation cannot capture every nuance. Opaque parts push people to workarounds and then to rewriting. Platforms keep changing, so only what can be rebuilt survives. A larger community tends to reinforce quality.

**Do:**
```
before depending on X: can I read it, trace into it, patch it, rebuild it?
check(contributors, activity, ports); run(own_tests)
if no open alternative exists for a hard requirement: isolate it behind an interface
```

**Don't:** Build on a black box with no escape hatch, or choose by marketing or by price alone.

**Break it when:** The component is small, stable and thoroughly tested by others, or internal and fully under your control.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch16s01.html (The Tale of J. Random Newbie) ; http://www.catb.org/esr/writings/taoup/html/ch16s02.html (Transparency as the Key to Reuse) ; http://www.catb.org/esr/writings/taoup/html/ch16s04.html (The Best Things in Life Are Open) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Don't rely on proprietary code). Book only.
