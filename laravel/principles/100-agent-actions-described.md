# Describe agent actions

**Rule:** Give every action exposed to an AI agent a human-written description, a typed input schema with per-field descriptions, behavior flags, and error messages that say what to change, and validate on the server too.

**Why:** The model decides when and how to call by reading this metadata, and it acts on error text, so "specify a location, for example Tokyo" beats "location required". The schema states shape; server rules enforce limits.

**Do:**
```
tool current_weather:
  description: "Fetch the current forecast for a place."
  input: {location: string, required, "city name"; units: enum[c, f], default c}
  flags: read_only, idempotent
validate(args, rules_from_schema(tool.schema) + {location: max 100},
         messages = {"units.in": "Use either 'celsius' or 'fahrenheit'."})
```

**Don't:** A derived name with no description, generic validation errors, or trusting that callers obeyed the schema.

**Break it when:** Actions that never reach a model (plain API). Many tools: advertise a few and put the rest in a searchable catalog.

**Source:** https://laravel.com/docs/mcp, https://laravel.com/docs/ai-sdk, https://laravel.com/docs/validation ; code: src/Illuminate/JsonSchema/Types/Type.php, src/Illuminate/JsonSchema/ValidationRules.php
