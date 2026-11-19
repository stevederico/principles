# Big uploads skip your servers; sweep the leftovers

**Rule:** Let clients send large files straight to storage with a signed grant, choose per case when derived work (thumbnails, metadata) runs, name resources by environment, and purge uploads that never get attached.

**Why:** Routing big files through app servers wastes workers. Direct upload keeps the file when a form fails validation, but abandoned forms leave unreferenced files. Lazy derived work keeps the first render fast; only inline work can feed validations. A bucket named per environment keeps a dev machine away from production.

**Do:**
```
client asks app for a signed upload grant -> uploads to storage -> submits form with blob id
daily job: delete unattached blobs older than 2 days, in batches
variant thumb:  process at first request (default)
variant medium: process in background after save
analysis inline only if you validate on it (direct upload cannot: it falls back to background)
bucket = "myapp-files-" + env
```

**Don't:** Assume every uploaded blob ends up referenced, generate every variant inline, or validate on metadata that is computed later.

**Break it when:** Files are tiny, or you need server-side scanning before storing.

**Source:** Guides: https://guides.rubyonrails.org/active_storage_overview.html (Direct Uploads, Purging Unattached Uploads and detach, Controlling When Analysis is Performed, Image Variants, Define Storage Services); https://guides.rubyonrails.org/action_text_overview.html (Attachment Direct Upload JavaScript Events note). Code: activestorage/app/models/active_storage/blob.rb:53.
