# Migrations

**Rule:** Describe every schema change as an ordered, versioned file with apply and revert steps, replay the same list in every environment, run each in a transaction when the engine supports transactional DDL, and use non-blocking variants on busy tables.

**Why:** Teammates stop passing manual steps around and history is reviewable. Old files fold into a committed schema dump. Default DDL can lock a busy table, so build indexes online and add columns in instant mode. Behind a transaction-mode pooler, schema work needs a direct connection. Explicitly name long-lived foreign keys: derived names embed the table name.

**Do:**
```
2026_01_01_create_flights: up(): create table ... ; down(): drop table ...
fresh database: load schema_dump, then run remaining migrations
if db.supports_transactional_ddl and migration.in_transaction: transaction(up) else up()
create_index(users.email, online = true)
migrate on multi-server deploy: single-flight lock, second host exits quietly
```

**Don't:** Editing a shared database by hand, editing a migration that already ran elsewhere, or a blocking index build on a busy table.

**Break it when:** A throwaway local database. Engine statements that cannot run in a transaction opt out per migration.

**Source:** https://laravel.com/docs/migrations, https://laravel.com/docs/database ; code: src/Illuminate/Database/Migrations/Migrator.php, src/Illuminate/Database/Migrations/Migration.php, src/Illuminate/Database/Schema/Blueprint.php, src/Illuminate/Database/Console/Migrations/MigrateCommand.php
