# One template for every path, and a closed set of update actions

**Rule:** Render the first page, the reply to an action and a pushed live update from the same server template, and let the update channel express only a small fixed vocabulary of edits (add, replace, remove, refresh) aimed at a target.

**Why:** Reuse makes live partial updates almost free and keeps all three paths visually identical. Sending executable code per response creates tangled scripts that cannot be replayed; a closed vocabulary keeps messages declarative and easy to follow, and extra behavior lives in attached client components.

**Do:**
```
template message(m) -> container(id = dom_id(m)) m.content
index: render message for each ; create: send(append, "messages", render message(new))
push:  same call from a background broadcaster
update = { action in [append, prepend, before, after, replace, update, remove, refresh], target, fragment }
unknown action -> raise
```

**Don't:** Write a second serializer and client template for updates, or add an "eval" action.

**Break it when:** The live fragment must differ for the viewer (pass a flag, still one template), or a real new verb is needed (register it centrally, keep it declarative).

**Source:** https://turbo.hotwired.dev/handbook/streams ; https://turbo.hotwired.dev/reference/streams ; code: https://github.com/hotwired/turbo src/core/streams/stream_actions.js, src/elements/stream_element.js.
