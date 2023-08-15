# The idea of cognitive distance

While reading and [article] about why to use tailwind the idea of **cognitive distance** came up. This is something I kind of knew about but I didn't have a name for it. It is when information relevant to the context is not available. For example, when changing global variables you need to consider what else is being affected. Mutable global state has high cognitive distance.

Things to think about:

- Test things that have a high cognitive distance
- Document things that have a high cognitive distance
- Forcing code to be dry may cause high cognitive distance
- Forcing separation of concerns may cause high cognitive distance

Overall cognitive distance should be eliminated if possible.

[article]: https://www.swyx.io/why-tailwind
[colocation]: https://kentcdodds.com/blog/colocation
