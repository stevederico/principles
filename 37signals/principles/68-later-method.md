# Put slow work in a method, add a "later" twin, keep the job one line

**Rule:** Implement the work as a model method, add a `_later` method that enqueues a job, and keep the job body a single delegating call; push anything that scales with audience size (fan-out, bulk delete, outbound calls) behind the queue.

**Why:** The poster should not wait for a per-member publish or an outbound webhook. Logic in the model stays testable, and the same method is callable synchronously from scripts.

**Do:**
```
bot.deliver_webhook_later(msg)       -> enqueue job ; job body: bot.deliver_webhook(msg)
user.remove_banned_content_later     -> job body: user.remove_banned_content
message.broadcast_unread_room_later
```

**Don't:** Put logic inside the job's perform step.

**Break it when:** The work takes microseconds.

**Source:** https://github.com/basecamp/once-campfire app/models/user/bot.rb, app/models/user/bannable.rb, app/models/message/broadcasts.rb, app/jobs/bot/webhook_job.rb, app/jobs/room/push_message_job.rb ; https://github.com/basecamp/writebook app/controllers/leafables_controller.rb.
