# Make the test environment hermetic

**Rule:** Replace every external service in tests with a local fake and check the fallbacks, keep the test database in step with the committed schema automatically, control the clock inside a block, and test jobs through the queue.

**Why:** A model that names a cloud storage service sends real requests in tests unless the test config redefines that name. A stale test database gives confusing failures. Going through the queue exercises serialization and retries, while calling the job body directly skips them.

**Do:**
```
test: mail = collect_only; storage "s3" = local_disk; queue = capture
before suite: if schema file is newer than the test db: load it; pending migrations -> abort with a message
travel_to(date) { assert user.eligible_for_gift() }       # scoped; sub-second part dropped
assert_enqueued(BillingJob) { account.charge(product) }
run_enqueued_jobs(); assert account.charged
BillingJob.new(args).perform raises InsufficientFunds      # direct call only for exceptions
```

**Don't:** Assume "test environment" means "no external calls", sleep to wait on time, or rebuild the test database by hand after every pull.

**Break it when:** A deliberate contract test against the real service, or a test database managed elsewhere in CI (disable the check).

**Source:** Guides: https://guides.rubyonrails.org/testing.html (Configuring the Delivery Method for Test, Configuring services, Testing Jobs, Maintaining the Test Database Schema, Testing Time-Dependent Code); https://guides.rubyonrails.org/4_1_release_notes.html (test schema kept up to date). Code: activerecord/lib/active_record/migration.rb:716-748; activerecord/lib/active_record/railtie.rb:33; activesupport/lib/active_support/testing/time_helpers.rb:81-83,144-182; activejob/lib/active_job/queue_adapters/test_adapter.rb:4-21.
