# Isolate each test in a rolled-back transaction

**Rule:** Wrap every database test in a transaction that is rolled back at the end, so each test starts from the same rows with no cleanup code. Opt out only for tests that need committed data, and then clean up yourself.

**Why:** Tests become independent and their changes are invisible elsewhere. Threads started by a test can share the pinned connection, but a test with its own connections or explicit transactions in threads can deadlock under the outer one.

**Do:**
```
setup:    begin_transaction(joinable = false); pin connection
test body
teardown: rollback
worker-thread test: use_transactional = false; delete own data in teardown
```

**Don't:** Truncate tables after each test, share data between tests, or leave opted-out tests without cleanup.

**Break it when:** The behavior only exists after a real commit (after-commit hooks in some setups, cross-process access).

**Source:** Guides: https://guides.rubyonrails.org/testing.html (Transactions, Testing Parallel Transactions); https://guides.rubyonrails.org/5_1_release_notes.html (transactional tests with multiple connections). Code: activerecord/lib/active_record/test_fixtures.rb:34,196-242.
