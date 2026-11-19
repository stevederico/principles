# Scheduler

**Rule:** Define recurring tasks in code and give the server one per-minute trigger that asks which are due, and opt in to locks for overlap and for one-server runs.

**Why:** Schedules are versioned and reviewed. A due task starts even if its previous run is still going, so overlap protection is not automatic, and the default lock expiry is 24 hours, so a crashed run blocks it for a day. Sub-minute tasks run inside that minute's loop, one after another. Maintenance mode and a manual pause skip tasks unless a task opts in. Run in UTC so daylight-saving shifts neither double nor skip a run. Tables that only grow (failed jobs, tokens, batches) get a scheduled prune with an age threshold and a count-only dry run; for records, define "no longer needed" as a query on the record type, with a per-record form that runs a cleanup hook first and a mass form that is one hook-free delete. A batch loop gets a deadline shorter than its interval, and holds its lock open with a timed refresh.

**Do:**
```
schedule.every_five_minutes(SyncFeeds).without_overlap(expire_after = 10 min)
schedule.daily_at("02:00", PruneFailedJobs(older_than = 48h)).on_one_server()
schedule.every_ten_seconds(Heartbeat).dispatch_to_queue()
Flight.prunable(): where(created_at <= now - 1 month) ; schedule daily: prune --pretend
pending.stream().stop_at(now + 14min).with_heartbeat(4min, lock.refresh).each(process)
# server: * * * * *  app run-scheduled
```

**Don't:** Assuming the trigger prevents double runs, an overlap lock with no expiry, or one server cron line per task.

**Break it when:** A slow task must not delay others: send it to the queue or background. Legally required history: archive instead of pruning.

**Source:** https://laravel.com/docs/scheduling, https://laravel.com/docs/eloquent, https://laravel.com/docs/queues, https://laravel.com/docs/sanctum, https://laravel.com/docs/collections ; code: src/Illuminate/Database/Eloquent/Prunable.php, src/Illuminate/Collections/LazyCollection.php, src/Illuminate/Console/Scheduling/Event.php, src/Illuminate/Console/Scheduling/ManagesAttributes.php, src/Illuminate/Console/Scheduling/ScheduleRunCommand.php, src/Illuminate/Console/Scheduling/CacheSchedulingMutex.php
