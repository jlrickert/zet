# React performance trick by using batching

The trick is to delay rendering. Learned this from [acorn1010](../59).

TODO figure out how she did this

```ts
class Deleatedtaskrunner {
  queue = new Dequeue() // array dequeue
}
useEffect(() => {
  const cancel = TASK_RUNNER.add(() => setRender(false))
}))
```