# Add type checking to babel configuration

This is what I found to work. The types aren't great but it is better than nothing. Also need to install a types package.

```sh
npm i -D @types/babel__core
pnpm add -D @types/babel__core
yarn add -D @types/babel__core
```

Simple template:

```cjs
/** @type {import("@babel/core").ConfigFunction} */
module.exports = function (api) {
  // @ts-ignore
  api.cache(true);
};
```
