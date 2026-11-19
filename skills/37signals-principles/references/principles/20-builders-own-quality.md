# Builders own quality; QA hunts the edges

**Rule:** Developers write tests and confirm the project does what was shaped. A QA pass near the end looks for edge cases, and what it finds is a nice-to-have until triaged up. Scale test depth to the size and criticality of the change.

**Why:** Ownership of the whole project covers basic quality. QA pays off when small edge cases touch thousands of users, but shipping must not depend on it. Code review is likewise useful for learning but not a mandatory gate for everyone.

**Do:**
```
dev: own tests, verify against the shaped concept
qa findings -> separate list; team triages; a must-have moves into its scope
qa_depth = f(scope, criticality); big features add security, performance, accessibility
```

**Don't:** Use QA or review as the only defence, let findings expand scope automatically, or run the same heavy QA for every change.

**Break it when:** Regulated or safety-critical software needs mandatory independent review.

**Source:** https://basecamp.com/shapeup/3.5-chapter-14 (QA is for the edges) ; https://github.com/basecamp/handbook/blob/main/titles-for-QA.md. Docs only.
