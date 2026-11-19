# Do not pipeline when an upstream step must wait for downstream confirmation

**Rule:** Keep steps in one process, or use a protocol with acknowledgments, when an irreversible upstream action depends on a later step succeeding.

**Why:** A one-way channel cannot carry confirmation. A mail fetcher that deletes remote messages must wait until local delivery accepted them, and a small-component version would need a back-channel more complex than a single program.

**Do:**
```
if step_n.has_irreversible_effect and depends_on(step_n_plus_1.success):
    keep_in_one_process() or use_protocol_with_acks()
else:
    pipeline(step_n, step_n_plus_1)
```

**Don't:** Delete the source before the sink confirms durable acceptance.

**Break it when:** The upstream action is idempotent or the data can be cheaply fetched again.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Anti-Case Study: Why Isn't fetchmail a Pipeline?). Book only.
