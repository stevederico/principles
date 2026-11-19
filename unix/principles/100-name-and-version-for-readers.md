# Name and version releases so programs and people can read them

**Rule:** Choose a unique, easy-to-type project stem, name each artifact as stem, hyphen, dotted version and optional kind or platform, unpack archives into one new directory named for the project and version, and bump major for incompatible changes, minor for compatible additions and patch for fixes.

**Why:** Archives are increasingly processed by programs, and digits glued to a stem, a "v" prefix or a platform before the version make boundaries ambiguous. Unpacking into the current directory can overwrite existing files. Consumers should read compatibility from the number alone, and a clashing name confuses users and tooling.

**Do:**
```
name = stem + "-" + major.minor.patch + [".src" | ".bin"] + [".platform"] + archive_ext
archive paths all start with "name-version/"
bump(major if breaking; minor if additive; patch otherwise)
```

**Don't:** Hide breaking changes in a minor release, use underscores or capitals in the stem, or pack files at the archive root.

**Break it when:** The ecosystem or a specialized community has its own convention, or the archive is explicitly an overlay meant to merge into an existing tree.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Good Project- and Archive-Naming Practice) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Make sure tarballs always unpack into a single new directory). Book only.
