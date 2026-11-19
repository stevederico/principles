# CLI for every app

**Rule:** Give every app its own command-line tool for operations, scaffolding and a live shell, keep each command a thin wrapper over the services the web layer also calls, and report success through the exit code.

**Why:** Admin tasks need an entry point with the app already loaded. Logic in services is reusable from web, queue and CLI; logic in a command is not, and neither are HTTP handlers a home for it. Automation reads exit codes, and prompts must fall back to arguments or defaults when no terminal is attached.

**Do:**
```
app make:policy Post ; app migrate ; app tinker
command mail:send(user_id):
  mailer = resolve(DripMailer)                  # same service the web uses
  if not mailer.send(find(user_id)): fail("could not send")     # exit code 1
missing required argument and interactive: ask ; not interactive: fail with a clear message
```

**Don't:** Business logic in the command body, or standalone scripts that rebuild the app wiring by hand.

**Break it when:** A task is tiny and has no reuse: register it as an inline closure command.

**Source:** https://laravel.com/docs/artisan, https://laravel.com/docs/structure, https://laravel.com/docs/prompts, https://laravel.com/docs/console-tests ; code: src/Illuminate/Console/Command.php, src/Illuminate/Console/Concerns/PromptsForMissingInput.php
