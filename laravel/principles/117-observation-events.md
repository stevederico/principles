# Subsystems emit observation events

**Rule:** Have each core subsystem (database, authorization, jobs, mail) emit a small event for each operation it performs, so monitoring and debugging tools subscribe from outside, and add a threshold on cumulative query time per request next to per-query slow logs.

**Why:** The debug dashboard's watchers work purely by listening: the database emits an event with the statement, bindings and duration, and each authorization check emits one with user, ability, result and arguments. Fifty fast queries can cost as much as one slow one, so a once-per-request handler on total database time catches what a single-query threshold misses.

**Do:**
```
db.run(query): t = timed(query); emit QueryExecuted(sql, bindings, t)
authorize(...): emit GateEvaluated(user, ability, result, args)
when_total_query_time_exceeds(500ms, (conn, event) -> notify(team))   # once per request
```

**Don't:** A separate tracing path built into each subsystem, or watching only single-query duration.

**Break it when:** A hot path that cannot afford even an emit: dispatch only when a listener is registered. Batch jobs where long database time is normal.

**Source:** https://laravel.com/docs/telescope, https://laravel.com/docs/database ; code: src/Illuminate/Database/Connection.php, src/Illuminate/Auth/Access/Gate.php, src/Illuminate/Auth/Access/Events/GateEvaluated.php
