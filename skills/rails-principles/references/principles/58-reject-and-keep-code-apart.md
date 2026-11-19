# Reject bad input, and keep code and data apart

**Rule:** Check input against what is allowed and reject on mismatch, never strip suspected bad parts. Pass values as parameters or argument lists, never concatenated into queries, commands or markup. Parse outside data with data-only parsers, and cap the cost of every step that handles it.

**Why:** One-pass removal is beaten by nested input, and block lists are never complete. The same string is harmless in one context and an attack in another. Object-reviving parsers can run code. Binding protects a query's shape but pattern wildcards still act.

**Do:**
```
if filename matches ^[A-Za-z0-9_.-]+$: accept else reject       # never "remove ../"
db.query("name = ? AND qty >= ?", name, qty)
run_process("echo", [text])                       # arguments, not one shell string
data = json.parse(body)                           # data only; cookie serializer = json
pattern: "title LIKE ?", escape_wildcards(text) + "%"
regex timeout 1 s; cookie over 4096 bytes raises; nested values must be scalars
null inside lists canonicalized: [null, null] -> []
```

**Don't:** `value.replace("<script>", "")`, build SQL by concatenation, load native objects from cookies or uploads, or leave limits for each caller to remember.

**Break it when:** A fragment is a literal you wrote: mark it raw knowingly. A trusted batch job may raise a limit locally. Spam filtering cannot enumerate good input.

**Source:** Guides: https://guides.rubyonrails.org/security.html (Permitted Lists Versus Restricted Lists, SQL Injection, Command Line Injection, Regular Expressions, Unsafe Query Generation); https://guides.rubyonrails.org/active_record_querying.html (Conditions That Use LIKE); https://guides.rubyonrails.org/5_2_release_notes.html (raw SQL marked); https://guides.rubyonrails.org/8_0_release_notes.html (Regexp.timeout); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Rails 4.0 to 4.1). Code: activerecord/lib/active_record/sanitization.rb:221-236; activemodel/lib/active_model/validations/format.rb:37-40; actionpack/lib/action_dispatch/http/utils.rb:11-25; actionpack/lib/action_dispatch/middleware/cookies.rb:217,634.
