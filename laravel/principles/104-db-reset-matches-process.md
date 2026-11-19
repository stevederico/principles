# Reset matches the process

**Rule:** Reset test data by whether test and code share a database connection: roll back a wrapping transaction when they do, truncate or rebuild tables when they do not, and build the schema once per run and give each parallel worker its own database, never the development one.

**Why:** A browser test runs the app in another process, so a transaction opened in the test is invisible to it, and so is an in-memory database. Shared state makes parallel tests flaky.

**Do:**
```
in-process tests:     before_all: migrate if stale ; each: begin; test; rollback
out-of-process tests: first run: migrate ; each: truncate all except the migrations table (file or server DB)
parallel: db_name = base + "_test_" + worker_token
dev setup: create "app" and "testing" databases
```

**Don't:** Re-creating the schema per test, or using the fast in-process reset for end-to-end tests.

**Break it when:** The code under test commits on another connection and needs real transactions. The browser driver runs inside the test process.

**Source:** https://laravel.com/docs/database-testing, https://laravel.com/docs/dusk, https://laravel.com/docs/testing, https://laravel.com/docs/sail ; code: src/Illuminate/Foundation/Testing/RefreshDatabase.php, src/Illuminate/Foundation/Testing/DatabaseTruncation.php, src/Illuminate/Testing/Concerns/TestDatabases.php
