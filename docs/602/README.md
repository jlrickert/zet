# Accessing `package.json` version for a TypeScript cli applicationg

Code Example:

```ts
import { createRequire } from "module";

const require = createRequire(import.meta.url);
const { version } = require("../package.json");
```

## Overview

In Node.js, you can use the `createRequire` function from the module package to dynamically generate a require function for use within ECMAScript modules (ESM). This method is particularly useful for accessing `CommonJS` modules like `package.json` in an ESM context.

### Use Cases

- Hybrid Projects: Ideal for projects transitioning from CommonJS to ESM.
- Compatibility: Maintains compatibility with tools and libraries that expect a require function.
- Simplicity: Provides a straightforward method to access package.json properties without additional dependencies.

## Pros and Cons

### Pros

- ESM Compatibility: Works seamlessly in projects using ECMAScript modules.
- Minimal Overhead: No additional dependencies required.
- Flexibility: Can be easily adapted to access other CommonJS modules.

### Cons

- Limited Scope: Specific to scenarios where ESM is used but CommonJS compatibility is needed.
- Asynchronous Operations: Still synchronous; consider alternatives if non- blocking operations are required.
