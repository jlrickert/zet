# How to sort an array with -1, 0, and 1 sort function

I never seem to remember how to sort in ascending or descending order when sorting items

Here are some example implementations:

```ts
const assending = (a: number, b: number) => a - b;
const descending = (a: number, b: number) => b - a;
const nodes = [4, 1, 3, 5, 2, 6]
const nodes.sort(assending) // [1, 2,3, 4, 5, 6]
const nodes.sort(descending) // [6, 5, 4, 3, 2, 1]
```