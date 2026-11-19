# Close rabbit holes and name no-gos before committing

**Rule:** Before a time box starts, walk the solution slowly for unknowns, settle hard questions in advance with a deliberately simple answer, list what is out of bounds, and ask an expert whether it fits the budget.

**Why:** One surprise can eat a third of the budget and some have no answer inside it. Builders want to cover every case they see, so an explicit fence keeps them inside. Everything is possible in software but nothing is free, so ask "doable within N weeks, and what could blow it up?", not "is it possible?".

**Do:**
```
for each part: needs new tech? assumes parts fit? assumes a design exists? hard choice open?
    patch = dictate_simple_answer(part)  or  cut(part)
spec.no_gos = [cases you will not support]
ask(expert, "doable in <budget> with these limits? what is the time bomb?")
if the unknown cannot be settled without building: make it an explicit time-boxed spike
```

**Don't:** Assume the builder will figure it out under the deadline, or send a document for a generic "what do you think".

**Break it when:** A patch destroys the value that made the project worthwhile; reshape instead. A later no-go that blocks the core case means reshape, not a quiet expansion.

**Source:** https://basecamp.com/shapeup/1.4-chapter-05 ; https://basecamp.com/shapeup/1.5-chapter-06 (Rabbit holes, No-gos). Docs only.
