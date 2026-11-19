# Change a stored format in two steps

**Rule:** To change a serialization, signing, hashing, encryption or cache format, first ship readers that accept old and new while writers still emit old. Next ship writers that emit new, publish an event whenever the old reader is used, and remove the old reader when the count reaches zero.

**Why:** In a rolling deploy, servers not yet upgraded must read what upgraded servers wrote. Users never have to lose sessions, links or cache, and the event count tells you when the old format is safe to drop.

**Do:**
```
deploy 1: reader understands v1 and v2; writer stays v1
deploy 2: writer switches to v2
load(blob): fmt = detect(blob)
  new -> decode;  old_allowed -> publish "fallback_used"(fmt); decode old;  else reject
encryption: read plaintext or old scheme, write new -> rewrite rows -> turn the fallback off
```

**Don't:** Switch the write format in the same release as the reader, keep the unsafe native-object reader forever, or keep the plaintext fallback on after migration (it silently accepts unencrypted data).

**Break it when:** Values are short-lived (minutes), the store is flushed during deploy, or all instances switch atomically.

**Source:** Guides: https://guides.rubyonrails.org/configuring.html (message_serializer, use_legacy_signed_id_verifier, cache_format_version, cookies_rotations); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Rails 7.0 to 7.1 cache serialization, Rails 8.1 to 8.2 marshalling); https://guides.rubyonrails.org/active_record_encryption.html (Migrating Existing Data). Code: activesupport/lib/active_support/messages/serializer_with_fallback.rb:17-30; activerecord/lib/active_record/encryption/config.rb:53,64; activerecord/lib/active_record/encryption/encrypted_attribute_type.rb:56-110.
