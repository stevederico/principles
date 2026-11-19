# Send the client only the fields it needs

**Rule:** Treat everything that crosses to the browser (props, mutation return values, loader output embedded in the page) as public, and project it to the minimum before sending; mark sensitive objects as tainted only as a second line of defense.

**Why:** Props and return values are serialized into the response, and loader output is embedded in the page for hydration. Whole database rows carry hashes and contact data. Taint tracking works by reference, so copies and derived strings escape it.

**Do:**
```
update_profile(input):
  row = write(...)
  return { ok: true, name: row.name }        # never the raw record
taint(secret_object)                         # backup only
```

**Don't:** Return a full user record because the page shows only the name, or rely on tainting instead of shaping the data.

**Break it when:** The UI needs the full public entity; map it to a public shape first.

**Source:** https://nextjs.org/docs/app/guides/data-security, https://nextjs.org/docs/app/guides/server-actions, https://nextjs.org/docs/pages/building-your-application/data-fetching/get-static-props, https://nextjs.org/docs/app/api-reference/config/next-config-js/taint; docs only
