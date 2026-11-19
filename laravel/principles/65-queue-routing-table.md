# One routing table for queues

**Rule:** Keep the decision "which connection and lane does this kind of work use" in one central routing table keyed by task type, let an explicit setting on the task win over the table, and isolate heavy or critical work in its own capped lane instead of depending on list order.

**Why:** Moving a lane to another broker then touches one place instead of every dispatch site. A worker's ordered lane list gives strict priority only for plain workers; an auto-balancing supervisor shifts workers to whichever lane is backed up, so a guaranteed share needs a separate pool with its own minimum and maximum.

**Do:**
```
route(ProcessVideo -> lane "video")
route(any Broadcastable -> lane "events")
dispatch(ProcessVideo(v))                 # no lane argument
worker --lanes=high,default               # high drained first (plain mode)
pool heavy: lanes [images], min 1, max 1  # cannot starve the rest
```

**Don't:** Hard-coding lane names at every dispatch site, or putting "high" first and expecting it to win under automatic balancing.

**Break it when:** A single lane.

**Source:** https://laravel.com/docs/queues, https://laravel.com/docs/horizon ; code: src/Illuminate/Queue/QueueManager.php, src/Illuminate/Support/Queue/Concerns/ResolvesQueueRoutes.php
