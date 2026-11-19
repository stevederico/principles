# Uploads

**Rule:** Save an uploaded file under a server-generated name with an extension guessed from its contents, keep the user's original name as separate display data, validate the type from the bytes, cap size, and refuse script-capable formats by default.

**Why:** A client-chosen name allows overwrite and path tricks, and a file starting with image magic bytes can still carry a script payload. Extension rules alone are unsafe, SVG carries XSS risk, and web-served storage must not execute code.

**Do:**
```
path = upload.store("images", disk = "s3")           # random name plus guessed extension
db.save(path = path, display_name = upload.original_name)
rule: file.types(["mp3", "wav"]).max(10mb)           # sniffed from content
rule: image.dimensions(max_width = 1000)             # svg off unless explicitly allowed
upload directory: no code execution
```

**Don't:** Writing to a path built from the client's filename, or trusting its extension or MIME header.

**Break it when:** Users must get their original filename back (store it as metadata). SVG is required: sanitize it and serve with a restrictive content policy.

**Source:** https://laravel.com/docs/requests, https://laravel.com/docs/filesystem, https://laravel.com/docs/validation ; code: src/Illuminate/Http/FileHelpers.php, src/Illuminate/Http/UploadedFile.php
