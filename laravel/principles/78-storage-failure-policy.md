# Storage failure policy

**Rule:** Treat the behavior on a failed write as a named setting per storage target (throw, report and return false, or silently return false) instead of an unchecked return value.

**Why:** The quiet default returns false and logs nothing, so a failed upload can pass unnoticed. Choosing throw or report makes the failure visible and can differ between the user-photo disk and a thumbnail cache.

**Do:**
```
disk photos:      { throw = true }       # loss is not acceptable
disk thumbnails:  { report = true }      # log it and carry on
write(path, data)  ->  false | raises | logs, per the disk setting
```

**Don't:** Leaving the silent default and never checking the return value.

**Break it when:** Best-effort storage where loss is fine, such as a regenerable cache.

**Source:** https://laravel.com/docs/filesystem ; code: src/Illuminate/Filesystem/FilesystemAdapter.php
