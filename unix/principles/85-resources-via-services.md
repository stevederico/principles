# Reach system resources through the service that owns them, not hard-coded paths

**Rule:** Ask the owning service interface for mail delivery, logging or similar facilities instead of opening its files directly, read locations from configuration or follow a published layout standard, and probe for a path only when no service exists.

**Why:** Function and protocol interfaces are better standardized than file locations, and calling the owner gets locking right. After source-level compatibility was solved, shipped programs still broke because administrative files and logs kept moving.

**Do:**
```
send_mail(message) via transport_agent       # not: append to a spool file
log(event) via logging_service               # not: open a log path
else: path = detect_at_startup() or read(config)
```

**Don't:** Hard-code a path that differs between systems, or reach into another subsystem's files.

**Break it when:** You control the entire deployment target, or no service interface exists.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch17s05.html (Avoiding System Dependencies) ; http://www.catb.org/esr/writings/taoup/html/ch17s02.html (Unix Standards in the Open-Source World). Book only.
