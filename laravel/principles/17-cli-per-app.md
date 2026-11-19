# CLI for every app

**Rule:** Give every app its own command-line tool. It runs tasks, opens a shell on the app, and generates boilerplate.

**Why:** Admin tasks, one-off fixes and scaffolding need a safe entry point with the app already loaded. Generators keep file shape and naming consistent.

**Do:**
```
app make:policy Post       # creates the file in the right place
app migrate
app tinker                 # live shell with the app loaded
app reports:send --week=47 # custom commands
```

**Don't:** Write one-off scripts that reconnect to the database and rebuild the app by hand.

**Break it when:** A task is a one-time data fix. A throwaway script is fine if it is committed.

**Source:** Laravel docs, Artisan console.
