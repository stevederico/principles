# Workers drain and recycle

**Rule:** Long-lived workers finish the current unit when told to stop, are restarted by a supervisor on every deploy, and exit on a bound of memory, time or task count.

**Why:** A worker keeps the booted code in memory, so deploys do not reach it; killing it mid-task loses or repeats work; slow leaks grow. The loop checks its limits after each task and exits with a reason. The same holds for app servers and the per-minute scheduler run.

**Do:**
```
worker: on SIGTERM: stop_after_current_task = true
task.interrupted(signal): save_progress(); stop
worker flags: max_tasks = 1000, max_seconds = 3600, memory_limit = 60%
deploy: ship_code(); signal_restart_all_workers()           # shared store flag; supervisor relaunches
```

**Don't:** Killing workers with no grace, assuming they notice new code, or running them unsupervised.

**Break it when:** Workers are replaced wholesale per release (containers), or a worker that re-boots per task is acceptable.

**Source:** https://laravel.com/docs/queues, https://laravel.com/docs/horizon, https://laravel.com/docs/octane, https://laravel.com/docs/artisan, https://laravel.com/docs/deployment, https://laravel.com/docs/scheduling ; code: src/Illuminate/Queue/Worker.php, src/Illuminate/Console/Scheduling/ScheduleRunCommand.php
