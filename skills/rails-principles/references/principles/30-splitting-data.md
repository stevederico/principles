# Know what splitting data costs

**Rule:** Before spreading data across databases or tenants, list the guarantees you lose, give each database one owner type, resolve the tenant once at the edge and lock it, and put the tenant first in composite keys.

**Why:** A transaction covers one connection, foreign keys and joins cannot cross clusters, and a cross-database association needs two queries and an in-memory sort. Two types naming one database create two pools. A tenant switch inside a request leaks data.

**Do:**
```
workflow touching two databases: write A, then B in an idempotent retryable step; reconcile on failure
abstract AnimalsRecord: connects(writer: animals, reader: animals_replica); Dog extends AnimalsRecord
shard = resolve(request.host); with_shard(shard, locked) { handle(request) }   # switching inside raises
primary key (store_id, sku); index on referencing (order_store_id, order_sku)
reporting database: connect = yes, manage = no
```

**Don't:** Assume a transaction spans two databases, update tenant-owned rows by id alone, or let migration tasks touch someone else's database.

**Break it when:** You accept eventual consistency and have reconciliation. Admin tooling may cross tenants in its own explicit context.

**Source:** Guides: https://guides.rubyonrails.org/active_record_multiple_databases.html (Caveats and Operational Considerations, Handling Associations Across Databases, Connecting Models to Another Database, Automatic Shard Switching, External Databases); https://guides.rubyonrails.org/active_record_composite_primary_keys.html (query_constraints, Column Order Matters, Index Foreign Key Columns Manually). Code: activerecord/lib/active_record/middleware/shard_selector.rb:39-43,75-79; activerecord/lib/active_record/persistence.rb:202.
