# TypeScript auto imports in neovim

To allow auto imports make sure that the file you are working on is included in the _includes_ list in the _tsconfig.json_ file.

Work around for not building include test files within the build:

```json
{
  "extends": "./tsconfig.json",
  "exclude": ["src/**/*.spec.ts", "src/**/*.test.ts"]
}
```