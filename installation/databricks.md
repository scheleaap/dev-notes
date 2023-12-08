# Databricks CLI

```sh
databricks_version="0.210.2"
cd "$(mktemp -d)"
curl -Ls "https://github.com/databricks/cli/releases/download/v${databricks_version}/databricks_cli_${databricks_version}_linux_amd64.zip" -o databricks.zip
unzip "databricks.zip"
chmod +x ./databricks
cp ./databricks "$HOME/bin/databricks"
```
