# Zet schemas idea based on structured data

I started doing a pattern that is similar to what [rwxrob](../628) has been doing where he prefixes the title with something. For example a note about a youtube video will have a 📺 emoji. This specifies the type of not it has. This looks similar to what <schema.org> specifies. Structured google data also follows close to <schema.org> but is a subtype.

Some issues that I run into is coming up with a good schema type that doesn't conflict with other tags. Do I need to make something other than just `tags` in `meta.yaml`

Schema that I tend to use

- Project:

  Something that may never be finished that can constantly be working on. Typically, many things will link to this.

- Place:

  An entity that has a physical location

- Hardware:

  Specific items that I own

- Time log:

  Log of when I do things for something

- Meeting:

  An event (event subtype) that represents a business meeting

- Event:

  A thing that happens at a specified date

- [ ] XYZ Task:

  A tasklog (another subtyp) where I document when I worked on a project (XYZ is the project) and the type of issues that I ran into.

- Issue:

  A problem that may have multiple solutions
