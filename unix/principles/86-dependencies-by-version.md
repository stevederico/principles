# Resolve dependencies by version and let versions coexist

**Rule:** Let each program name the version of a shared library or API it needs, install versions side by side in version-qualified locations, and never let an install silently replace what another program uses.

**Why:** Clients cannot be counted on to upgrade in lockstep, so without version resolution installs randomly change libraries underneath other programs, forcing each to ship private copies. A runtime with one global search path leads to chronic deployment clashes when platform and application carry different versions.

**Do:**
```
dependency = name + version_constraint
install to prefix/name-VERSION/{bin, lib, include}
each application resolves its own pinned dependency set
```

**Don't:** Overwrite a shared file in place with whatever version the installer carries.

**Break it when:** One controlled environment owns all dependencies, such as a lock-file-driven build, or a component is private to a single client and upgrades with it.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch03s02.html (Windows NT (library versioning)) ; http://www.catb.org/esr/writings/taoup/html/ch14s04.html (Language Evaluations (Java)) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Design for upgradability). Book only.
