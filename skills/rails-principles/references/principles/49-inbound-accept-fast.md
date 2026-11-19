# Accept fast, persist raw, process later

**Rule:** An inbound endpoint stores the raw message with a unique id and a status, acknowledges, and does the work in a background job. The unique id makes a retried delivery a no-op, and raw data is deleted on a timer once the handler has copied what it needs.

**Why:** The provider retries on slow answers. A stored lifecycle (pending, processing, delivered, failed, bounced) makes problems visible. Keeping raw payloads forever holds people's data for no reason.

**Do:**
```
ingress(raw):
  id = message_id(raw) or checksum(raw)
  record = InboundEmail.create(raw, id, status = "pending")   # unique(id): duplicate -> return
  enqueue Route(record.id)
handler: copy fields into domain records
after processing: schedule Delete(email) in 30 days    # configurable
```

**Don't:** Parse and act inside the HTTP request, process the same delivery twice, or rely on the raw payload as source of truth.

**Break it when:** The sender needs the result in the response, or law requires longer retention (set it explicitly). The long delay needs a queue that can hold a job that far ahead.

**Source:** Guide: https://guides.rubyonrails.org/action_mailbox_basics.html (What is Action Mailbox?, Inbound Email Status, Incineration of InboundEmails). Code: actionmailbox/app/jobs/action_mailbox/routing_job.rb:4-12; actionmailbox/app/models/action_mailbox/inbound_email/message_id.rb:16-30; actionmailbox/lib/action_mailbox.rb:22; actionmailbox/app/jobs/action_mailbox/incineration_job.rb:18.
