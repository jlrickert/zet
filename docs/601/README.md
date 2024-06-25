# Covariance and contravariance in TypeScript

Ran into something interesting while going over <https://github.com/Effect-TS/effect/blob/main/packages/effect/src/Either.ts>.

```ts
export interface Left<out L, out R> extends Pipeable, Inspectable {
  readonly _tag: "Left";
  readonly _op: "Left";
  readonly left: L;
  readonly [TypeId]: {
    readonly _R: Covariant<R>;
    readonly _L: Covariant<L>;
  };
  [Unify.typeSymbol]?: unknown;
  [Unify.unifySymbol]?: EitherUnify<this>;
  [Unify.ignoreSymbol]?: EitherUnifyIgnore;
}
```

It has an extra keyword `out`. Turns out this specifies covariance.

`in` specifies contravariance
