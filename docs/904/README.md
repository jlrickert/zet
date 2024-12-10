# Trick to prevent page reloading for debugging

Ran into a problem where I needed to see a console log in the browser inspector. However, the page was navigating away.

Add the following to the console.

```js
window.onbeforeunload = function () {
  return "";
};
```
