# Middleware pattern with typescript

Here is an example:

```ts
export type Middleware = (context: Context, next: () => void) => void;

const middlewares = [] satisfies Middleware[];

let prevIndex = -1;
let index = 0;
let middleware = middlewares[index] ?? null;
do {
  if (index === prevIndex) {
    throw new Error("Next called multiple times");
  }
  prevIndex = index;

  middleware = middlewares[index] ?? null;
  if (middleware !== null) {
    middleware({ log, wss, req, ws }, () => {
      index++;
    });
  }
} while (middleware);
```

    tags: #typescript #webdev
