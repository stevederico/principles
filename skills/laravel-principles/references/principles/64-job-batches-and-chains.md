# Batches and chains

**Rule:** For many pieces of work that belong together, create one tracked batch with an id, progress, cancel and before, progress, then, catch and finally hooks, and use a chain when the steps must run in sequence and stop at the first failure.

**Why:** One id gives a UI its progress and a single completion point. Parallel workers finish in no fixed order. By default the first failed task cancels the rest of the batch unless failures are allowed. Hooks run later in another process, so they must not capture live objects. A batch can grow itself from inside, which keeps the web request fast.

**Do:**
```
batch = batch([Import(1,100), Import(101,200)]).then(h1).catch(h2).finally(h3).dispatch()
task.run(): if batch.cancelled(): return; process()
chain([Download, Parse, Publish])           # sequential; a failure stops the rest
batch.add(more_tasks)                       # only from inside the same batch
```

**Don't:** Capturing live objects in hooks, starting thousands of tasks inside the request, or assuming batch tasks finish in order.

**Break it when:** Independent tasks that need no collective result.

**Source:** https://laravel.com/docs/queues ; code: src/Illuminate/Bus/Batch.php, src/Illuminate/Bus/PendingBatch.php
