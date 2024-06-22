# Issue: running a typescript library in deno

Here is what I am trying to accomplish:

- A TypeScript library up on npmjs
  - This should include `esmodule`, `commonjs`, and `types`.
- It should be importable from Deno
  - Importing is done with `import { helloWorld } from "npm:@jlrickert/knutjs-core@0.5.4";`.
  - The code should then be runnable with `deno run file.ts`.
- Configured in Neovim to have all the LSP featurees
  - This includes autocompletion, jump to definition, etc.

## Example

### Typescript library

An example TypeScript library that called `my-example`.

Directory structure:

```
❯ tree
.
├── index.ts
├── package.json
├── pnpm-lock.yaml
├── tsconfig.json
└── tsup.config.ts
```

`index.ts`:

```ts
export const helloWorld = () => {
  console.log("Hello World");
};
```

`package.json`:

```json
{
  "name": "my-example",
  "version": "0.1.0",
  "types": "./dist/index.d.ts",
  "main": "./dist/index.cjs",
  "module": "./dist/index.js",
  "type": "module",
  "exports": {
    ".": {
      "import": "./dist/index.js",
      "require": "./dist/index.cjs",
      "types": "./dist/index.d.ts"
    }
  },
  "scripts": {
    "build": "tsup"
  },
  "files": ["dist", "package.json"]
}
```

`tsup.config.ts`:

```ts
import { defineConfig, type Options } from "tsup";
import path from "path";

const isProduction = process.env.NODE_ENV === "production";

const commonConfig: Options = {
  banner: {
    // js: "'use client'"
  },
  sourcemap: true,
  format: ["cjs", "esm"],
  minify: isProduction,
  dts: true,
  external: ["react"],
  target: "es2022",
  outDir: "dist",
  tsconfig: path.resolve(__dirname, "./tsconfig.json"),
  skipNodeModulesBundle: true,
  clean: true,
  platform: "neutral",
};

export default defineConfig(() => {
  return [
    {
      entry: ["./src/index.ts"],
      ...commonConfig,
      esbuildOptions: (options) => {
        options.outbase = ".";
      },
    },
  ];
});
```

This then can be published via `npm publish` command. See [publishing](../0) on how to do this

### Deno script

In `example.ts`:

```ts
#!/usr/bin/env deno

import { helloWorld } from "npm:my-example@0.1.0";

helloWorld();
```

To run `example.ts`, execute `deno run example.ts`. To get LSP support in Neovim, run `deno cache example.ts`.

### Explanation of the Approach

1. **Library Setup**:

   - The `index.ts` file contains your TypeScript code.
   - The `package.json` file has entries for `main`, `module`, and `types` to ensure compatibility with different module systems (`commonjs` and `esmodule`).
   - The `tsup.config.ts` file uses `tsup` for compiling TypeScript to JavaScript, generating declarations, and outputting both `cjs` and `esm` formats. This ensures your package works both in Node.js and Deno environments, as well as other platforms.

2. **Publishing**:

   - After setting up these files, you can use `npm publish` to publish your library on npmjs.

3. **Import in Deno**:

   - Deno supports importing npm modules with a special syntax `import { helloWorld } from "npm:my-example@0.1.0";`.

4. **Neovim LSP Setup**:

   - By running `deno cache example.ts`, Deno's Language Server Protocol (LSP) caches the dependency, which provides enhanced editor features like autocompletion and type checking in Neovim.

5. **Useful Resources**:
   - The additional links provided can help users understand type compatibility issues, set up Neovim with Deno’s built-in LSP, and view related configuration files.

### Alternative Approaches

1. **Using `tsc` for Compilation**:

   - Instead of `tsup`, you can configure `tsc` (TypeScript compiler) directly using the `tsconfig.json` file to handle the conversion.

2. **Using Different Bundlers**:

   - Alternatives like `rollup` or `webpack` can be used to bundle your TypeScript library.

3. **Direct Deno Modules**:
   - Instead of using npm and transforming the library for Deno, you can publish your library as a Deno module using `deno.land/x` and bypass npm altogether. This approach would be simpler if Deno is the primary target environment.

Choosing the best approach depends on the specific requirements (such as targeting multiple environments) and developer preferences.

I hope this helps clarify the instructions and improves the overall readability of your document!

## See also

- [Are the types wrong?](https://arethetypeswrong.github.io/)
- [Deno Setup for Neovim](https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server)
- [Configuration source code for denols](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/denols.lua)
