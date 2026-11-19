# Prefer undo to confirmation prompts, and put safety nets above the primitives

**Rule:** Ask for confirmation only where "no" is a real possibility and the loss is hard to reverse, otherwise just act and offer undo; keep low-level primitives literal and add recoverable delete and versioning in the layer that knows user intent.

**Why:** Prompts nearly always answered yes train people to confirm without reading, defeating their purpose. Irreversible deletion irritates after typos and wildcard surprises, but primitives that guess intent become unpredictable.

**Do:**
```
low level:  delete(x) is final
app level:  delete(x) = move_to_recoverable_store(x, version) ; offer undo()
confirm only if destroys_data and answer_is_often_no
```

**Don't:** Pop up a dialog for routine actions, or make primitives guess whether the user meant it.

**Break it when:** The action is irreversible and undo is impractical, or data-loss cost is high and no higher layer exists; then version at the lowest practical level.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch11s09.html (Silence Is Golden) ; http://www.catb.org/esr/writings/taoup/html/ch20s03.html (File Deletion Is Forever). Book only.
