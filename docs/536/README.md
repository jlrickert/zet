# Tips for adding TypeScript to legacy JavaScript code bases

To enable TypeScript to check JavaScript files it is as simple as adding a `tsconfig.json` with checking JavaScript enabled.

Here is an example minimal configuration:

```jsonc
{
  "$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "allowJs": true,
    "checkJs": true,
    "lib": ["es2015", "dom"],
  },
}
```

`allowJs` and `checkJs` are the heavy hitters here.

Sometimes JavaScript scripts are included in the browser where some variables are include (no to be confused with JavaScript modules) variables globally. This could be things like jQuery or some generated script by PHP that you would like to add typing to. My typical approach is to create a `global.d.ts` (name can be anything as long as it has a `.d.ts`suffix). Lets say some top level variables are declared. Here is an example:

```ts
declare const VariableA: boolean;
declare const VariableB: string;
```

The `global.d.ts` needs to be added to the `includes` list in `tsconfig.json` file
