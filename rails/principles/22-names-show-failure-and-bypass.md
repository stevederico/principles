# Let names show failure and bypass

**Rule:** Offer a soft form that returns a failure value and a marked twin that raises, and give any operation that skips validation, hooks or cleanup a different name from the safe one.

**Why:** Form flows expect invalid input; scripts and jobs want a bad write to stop. A distinct name makes "did you mean to skip the rules?" answerable by reading the call.

**Do:**
```
ok = save(user)                # false on invalid, read errors
save!(user)                    # raises
find_one(id) -> nothing       find(id) -> raises not found
destroy_all(posts)             # loads each, runs rules and cleanup
delete_all(posts)              # one statement, skips both
update_columns(user, ...)      # raw write, skips hooks
enqueue_all(jobs)              # one round trip; no per-job hooks; one batch event
```

**Don't:** Ignore the soft return in a script, wrap the loud form in a catch-all in request code, or put required behavior only in per-item hooks and then use the bulk path.

**Break it when:** One caller style dominates (ship only the fitting form), or you load trusted data whose rules were already applied upstream.

**Source:** Guides: https://guides.rubyonrails.org/active_record_basics.html (Create, Update, Delete, Read); https://guides.rubyonrails.org/active_record_callbacks.html (Halting Execution, Skipping Callbacks); https://guides.rubyonrails.org/active_record_validations.html (Skipping Validations); https://guides.rubyonrails.org/active_job_basics.html (Bulk Enqueuing). Code: activerecord/lib/active_record/validations.rb:58-66; activerecord/lib/active_record/persistence.rb:430-431,637; activerecord/lib/active_record/relation.rb:1063-1081; activejob/lib/active_job.rb:66-88.
