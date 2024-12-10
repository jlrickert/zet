# Migrating from pnpm to deno

For [knut](../609) I did an experiment to see how well deno 2.0 works. Previously I have done an [experiment](../599) to see how to run the knutjs core library in a script to do some one off thing.

Some problems I ran into include:

- Type issues

  - Issue with the `fp-ts/HKT` types

    Ended up in lining the contents found in node modules

  - Issues with `mdast` types

    Ended up in lining the contents found in node modules

    See <https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/mdast/v3/index.d.ts> for the types. This seems to be slightly different though

- Package imports

Imports are finicky on other packages on the mono repo:
