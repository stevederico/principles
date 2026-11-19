# Confirm destructive commands

**Rule:** Commands that can lose data ask for confirmation in the production environment, accept an explicit force flag to skip it, and offer a mode that prints what would run without running it.

**Why:** A typo against the wrong environment is expensive. One shared helper means every wipe, reset, seed and key command behaves the same, and outside production it does not nag.

**Do:**
```
if env == "production" and command.is_destructive:
  if not --force and not confirm("Are you sure?", default = no): abort
command migrate --pretend         # prints statements, runs none
command prune --pretend           # reports counts only
```

**Don't:** Letting a refresh or wipe command run silently against production, or each command inventing its own check.

**Break it when:** Automated deploys pass the force flag on purpose.

**Source:** https://laravel.com/docs/migrations, https://laravel.com/docs/seeding, https://laravel.com/docs/eloquent ; code: src/Illuminate/Console/ConfirmableTrait.php, src/Illuminate/Database/Migrations/Migrator.php
