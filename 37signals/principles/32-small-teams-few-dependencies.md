# Keep teams and modules small, with few dependencies between them

**Rule:** Start with a very small team that covers design and code, give it whole features, and partition programs the same way: units with minimal shared state between them.

**Why:** Communication paths grow roughly with the square of members, and adding people to a late project slows it. Shared globals and passed data are the dependencies that make code behave like a big team. A designer who writes HTML and CSS in the real codebase and a senior programmer can carry a feature from concept to release as a pair, which makes the early integrated slice possible.

**Do:**
```
team_v1 = { developer, designer, generalist }
partition(program) so cross-unit dependencies are minimal
designer commits to real views ; programmer wires data
```

**Don't:** Add people to a late project, split design, code and copy into silos, or hand design to a pipeline that cannot touch the code.

**Break it when:** The domain truly needs many specialties; split into small autonomous units, not one big team. Native platform constraints may require programmers to build views.

**Source:** https://basecamp.com/gettingreal/03.3-the-three-musketeers ; https://basecamp.com/gettingreal/07.1-unity ; https://basecamp.com/gettingreal/07.3-meetings-are-toxic ; https://github.com/basecamp/handbook/blob/main/titles-for-designers.md. Docs only.
