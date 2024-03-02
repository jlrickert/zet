# Stateful command tree using commander js

So far here is what I found works

```ts
import { Command } from "commander";

/**
 * Create a keg command. This add
 */
const KegCommand = (name: string): Command => {
  return new Command(name)
    .passThroughOptions()
    .option("-g, --globalflag <kegpath>", "Example option");
};

export const rootCli = new Command("knut")
  .version(version)
  .enablePositionalOptions();

export const searchCli = KegCommand("search")
  .argument("<query>")
  .action((x) => {
    console.log(`Running search ${x}`);
  });
// Add a search subcommand to the root
knutCli.addCommand(searchCli);

// Run the program
knutCli.parse(process.argv);
```

## See also

- https://github.com/rwxrob/bonzai