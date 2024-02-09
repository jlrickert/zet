# jq cheat sheet

```
jq '.data[] | {id,name,etc}'
jq '.data[] | select(.value > 0.5)'
jq '.data[].status | unique'
```