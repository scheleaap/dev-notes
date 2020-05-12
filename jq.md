# JQ examples

```
cat data.json | jq '.details.fields[] | select(.designation=="password").value' --raw-output
```
