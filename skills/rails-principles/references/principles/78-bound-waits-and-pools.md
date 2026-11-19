# Bound every wait, retry and pool

**Rule:** Give every outbound call and shared resource a timeout, retry only operations that are safe to repeat with a deadline and random jitter, and size each pool to the concurrency in front of it.

**Why:** A missing timeout hangs workers, unbounded retries multiply load, and synchronized retries stampede. Vendor SDK defaults can hold a connection for minutes. A pool smaller than the threads that use it stalls them, and every role, replica and shard adds pools.

**Do:**
```
smtp: open_timeout 5s, read_timeout 5s
storage client: open 5s, read 10s, retries 2
db pool exhausted: wait up to N sec, then raise
db retry: connection_retries = 1, idempotent queries only, stop after retry_deadline
job retry: wait = base^attempts + random * jitter(15%), attempts = 5
threads per process = 3; pool >= 3 per database; processes x threads x databases <= db limit
socket worker pool 4 <= database connections available to it
name shared resources by environment so dev cannot touch production
```

**Don't:** Retry non-idempotent writes automatically, accept library defaults on the request path, or raise threads without raising the pool.

**Break it when:** A long operation is expected (set a long explicit timeout, not none); background jobs doing long transfers get their own limits; threads that never touch the database.

**Source:** Guides: https://guides.rubyonrails.org/configuring.html (smtp_timeout, Database Pooling, Configuring Retry Behavior, retry_jitter); https://guides.rubyonrails.org/active_storage_overview.html (S3 Service tip); https://guides.rubyonrails.org/action_cable_overview.html (Worker Pool Configuration); https://guides.rubyonrails.org/active_record_multiple_databases.html (Connection Pool Size). Code: activerecord/lib/active_record/connection_adapters/abstract_adapter.rb:305-315,1135-1148,1262-1268; activejob/lib/active_job/exceptions.rb:11,32,38,69; railties/lib/rails/generators/rails/app/templates/config/puma.rb.tt:20-24; actioncable/lib/action_cable/server/base.rb:127.
