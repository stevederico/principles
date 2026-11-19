# Match test type to what the unit depends on

**Rule:** Use unit or component tests for synchronous, self-contained units, and end-to-end tests for anything whose rendering depends on the server runtime (async data, request APIs), for navigation, and for pending states.

**Why:** Unit runners cannot render async server-rendered components and do not run the router runtime, so mocks of the router prove little. Component tests need no server, so server-dependent features may not work in them.

**Do:**
```
sync, self-contained -> unit or component test
async data, request reads, navigation -> end-to-end in a real browser
```

**Don't:** Mock the router heavily to "test" navigation in a unit test.

**Break it when:** The test runner gains support for the construct.

**Source:** https://nextjs.org/docs/app/guides/testing, https://nextjs.org/docs/app/guides/testing/jest, https://nextjs.org/docs/app/guides/testing/cypress; docs only
