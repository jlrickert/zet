# Multiplayer game with FireBase video

Notes from
[Build a Multiplayer game with JavaScript & Firebase](https://www.youtube.com/watch?v=xhURh2RDzzg)

```js

type Collection<A> {
  id: string
}

impl Collection<A> {
  type id: string
  onChange((value: A) => void): void
  onNewNode((node) => void): void
}

type CollectionItem<A> {
  id: string // unique id
  ref: ObjectRef<A> // Set than can be read and written to by the user
}

impl CollectionItem<A> {
}

type ItemRef<A> {
  set(f: (value: A) => A): void
  get(): A
}
```

## See also
