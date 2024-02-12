# Tools needed to setup a npm library for typescript

## Domain model

- package.json

  Specifies how files should be exported. Key properties include: `exports`, `type`, `sideEffects`, `main`, `module`, and `types`.

- Module Formats

  A JavaScript module may be in several different formats. The current formats are UMD, ESM, and CommonJS.

- UMD

- ESM

  Newer format that is what the industry is headed towards.

- CommonJS

  Old school node imports. This is importing using the require function.