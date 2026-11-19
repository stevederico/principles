# Decide what removal means

**Rule:** For every parent-child link, choose what deleting the parent does to its children (destroy each with rules, delete directly, null out, block, or remove later in a job), and offer separate verbs for unlinking and destroying shared things.

**Why:** A file or row can be referenced from several places. A direct delete skips hooks, a null-out fails on a not-null column, and a background removal combined with a database cascade breaks because the cascade runs first in the same transaction.

**Do:**
```
comments:   on_parent_delete destroy_each      # rules run, slow
audit_rows: on_parent_delete delete_in_db      # fast, no rules
exports:    on_parent_delete remove_in_job     # no database cascade on this key
photo.detach     # unlink only
photo.purge      # unlink; delete the file if it was the last reference
```

**Don't:** Put the delete option on both ends of a relation, null out a not-null column, or let "remove" silently destroy shared data.

**Break it when:** A database foreign-key cascade is the single source of truth: then declare nothing in the application. Files owned by exactly one record need only purge.

**Source:** Guides: https://guides.rubyonrails.org/association_basics.html (:dependent); https://guides.rubyonrails.org/active_storage_overview.html (Removing Attachments From a Model, Purging Unattached Uploads and detach); https://guides.rubyonrails.org/3_1_release_notes.html (destroy on an association removes the link). Code: activerecord/lib/active_record/associations/builder/association.rb:142; activerecord/lib/active_record/destroy_association_async_job.rb; activestorage/app/models/active_storage/attachment.rb:95-101,243-248.
