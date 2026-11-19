# Release early, often and cheaply, and make the first release run

**Rule:** Make releases small, frequent and routine so feedback loops stay short, branch each release off the main line so other work continues, and ensure the very first public release builds, runs and does part of its final job.

**Why:** Small increments let you change course on real feedback, and a fast tempo gives effective feedback. A release that cannot build signals that authors cannot finish, and nobody can judge whether a change improved a program that does not run.

**Do:**
```
loop: cut_release_from_branch(); main_line keeps moving; version number increments
gate first release on: build passes; minimal real function demonstrable
```

**Don't:** Treat each release as a momentous event with promises attached and everyone else's work paused, or publish a skeleton that fails to build.

**Break it when:** A release is irreversible or safety-critical and needs a staged gate (keep it automated and cheap), or the artifact is a design proposal seeking review.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch19s01.html (Unix and Open Source). Book only.
