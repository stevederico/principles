# Presence and format are separate

**Rule:** Declare whether a field is required or may be null as its own rule, and remember that a format or uniqueness rule does not run on an absent or blank value unless that rule is marked as implicit.

**Why:** After empty strings are turned into null, an optional date field fails unless it is declared nullable, and a uniqueness rule is skipped for an empty value. Only a rule marked implicit runs on empty input, and then it alone decides what empty means. Rules run in the listed order, and a bail marker stops at the first failure.

**Do:**
```
publish_at: [nullable, date]              # optional; format only checked when present
name:       [required, unique(users)]      # required decides emptiness; unique skipped if empty
custom rule marked implicit: runs on empty input and defines its own answer
title: [bail, required, unique, max(255)]  # cheap checks first, stop at the first failure
```

**Don't:** Expecting a format or uniqueness rule to reject a blank, or leaving optional fields without a nullable marker after input is normalized.

**Break it when:** A rule that must treat blank as invalid by itself: mark it implicit and define the behavior.

**Source:** https://laravel.com/docs/validation ; code: src/Illuminate/Validation/Validator.php, src/Illuminate/Validation/Rules/Unique.php
