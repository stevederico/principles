# Treat remote calls as remote: failures are ambiguous and round trips are costly

**Rule:** Design network interactions assuming a failed send may still have been processed, make operations idempotent or carry request identifiers, keep call signatures to few simple types, count every round trip, and make the capability list and call trace inspectable.

**Why:** Unlike local input and output, a network error does not prove non-delivery, so retries need safety. Making a remote call look local hides that each one can swamp parse cost, and rich type signatures invite version skew, ontology creep and mismatches that are hard to monitor. Text-protocol overhead is linear and marginal.

**Do:**
```
request = { id: unique, verb, simple_fields }
server: if seen(request.id): return(previous_result) else: process()
budget(round_trips_per_user_action); batch where possible
```

**Don't:** Generate stubs that hide the network, or retry blindly a non-idempotent request.

**Break it when:** The domain naturally has few simple types, or you control both ends and tooling exists to inspect calls.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Sockets) ; http://www.catb.org/esr/writings/taoup/html/ch07s03.html (Remote Procedure Calls) ; http://www.catb.org/esr/writings/taoup/html/ch05s04.html (XML-RPC, SOAP, and Jabber). Book only.
