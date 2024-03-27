# Dependency injection using the Reader pattern

In functional programming there is a way to compose together functions that take some dependency as there input to do some calculation. These functions may be implicitly composed using point free style of programming. This is convenient as typically some environment will be needed everywhere.

Here is an example

```ts
type Deps = {
  a: A
  b: B
  c: C
}
const App<T> = Reader<Deps, T>
```

- [ ] TODO: Finish describing the pattern