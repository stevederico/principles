# Integrate one thin vertical slice in the first week

**Rule:** Finish one small piece end to end (interface plus working code) that someone can click through, and choose it to be core to the idea, small, and something the team has not done before.

**Why:** Backend work cannot be judged without an interface, and interface work is hypothetical until wired. Many tasks done with nothing demoable hides integration failures until late. Core pieces prove the idea, small ones give momentum, novel ones remove uncertainty; copying existing UI moves the project but teaches nothing.

**Do:**
```
slice = filter(parts, core) then filter(small) then prefer(novel)
wire real storage with stubs elsewhere; demo it to a stakeholder; call it done
```

**Don't:** Build all templates, then all models, then connect them at the end, or begin with login and account setup.

**Break it when:** A shared foundation (schema, auth model) must exist first; spike it in parallel with the slice. A peripheral item that blocks everything goes first.

**Source:** https://basecamp.com/shapeup/3.2-chapter-11 (Integrate one slice, Start in the middle). Docs only.
