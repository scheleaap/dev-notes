---
name: snowflake-query
description: How to query Snowflake. Use whenever you need to read data from Snowflake.
user-invocable: false
---

When querying Snowflake, always use the Snowflake CLI:

```
snow sql --connection de --format json --query "<query here>"
```

Never use any other method (e.g. Python connectors, JDBC) to read from Snowflake unless explicitly asked. If `snow sql` fails or is insufficient for the task, stop and ask the user how to proceed rather than switching to an alternative method on your own.
