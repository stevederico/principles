# Dev environment

**Rule:** Ship the development environment as files in the repo: one command starts every dev process with labelled output, local services speak the same protocols as production, tests get their own database, and outgoing mail never reaches real people.

**Why:** A new developer needs one step. An S3-compatible store and a mail catcher exercise the production driver with only an endpoint value changed. Restarting a crashed dev process is capped, and not at all if it died within a second of starting, since it never started. Dev servers listen on loopback only.

**Do:**
```
dev up: processes = {server, queue, logs, assets} ; restart max 5, wait 1s
env: STORAGE_ENDPOINT = http://local-store:9000          # same driver as production
if env == "local": mail.always_to("dev@example.com")     # drops cc and bcc
listen 127.0.0.1:80
```

**Don't:** A README listing four terminals, a shared staging bucket, or trusting that test data holds fake addresses.

**Break it when:** A solo project with a trivial stack. A dedicated staging inbox with seeded, owned addresses.

**Source:** https://laravel.com/docs/artisan, https://laravel.com/docs/sail, https://laravel.com/docs/mail, https://laravel.com/docs/valet, https://laravel.com/docs/filesystem ; code: src/Illuminate/Foundation/Console/DevCommand.php, src/Illuminate/Mail/Mailer.php
