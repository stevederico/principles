# Secrets are encrypted, layered and rotated

**Rule:** Keep secrets in one encrypted file committed with the code and the key outside version control. Read them through one lookup that checks sources in order, marks each read required or optional, and rotates by adding the new secret as primary while old ones only verify.

**Why:** Moving a secret between sources needs no code change, a missing required value fails at boot, and rotating without a read path for the old key logs everyone out and breaks stored data. A leaked secret kept as fallback still lets an attacker forge items.

**Do:**
```
repo: credentials.enc (committed)   key: env MASTER_KEY or untracked key file, mode 0600
creds.require(db_password)                      # error if no source has it
creds.option(cache_host, default = "host-1")    # environment overrides file
app refuses to boot without the key if configured
build image: DUMMY_SECRET=1 precompile          # real secrets injected at runtime
keys = [old, current]: encrypt with last; decrypt tries each; re-encrypt rows; drop old
verify with [new, old], sign with new; re-sign on read; if old leaked: drop it now
```

**Don't:** Commit the key beside the ciphertext, scatter raw environment reads, bake production keys into an image, regenerate the secret on deploy, or keep an exposed key "for a while".

**Break it when:** A managed secret store already injects and rotates values (keep the file small). Rotating deterministic encryption cannot be silent, and short-lived tokens can simply cut over.

**Source:** Guides: https://guides.rubyonrails.org/command_line.html (bin/rails credentials); https://guides.rubyonrails.org/security.html (Rotating the secret_key_base, Custom Credentials); https://guides.rubyonrails.org/8_2_release_notes.html; https://guides.rubyonrails.org/asset_pipeline.html (Precompiling Assets); https://guides.rubyonrails.org/active_record_encryption.html (Rotating Keys). Code: railties/lib/rails/application.rb:208-244,506-535,595-631; activesupport/lib/active_support/combined_configuration.rb:42-86; activesupport/lib/active_support/messages/rotator.rb:14; activerecord/lib/active_record/encryption/key_provider.rb:20-44; railties/lib/rails/generators/rails/app/templates/Dockerfile.tt:101-104.
