# Wrap work you start outside the framework

**Rule:** Run any code started from a thread, timer, script or library the framework did not start inside the framework's execution wrapper, give each request and job its own objects, treat process-wide state as read-only, and let only top-level processes take global wait-for-everyone locks.

**Why:** The wrapper runs hooks before and after: it marks safe points for reloading, enables per-unit query caches, returns borrowed connections and bounds cache lifetime, and always completes in a finally block. A child that triggers a global reload while its parent waits inside the same scope deadlocks.

**Do:**
```
runner script.file: boot(); executor.wrap { run(script) }       # same wrapper as a request
runner --skip-executor long_running.file                        # explicit opt-out
new thread: executor.wrap { work }                              # cleanup even on error
server loop: reloader.wrap { handle(request) }; child task: executor.wrap, never reloader
handler = new Handler(request)        # per request; global config read-only after boot
```

**Don't:** Spawn threads that borrow pooled connections and never return them, stash request data in globals or class-level variables, or take an exclusive lock from a worker whose parent holds a shared one.

**Break it when:** A long-running worker holds a wrapper open for hours (wrap each unit of work instead), or the thread never touches managed resources.

**Source:** Guides: https://guides.rubyonrails.org/threading_and_code_execution.html (The Rails Executor, Wrapping Application Code, The Reloader, Automatic Concurrency in Rails); https://guides.rubyonrails.org/command_line.html (bin/rails runner); https://guides.rubyonrails.org/caching_with_rails.html (Caching in Background Jobs and Other Non-Request Contexts). Code: activesupport/lib/active_support/execution_wrapper.rb:95-109; railties/lib/rails/commands/runner/runner_command.rb:10,35-48; activerecord/lib/active_record/railtie.rb:317-319.
