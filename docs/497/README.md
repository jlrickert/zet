# TypeScript auto imports in neovim

To allow auto imports make sure that the file you are working on is included in the _includes_ list in the _tsconfig.json_ file.

Work around for not building include test files within the build includes using a dedicated _tsconfig_ for building the project for production:

```json
{
  "extends": "./tsconfig.json",
  "exclude": ["src/**/*.spec.ts", "src/**/*.test.ts"]
}
```

Create the file and then point _tsc_ or what every build tool to the that file. Typically, the file would be something like _tsconfig.build.json_.