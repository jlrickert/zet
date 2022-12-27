# How to do complex filtering with mongosh

Example of how to find documents with a missing key

```mongosh
db.yourCollection.find({
    "xyz": {
        "$exist": false
    }
})
```

For more information see [docs] about read operations.

[docs]: https://www.mongodb.com/docs/mongodb-shell/crud/read/
