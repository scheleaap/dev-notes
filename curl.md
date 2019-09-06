# curl

Examples:
```sh
curl -X POST "http://localhost:8080/" -H "Content-Type:application/json" --data '{ "field": "value" }'

cat data.json | curl -X POST "http://localhost:8080/" -H "Content-Type:application/json" -d @-
cat MT940.txt | curl -X POST "http://localhost:8080/" -H "Content-Type:application/mt940" --data-binary @-
```

What | How
--- | ---
Request method | `-X POST`
Request body | `--data 'bla die bla'`<br> See also the parameters `-d @-` and `-d @<filename>`
Request headers | `-H "Content-Type:application/json"`
Request username/password (basic auth) | `-u username:password`
Response headers | `-I`
