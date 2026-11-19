# Embed a reference, not a copy

**Rule:** When stored text mentions another record, store a signed reference and resolve it at render time, with a fallback view when the target is gone.

**Why:** Edits to the target then show everywhere. A deleted target renders a missing-item view instead of breaking the page. The signed id is scoped to a purpose, so it cannot be forged or reused elsewhere.

**Do:**
```
body stores: <ref signed(Person, 7, purpose = attachable)/>
render: person = locate_signed(ref, purpose = attachable) or MissingPerson
        show(person.partial or missing.partial)
```

**Don't:** Paste a snapshot of the target's name or avatar into the text, or let a deleted target raise while rendering.

**Break it when:** The text must record what it said at write time (legal, audit): store a snapshot.

**Source:** Guide: https://guides.rubyonrails.org/action_text_overview.html (Signed GlobalID, Rendering a Partial for an Unresolved Instance). Code: actiontext/lib/action_text/attachable.rb:41-45,70-79; actiontext/lib/action_text/attachables/missing_attachable.rb:16-22.
