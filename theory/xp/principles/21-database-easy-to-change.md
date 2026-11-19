# Treat the database as easy to change

**Rule:** Act as if the database is easy to change, migrate it often, and keep staged copies (gold, silver, bronze) with ordered migration scripts.

**Why:** Do hard things more often and they stop being hard; relational databases were made to flex. Gold matches production, silver is a migrated gold, and each developer has a bronze copied from silver. A pair that releases code promotes bronze to silver and adds a migration script; production migrates by running the list in order. Silver always matches the released code and gold matches production. Rebuild gold with test data weekly to avoid corruption and prove the scripts. The team's later fix: migrations became executable methods on a maintenance object.

**Do:**
```
release: promote bronze -> silver; append migration script to ordered list
deploy: apply the list in order to production (gold)
weekly: rebuild gold from test data, migrate to silver
integrate: copy silver, check out released code, tests 100%
```

**Don't:** Putting off migrations because they are hard, or letting scripts depend on application code that may change.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/stories/testdb.html
