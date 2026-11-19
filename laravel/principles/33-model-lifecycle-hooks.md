# Model lifecycle hooks

**Rule:** Treat a record's lifecycle as named before and after moments (create, update, save, delete, restore), let a before moment cancel the action, group many listeners for one record type in a single observer, run handlers after commit when they have outside effects, and mute hooks only inside an explicit scope.

**Why:** Names ending in -ing run before anything is persisted and names ending in -ed run after. The save event fires even when no field changed. Grouping keeps one record type's reactions in one place. An observer inside a transaction can wait for the commit; with no transaction it runs at once. Muting is for deliberate work such as imports and silent saves.

**Do:**
```
on creating(user): if user.email is blocked: return false       # cancels the save
on created(user): enqueue(SendWelcome(user.id))
observer UserObserver implements after_commit: { created, updated, deleted, restored }
without_events(() -> import(rows))          # muted only inside this scope
user.save_quietly(); user.delete_quietly()
```

**Don't:** Putting side effects in a before hook (the save may still fail), muting events globally, or relying on a hook for rows changed by bulk statements.

**Break it when:** A rule that must always hold belongs in the database or a constraint, not in a hook that quiet saves and bulk paths skip.

**Source:** https://laravel.com/docs/eloquent ; code: src/Illuminate/Database/Eloquent/Concerns/HasEvents.php, src/Illuminate/Database/Eloquent/Model.php, src/Illuminate/Events/Dispatcher.php
