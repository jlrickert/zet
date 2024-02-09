# Research on Webpack's plugin architecture

Webpack allows creating plugins through defining an apply method that has a context that the plugin may manipulate.

Here is an example plugin:

```js
class MyExampleWebpackPlugin {
  // Define `apply` as its prototype method which is supplied with compiler as its argument
  apply(compiler) {
    // Specify the event hook to attach to
    compiler.hooks.emit.tapAsync(
      "MyExampleWebpackPlugin",
      (compilation, callback) => {
        console.log("This is an example plugin!");
        console.log(
          "Here’s the `compilation` object which represents a single build of assets:",
          compilation,
        );

        // Manipulate the build using the plugin API provided by webpack
        compilation.addModule(/* ... */);

        callback();
      },
    );
  }
}
```

Here the apply is a function that takes a compiler. The compiler is the context. This may be simplified to a basic function.

```js
const plugin = (args: MyPlugin): Plugin => {
  // load state here
  return (ctx: Context) => {
    ctx.hooks.emit.tapAsync((compilation, callback) => {
    })
  }
};
```

## See also

- https://webpack.js.org/contribute/writing-a-plugin/
