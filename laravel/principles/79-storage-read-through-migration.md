# Read-through storage migration

**Rule:** To move files to a new storage backend without downtime, read from the new one first and fall back to the old one, copy hits across, send writes to the new one only, and delete from both.

**Why:** Files migrate as they are used, so no cut-over job or maintenance window is needed. Deleting from both stops a removed file from reappearing through the fallback. A failed copy to the new store is ignored unless configured to throw.

**Do:**
```
disk assets = read_through(primary = new_store, fallback = old_store)
read(p): if primary.has(p): return primary.read(p)
         data = fallback.read(p); try primary.write(p, data); return data
write(p, d): primary.write(p, d)       delete(p): primary.delete(p); fallback.delete(p)
```

**Don't:** Copying everything in one job and flipping the config at the end.

**Break it when:** Small data that can be copied inside a short window.

**Source:** https://laravel.com/docs/filesystem ; code: src/Illuminate/Filesystem/ReadThroughFilesystemAdapter.php, src/Illuminate/Filesystem/FilesystemManager.php
