# Make long jobs resumable

**Rule:** Split a long job into named steps, keep a cursor inside the step, and let it stop only at safe checkpoints so it resumes where it left off.

**Why:** Deploys and restarts interrupt workers, sometimes with only seconds of notice. Without checkpoints a restart means redoing everything or losing it. Finished steps are skipped on resume and an in-flight step continues from its cursor.

**Do:**
```
job import(id):
  import = load(id)                        # runs on every start
  step "validate": import.validate()
  step "process":  for r in records after step.cursor: process(r); step.advance(r.id)
  step "finish":   import.finish()
on stop at a checkpoint: save {done: [validate], current: process, cursor: 4812}; requeue
checkpoint inside an open transaction: error; resumption count capped
```

**Don't:** Write a multi-hour all-or-nothing function, keep progress only in memory, or catch the interrupt signal as an ordinary error.

**Break it when:** The job is short (seconds) or idempotent from the start; a plain retry is enough.

**Source:** Guides: https://guides.rubyonrails.org/active_job_basics.html (Job Continuations, Using a Cursor); https://guides.rubyonrails.org/8_1_release_notes.html (Active Job Continuations). Code: activejob/lib/active_job/continuation.rb:10-25,135-170,229-250; activejob/lib/active_job/continuable.rb:19-40.
