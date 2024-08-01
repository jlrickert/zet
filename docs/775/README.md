# Technique for aborting `fetch` in progress

```ts
useEffect(() => {
  const abortController = new AbortController();

  const fetchData = async () => {
    dispatch(requestStarted());

    try {
      fetch(url, { signal: abortController.signal });

      dispatch(requestSuccessful({ data }));
    } catch (e) {
      dispatch(requestFailed({ data }));
    }
  };
  fetchData();

  return () => {
    abortController.abort();
  };
});
```
