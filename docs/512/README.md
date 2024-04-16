# Basic setup for a React Native app with expo and pnpm monorepo

This is the minimum that I found to work to get both android and the web. It should be noted that I have setup android previously for experimenting with [flutter].

[flutter]: 100
[expo-monorepo-example]: https://github.com/byCedric/expo-monorepo-example/tree/main

Here are the requirements:

- monorepo with pnpm
- testing setup
- build and deployment

Based on the learnings from [expo-monorepo-example]. Here is what I learned from it:

- had to uncomment `config.resolver.disableHierarchicalLookup = true;` in `metro.config.js`. Having this enabled caused
- only supports commonjs

## Development environment

Key files required for a dev environment:

- App.tsx

  ```tsx
  import { StatusBar } from "expo-status-bar";
  import { StyleSheet, Text, View } from "react-native";

  export default function App() {
    return (
      <View style={styles.container}>
        <Text>Open up App.js to start working on your app!</Text>
        <StatusBar style="auto" />
      </View>
    );
  }

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: "#fff",
      alignItems: "center",
      justifyContent: "center",
    },
  });
  ```

- app.json

  ```

  ```

- index.js

  This needs to have .js extension

  ```js
  import { registerRootComponent } from "expo";

  import App from "./App";

  // registerRootComponent calls AppRegistry.registerComponent('main', () =>
  // App); It also ensures that whether you load the app in Expo Go or in a
  // native build, the environment is set up appropriately
  registerRootComponent(App);
  ```

- babel.config.cjs
- metro.config.cjs

  ```cjs
  // Learn more https://docs.expo.dev/guides/monorepos
  const { getDefaultConfig } = require("expo/metro-config");
  const { FileStore } = require("metro-cache");
  const path = require("path");

  const projectRoot = __dirname;
  const workspaceRoot = path.resolve(projectRoot, "../..");

  const config = getDefaultConfig(projectRoot);

  // #1 - Watch all files in the monorepo
  config.watchFolders = [workspaceRoot];

  // #3 - Force resolving nested modules to the folders below
  // config.resolver.disableHierarchicalLookup = true;

  // #2 - Try resolving with project modules first, then workspace modules
  config.resolver.nodeModulesPaths = [
    path.resolve(projectRoot, "node_modules"),
    path.resolve(workspaceRoot, "node_modules"),
  ];

  // Use turborepo to restore the cache when possible
  config.cacheStores = [
    new FileStore({
      root: path.join(projectRoot, "node_modules", ".cache", "metro"),
    }),
  ];

  module.exports = config;
  ```

- tsconfig.json

  ```jsonc
  {
    "$schema": "https://json.schemastore.org/tsconfig",
    "extends": ["expo/tsconfig.base", "@jlrickert/knutjs-tsconfig/base.json"],
    "compilerOptions": {
      "jsx": "react-jsx",
      "module": "Preserve",
      "moduleResolution": "Bundler",
    },
    "exclude": ["./metro.config.cjs"],
  }
  ```

- package.json

  ```jsonc
  {
    "$schema": "https://json.schemastore.org/package.json",
    "main": "index.js",
    "type": "commonjs",
    "scripts": {
      "start": "expo start",
      "android": "expo start --android",
      "ios": "expo start --ios",
      "web": "expo start --web",
      "dev": "pnpm run web",
      "typecheck": "tsc --noEmit",
      "test": "jest",
    },
    "dependencies": {
      "@expo/metro-runtime": "~3.1.3",
      "@jlrickert/knutjs-core": "workspace:*",
      "@jlrickert/knutjs-tsconfig": "workspace:*",
      "expo": "~50.0.14",
      "expo-status-bar": "~1.11.1",
      "fp-ts": "^2.16.4",
      "jest": "^29.3.1",
      "jest-expo": "~50.0.4",
      "metro-cache": "^0.80.7",
      "react": "18.2.0",
      "react-dom": "18.2.0",
      "react-native": "0.73.6",
      "react-native-web": "~0.19.10",
      "zustand": "^4.5.2",
    },
    "devDependencies": {
      "@babel/core": "^7.24.1",
      "@babel/runtime": "^7.24.1",
      "@types/babel__core": "^7.20.5",
      "@types/react": "~18.2.45",
      "typescript": "^5.4.2",
    },
    "private": true,
    "jest": {
      "transformIgnorePatterns": [
        "node_modules/(?!(?:.pnpm/)?((jest-)?react-native|@react-native(-community)?|expo(nent)?|@expo(nent)?/.*|@expo-google-fonts/.*|react-navigation|@react-navigation/.*|@unimodules/.*|unimodules|sentry-expo|native-base|react-native-svg))",
      ],
    },
  }
  ```

- root package.json

  ```jsonc
  {
    "$schema": "https://json.schemastore.org/package.json",
    "type": "module",
    "scripts": {
      "build": "turbo build",
      "clean": "turbo clean",
      "dev": "turbo dev --no-cache --continue",
      "format": "prettier --write .",
      "lint": "turbo lint",
      "test": "turbo test",
      "typecheck": "turbo typecheck",
      "changeset": "changeset",
      "version-packages": "changeset version",
      "release": "turbo build --filter=docs^... && changeset publish",
    },
    "keywords": [],
    "author": "Jared Rickert (jaredrickert52@gmail.com)",
    "license": "Apache-2.0",
    "packageManager": "pnpm@8.8.0",
    "dependencies": {
      "@jlrickert/knutjs-cli": "workspace:*",
    },
    "devDependencies": {
      "@changesets/cli": "^2.27.1",
      "eslint": "^8.57.0",
      "prettier": "^3.0.3",
      "turbo": "^1.12.4",
    },

    // Need to figure out why this is useful
    "pnpm": {
      "peerDependencyRules": {
        "ignoreMissing": ["@babel/*", "expo-modules-*", "typescript"],
      },
    },
  }
  ```

## Testing setup

- https://docs.expo.dev/develop/unit-testing/

```
pnpm add -D jest jest-expo @testing-library/react-native @types/jest
npx expo install jest-expo jest
```

## See also

- [Install flutter on macOSX](100)
- [Flutter experiments](333)