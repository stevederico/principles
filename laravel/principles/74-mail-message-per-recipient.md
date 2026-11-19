# A fresh message per recipient

**Rule:** Build a new message object for every recipient inside the loop, because adding a recipient to a message appends to it.

**Why:** Sending the same message object again adds each new address to the earlier ones, so later recipients also mail everyone who came before. The address setter appends and de-duplicates rather than replaces.

**Do:**
```
for r in recipients:
  send(new Receipt(order), to = r)        # fresh message each time
```

**Don't:** m = new Receipt(order); for r in recipients: send(m, to = r)     # recipient 3 mails 1 and 2 too

**Break it when:** You intend one message with a list of recipients.

**Source:** https://laravel.com/docs/mail ; code: src/Illuminate/Mail/Mailable.php, src/Illuminate/Mail/PendingMail.php
