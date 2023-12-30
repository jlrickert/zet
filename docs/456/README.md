# Bundling and compiling typescript files

There are 4 different types of scenarios that I can thing of. Either running some application in node (a server or script), web application, a library, or a application library hybrid.

List of tools:

- swc and swc-node
- esbuild

  Bundler that compiles typescript down to JavaScript. Allows importing other formats into via import statements.

- vite

  Batteries included front end tool

- tsup
- ts-node

  swc-node might be better in every way but is less stable

## Node based

## Web based

Current recommendation is vite if not using a big framework like NextJS.

## Library based

Current recommendation is tsup

## Application library hybrid

An example of this is @jlrickert/knut-cli. Here I am bundling with tsup and then running with just straight up node.
