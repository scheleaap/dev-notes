# PostgreSQL

Run `psql` client:
```sh
docker run -it --rm --network host postgres:13.1-alpine psql --host localhost --port 5432 --dbname dwh_db --username readonly
```

Command | Description
--- | ---
`\list` or `\l` | Show all databases
`\connect` or `\c` | Switch to a database
`\dt` | Show all tables
