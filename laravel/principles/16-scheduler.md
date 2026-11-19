# Scheduler

**Rule:** Define all recurring tasks in code. The server needs just one trigger that runs every minute and asks which are due.

**Why:** Schedules are versioned, reviewed and deployed like any code. No one edits server cron tables by hand.

**Do:**
```
schedule.daily_at("02:00", PruneOldSessions)
schedule.every_five_minutes(SyncFeeds).without_overlap()

# server: * * * * *  app run-scheduled
```

**Don't:** Add a new server cron line for each task.

**Break it when:** You need exact sub-minute timing. Use a worker loop.

**Source:** Laravel docs, task scheduling.
