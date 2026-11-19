# Links from names

**Rule:** Name routes and build every link, redirect and URL from the name plus parameters, and for public one-click actions and private files, sign the URL and give it an expiry.

**Why:** Callers stop depending on path shape; extra parameters become the query string and objects supply their own key. The signature covers only path and query, and body fields override the query in merged input, so read signed values from the query alone. Signing uses a keyed hash with constant-time compare and accepts any key in a rotation list. Verification links also bind to the address, so changing the email kills old links.

**Do:**
```
url = route("post.show", {post: post, search: "rocket"})
link = signed_route("unsubscribe", {user: 1}, expires = 30 minutes)
handler: if not valid_signature(request): deny ; id = request.query("user")
file_link = temporary_url(file, expires = 5 minutes)       # app stays out of the data path
verify_link = signed_route("verify", {id, hash: sha1(email)}, expires = 60 minutes)
```

**Don't:** Concatenating "/posts/" + id, trusting a plain id in an emailed link, or reading a signed value from merged input.

**Break it when:** Third-party URLs, or a path deliberately fixed forever. A signed link alone is not enough for password changes or payments.

**Source:** https://laravel.com/docs/urls, https://laravel.com/docs/routing, https://laravel.com/docs/verification, https://laravel.com/docs/filesystem ; code: src/Illuminate/Routing/UrlGenerator.php, src/Illuminate/Auth/Notifications/VerifyEmail.php, src/Illuminate/Foundation/Auth/EmailVerificationRequest.php
