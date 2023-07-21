# How to convert json typescript schema


```JavaScript
# script.mjs
import { writeFileSync} from 'fs';
import { compile, compileFromFile } from 'json-schema-to-typescript';

// compile from file
compileFromFile('.json')
  .then(ts => fs.writeFileSync('foo.d.ts', ts))
```

```bash
curl -O git diff src/blocks/accordion/block.json blockSchema.json
node script.mjs
```

    tags: #bash
