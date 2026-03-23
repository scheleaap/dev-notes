# DuckDB

```sh
duckdb_version="1.2.1"
cd "$(mktemp -d)"
curl -Ls "https://github.com/duckdb/duckdb/releases/download/v${duckdb_version}/duckdb_cli-linux-amd64.zip" -o duckdb.zip
unzip "duckdb.zip"
chmod +x ./duckdb
mkdir -p "$HOME/bin"
cp ./duckdb "$HOME/bin/duckdb"
```
