# Gate agent runs

**Rule:** Gate agent runs: pause before irreversible actions for an explicit per-call human decision, start with the narrowest tool set, and check budget, step cap and stop signals before every model step.

**Why:** Deletes and payments should not depend on model judgement alone. A loop can burn money over many steps, so a step-level hook that sees usage can end it while keeping finished work. An approval gate on a delegated sub-agent is invisible to the app, so keep gates on the top-level agent.

**Do:**
```
tool delete_file: needs_approval(args) = not args.path.startswith("temporary/")
resume(decisions: {call_abc: approve, call_def: reject("keep invoices")})
tools = file_tools(read_only = true) + web_search(max = 5, allow = ["docs.example.com"])
before each step: if stopped(user) or step.usage.input_tokens >= 50000: stop
```

**Don't:** Letting every tool run unattended, approving in bulk without call ids, or checking limits only after the run.

**Break it when:** Read-only or trivially reversible tools can skip approval. Single-call tasks need no step checks.

**Source:** https://laravel.com/docs/ai-sdk ; code: docs only (not in the framework repo)
