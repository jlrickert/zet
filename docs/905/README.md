# Trick: type safe error handling with error maps

## Base implementation

```ts
type Result<T, E> = { ok: true; value: T } | { ok: false; Error: T };

type MyErr<Code, Context> = {
  code: Code;
  cause?: string;
  context: Context;
  stack?: string;
  error?: unknown;
};

type ErrMap<Map> = {
  [Code in MapKey<Map>]: MyErr<Code, Map[Code]>;
};

export const make: {
  <E extends MyErr<any, any, any>>(params: Omit<E, "name">, options?: MakeErrOptions): E;
  <Code extends string, Context>(
    params: Omit<MyErr<Code, Context>, "name">,
    options?: MakeErrOptions,
  ): BaseErr<Scope, Code, Context>;
} = <Code extends string, Context>(
  { code, context, error, cause, stack }: Omit<MyErr<Scope, Code, Context>, "name">,
  options?: MakeErrOptions,
): BaseErr<Scope, Code, Context> => {
  const o: any = {
    name: `@${scope}/${code}`,
    scope,
    code,
    context,
  };
  if (cause) {
    o["cause"] = cause;
  }
  if (error) {
    o["error"] = error;
  }
  const trace = stack ? stack : options?.stackTrace ? new Error().stack : undefined;
  if (trace) {
    o["stack"] = trace;
  }
  return o;
};
```
