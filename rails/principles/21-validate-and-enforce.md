# Validate in the model, enforce in the database

**Rule:** Put data rules on the domain object so every write path checks them, and back every rule that can race (uniqueness, references, required, closed sets) with a database constraint that settles conflicts.

**Why:** Model rules work on any database, cannot be skipped by end users and give friendly errors. But a uniqueness check is a lookup before the write, so two concurrent requests can both pass. Only the constraint is atomic.

**Do:**
```
Account.validate email unique                  # message, on every save path
unique index accounts(email)                   # the guarantee
foreign key line_items.order_id -> orders; not null where required
status: enum(draft, published, archived), default draft; unknown value raises
LineItem.validate order present                # the object, not just order_id
parent link required unless declared optional
find_or_create: try insert; on unique violation, read the existing row
database strict mode: error on too-long values, never truncate
```

**Don't:** Rely on check-then-insert alone, validate only in a handler or browser, or declare a relationship without its column constraint.

**Break it when:** Another application shares the data (put more rules in the database). If a store has no constraints, use a lock or an atomic conditional write. Legacy imports may switch strictness off for that connection.

**Source:** Guides: https://guides.rubyonrails.org/active_record_validations.html (Why Use Validations?, uniqueness warning, presence); https://guides.rubyonrails.org/active_record_migrations.html (Active Record and Referential Integrity); https://guides.rubyonrails.org/association_basics.html (belongs_to); https://guides.rubyonrails.org/active_record_querying.html (create_or_find_by); https://guides.rubyonrails.org/active_record_postgresql.html (Enumerated Types). Code: activerecord/lib/active_record/validations/uniqueness.rb:20-50; activerecord/lib/active_record/associations/builder/belongs_to.rb:136-165; activerecord/lib/active_record/relation.rb:255-298.
