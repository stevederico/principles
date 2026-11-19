# Provide sharp knives

**Rule:** Trust developers with power. Make the safe path the easy one, keep the dangerous path available, and force the call site to say it is using it.

**Why:** Locking power away pushes experts to work around the framework. Friction at the call site keeps the knowledge visible without removing the tool.

**Do:**
```
save(record)                          # validates
save(record, validate = false)        # flag on the safe call, visible in review
delete_all(rows)                      # distinct name: skips rules and cleanup
redirect(url)                         # off-site target refused
redirect(url, allow_external = true)  # the call site says so
where(raw_sql("..."))                 # raw fragment must be marked
reset_database in production          # refused unless an explicit override is set
```

**Don't:** Forbid an operation because it can be misused, or hide the risky form behind a quiet default.

**Break it when:** The damage is silent and irreversible (data loss, security holes): add friction, not a wall.

**Source:** Doctrine: https://rubyonrails.org/doctrine (Provide sharp knives). Guides: https://guides.rubyonrails.org/active_record_validations.html (Skipping Validations); https://guides.rubyonrails.org/active_record_callbacks.html (Skipping Callbacks); https://guides.rubyonrails.org/5_2_release_notes.html (raw SQL must be marked); https://guides.rubyonrails.org/security.html (Unsafe Query Generation). Code: activerecord/lib/active_record.rb:201-211; activerecord/lib/active_record/tasks/database_tasks.rb:71-77; actionpack/lib/action_controller/metal/redirecting.rb:155-162,273-295; activerecord/lib/active_record/sanitization.rb:221-236.
