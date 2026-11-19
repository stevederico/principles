# Organise work by independently finishable scopes

**Rule:** Group tasks into scopes named in the project's own vocabulary, each an integrated slice that can be finished alone; discover them after the first days of real work and redraw as needed.

**Why:** Lists per role or per layer finish without adding up to a finished part and hide macro status. Scopes follow real interdependencies and give a shared language for what is done. Good scopes let you see the whole project, name each part, and know where a new task goes. A scope that hides unrelated parts or is too large behaves like a junk drawer.

**Do:**
```
scope = { name: "Send", tasks: design + code + test + bugs for that slice }
week 1: collect tasks; end of week 1: factor into scopes by dependency
if parts of a scope are at different stages, or backend >> UI: split into scopes
file bugs under the scope they affect; report per scope
```

**Don't:** Make lists called "Front-end", "Back-end" or "Bugs", or invent tidy categories before the work is understood.

**Break it when:** A thin uniform backend under a UI can share one scope; a similar past project may supply the structure. Question lopsided complexity before accepting it.

**Source:** https://basecamp.com/shapeup/3.3-chapter-12 ; https://basecamp.com/shapeup/3.4-chapter-13 (Prompts to refactor the scopes). Docs only.
