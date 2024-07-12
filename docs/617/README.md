# How I organize my notes

I use a [zettelkasten](../623) for taking notes. The whole goal of my notes is to have a place to dump information for later recall. This needs to be quick and efficient. Should be [normalized](../624) within reason.

## Node content

Github flavored markdown for now. This is what prettier supports currently.

## Custom indexes

nodes.tsv and changes.md are currently auto generated. Everything else is manually entered in.  At some point I plan on adding a few more such as ones around tags.

## Node titles

Most nodes will have a prefix in the title. Each prefix specifies the type of noun. Here are the ones that I typically use:

- `Baking:` This is a specific kind of recipe related to baking
- `Client:`: A particular client that I do business with
- `Daily:`: A daily entry for a particular day
- `Hardware:` A physical piece of hardware that I own. There may be a time that I reference hardware that I don't own. Not sure if it is useful to differentiate between the 2.
- `Ingredient:` An ingredient to use in a recipe
- `Issue:`: A problem. Typically, this will have some possible solutions to it detailed.
- `Meeting:` A meeting that I had. Typically, this will have
- `Overview:` A entry point for an idea. Typically, this is the top of a hierarchy of nodes. Also known as a hub.
- `Person:`: A note about a physical unique person
- `Project:` A particular project that I am working on
- `Recipe:` A cooking recipe
- `Research:`Typically, this is a dump of information to figure something out. I often do this when I am shopping for something.
- `[ ] XYZ Task |`: This one has unique as it has a check box to indicate if it is done. This is something that can objectively be completed. XYZ is optional. Typically, it will be the name of a project. Often times I will link to a bunch of issues.

I got the idea form [google structured data](../620). This is a way to add context to a specific thing to remove ambiguity.

If it doesn't have a prefix it is just some random chunk of data that I wanted to capture and I have no idea where it fits.

I find this helpful for a bunch of reasons:

- Finding a particular node

  I will often times want to link to a node. I will put a word in a bracket and hit `space s w`. This will open a telescope window in neovim that I can further narrow down based on the prefix. I link between these quite often. These produce back links. If I want to find nodes related to the noun I can simply grep the node id.

- Provide a sort of index because I am too lazy to maintain an index in the `dex` folder.

I also find that I can use this a form of indexing in `changes.md` file for finding the thing that I want.

### Baking

### Recipe

### Task

A task is something that can objectively be completed. Typically, It will be a task for a noun.

Tags:

- task (required)
- PROJECT_NAME

## Retrospect

- Entity, noun, thing, ... What would the proper word be?
- Is research a noun?

## See also

- [Other note taking structures](../618)