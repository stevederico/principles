# Let the client revalidate

**Rule:** For a read whose version is known cheaply, send a validator (version tag or last-changed time) with the response and answer a matching request with an empty not-modified reply.

**Why:** The client sends its tag and time, the server compares, and a bodyless 304 saves rendering and transfer. The framework marks responses private by default so shared caches do not store them.

**Do:**
```
show(id):
  item = load(id)
  if request.fresh_for(etag = item.version, last_modified = item.updated_at): return 304
  render(item)
weak tags by default; strong tags for byte-exact needs such as range requests
```

**Don't:** Re-render a page whose data did not change, mark per-user pages public, or cache a response "forever" unless the URL changes when content does.

**Break it when:** The response varies by more than the record (the current user's name in the header): include those inputs in the tag, or skip it. Loading the record is already the dominant cost.

**Source:** Guides: https://guides.rubyonrails.org/caching_with_rails.html (Conditional GETs, Strong vs. Weak ETags); https://guides.rubyonrails.org/2_2_release_notes.html (Better integration with HTTP). Code: actionpack/lib/action_controller/metal/conditional_get.rb:135,234,242-288.
