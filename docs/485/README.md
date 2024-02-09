# Plugin architecture of vscode

A plugin for vscode typically consists of a npm package. The package exports a module that has an activate and an option deactivate top level function.

## Publishing

Authentication is handled by some azure processes

```shell
npm install -g @vscode/vsce
vsce package
vsce publish
```

## Package.json configuration

[documentation] for the Extension Manifest

[documentation]: https://code.visualstudio.com/api/references/extension-manifest

- activationEvents
- capabilities
- contributes

  - configuration

    - commands
    - properties

      Looks like this provides schema for something as it provides type information

- icon

  Can't be an svg for some security reason

## VSCode Api

- Exposes a few things via globals

The exposed interface is as follows

- Contents of package.json
- top level activate function with signature `Extension Context => Promise Unit`
- top level deactivate function with signature `Unit => Promise Unit`
