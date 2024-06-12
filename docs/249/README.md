# How to convert JSON typescript schema

```JavaScript
# script.mjs
import { writeFileSync} from 'fs';
import { compile, compileFromFile } from 'json-schema-to-typescript';

// compile from file
compileFromFile('block.json')
  .then(ts => writeFileSync('blockSchema.d.ts', ts))
```

```bash
npm install --save-dev json-schema-to-typescript
curl -fsSL -O https://raw.githubusercontent.com/WordPress/gutenberg/trunk/schemas/json/block.json
node script.mjs
```
