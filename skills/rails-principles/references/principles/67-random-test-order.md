# Expose hidden coupling in tests

**Rule:** Run tests in random order by default with a printed seed, assign parallel workers deterministically from the seed, and default job queues in tests to a capturing adapter that runs nothing until asked.

**Why:** Code that passes only through accidental order or synchronous work fails later in production. A seed and fixed worker assignment make the failure reproducible.

**Do:**
```
run tests --seed 4242 --workers 4        # same input -> same order; seed printed
workers get tests round-robin by seed (optional work stealing trades reproducibility for speed)
test env: rows from a query with no ORDER BY come back shuffled
test queue = capture; assert_enqueued(...); run_enqueued_jobs()
```

**Don't:** Fix a flaky test by re-running it, let a query that is ordered by luck pass, or run the queue inline in tests.

**Break it when:** Never in CI. To debug one failure, run serially with the same seed or allow sorted order.

**Source:** Guides: https://guides.rubyonrails.org/testing.html (Reporting Errors, Reproducing Flaky Parallel Tests); https://guides.rubyonrails.org/5_0_release_notes.html (random order, async default adapter); https://guides.rubyonrails.org/8_2_release_notes.html (deterministic assignment); https://guides.rubyonrails.org/configuring.html (test_order, shuffle_unordered_selects). Code: activesupport/lib/active_support/test_case.rb:67-69; activesupport/lib/active_support/testing/parallelization.rb:38-41; activesupport/lib/active_support/testing/parallelization/test_distributor.rb:70,161; activerecord/lib/active_record.rb:425-441; activejob/lib/active_job/railtie.rb:55.
