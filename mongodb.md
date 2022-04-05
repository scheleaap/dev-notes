View all operations that have been running for at least 5 seconds:
`db.currentOp().inprog.forEach( function(op) { if(op.secs_running > 5) printjson(op); } )`

Count distinct values:
* For for small result sizes: `db.getCollection("my-collection").distinct("foo.bar.id")`
* Otherwise:
    ```js
    db.getCollection("label-added").aggregate([
    { $group : { _id : "$label.transactionId" } },
    { $group: { _id: null, n: { $sum: 1 } } }
    ])
    ```

Aggregation pipeline:
```js
db.getCollection("transaction-version-created").aggregate([
    {
        "$match": {
            "tx.id": "970888081"
        }
    },
    {
        "$project": {
            "transactionId": "$tx.id",
            "transactionVersion": "$tx.version",
        }
    }
])
```

Get database size:
```js
db.stats(1073741824)
// or:
db.runCommand({
   dbStats: 1,
   scale: 1073741824 // GB
})
```

List all indexes in all collections in all databases:
```js
db = db.getSiblingDB("admin");
dbs = db.runCommand({ "listDatabases": 1 }).databases;
dbs.forEach(function(database) {
    db = db.getSiblingDB(database.name);
    colNames = db.getCollectionNames();
    colNames.forEach(function(colName) {
        col = db.getCollection(colName)
        ixs = col.getIndexes();
        ixs.forEach(function(ix) {
            print(ix.ns + "." + ix.name)
        })
    });
});
```

Iterate over all databases and all collections ([source](https://stackoverflow.com/a/29611157/13314015)):
```js
// Switch to admin database and get list of databases.
db = db.getSiblingDB("admin");
databaseInfos = db.runCommand({ "listDatabases": 1 }).databases;

// Iterate through each database and get its collections.
databaseInfos.forEach(function(databaseInfo) {
    db = db.getSiblingDB(databaseInfo.name);
    colNames = db.getCollectionNames();
    colNames.forEach(function(colName) {
        // Do something with each collection.
        print(colName);
        col = db.getCollection(colName)
    });
});
```
