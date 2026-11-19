# Mass assignment allowlist

**Rule:** Reject bulk fill of record fields until each field is explicitly listed as fillable, and in development throw when an input field is dropped.

**Why:** A request field like is_admin must not set a column nobody meant to expose; nested JSON keys must be listed too. Trusted loaders (seeders, factories) lift the guard only for their own run.

**Do:**
```
Flight.fillable = [name]
Flight.create(input.validated())          # only name is accepted
dev: dropped field raises an error ; prod: drops it
seed_run: unguard_models: with_events_muted: root_seeder.call([Users, Posts])
```

**Don't:** Passing raw request data into create or update on an unguarded model, or leaving guards off globally.

**Break it when:** Hand-built internal arrays on an explicitly unguarded model. A seeder that must exercise listeners keeps events on.

**Source:** https://laravel.com/docs/eloquent, https://laravel.com/docs/seeding, https://laravel.com/docs/eloquent-factories ; code: src/Illuminate/Database/Eloquent/Concerns/GuardsAttributes.php, src/Illuminate/Database/Seeder.php, src/Illuminate/Database/Eloquent/Factories/Factory.php
