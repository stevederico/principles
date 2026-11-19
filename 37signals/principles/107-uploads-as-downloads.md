# Serve user uploads as downloads unless plainly media, and bound processing

**Rule:** For files served from your own origin, allow only an explicit list of inline-safe types and force everything else to a binary download on read paths; cap decode cost by pixels and time, kill the decoder past a wall-clock limit, and post the file without a preview when processing fails.

**Why:** Browsers accept many spellings of a script type and signed URLs carry the type they were minted with, so refusing a list of bad types cannot cover old links. Decode cost scales with pixel count, not bytes, and video previews ran as long as they liked inside the request.

**Do:**
```
middleware: GET or HEAD under /uploads and type not in {image, video, audio, pdf, octet-stream, text/plain}
            set type = application/octet-stream
accept only real uploaded files in params, never a signed id of an existing blob
if width * height > 250M or unknown: skip preview ; run video previewer with timeout 10 s ; on PreviewError save without preview
```

**Don't:** Trust the stored content type, or fail the whole message because a thumbnail failed.

**Break it when:** Uploads live on a separate cookieless origin, or the preview is the product.

**Source:** https://github.com/basecamp/once-campfire config/initializers/uploaded_script_guard.rb, app/models/message/attachment.rb, lib/rails_ext/time_limited_video_previewer.rb ; https://github.com/basecamp/writebook app/controllers/concerns/uploaded_files.rb.
