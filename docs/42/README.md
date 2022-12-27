# How to update fields using mongosh

To update a value in mongo `$set` is used.

Here is an example from the [docs]:

```mongosh
db.inventory.updateOne(
   { item: "paper" },
   {
     $set: { "size.uom": "cm", status: "P" },
     $currentDate: { lastModified: true }
   }
)
```

[docs]: https://www.mongodb.com/docs/manual/tutorial/update-documents/#update-documents-in-a-collection
