# Prompt: Details of how my **KEG** is setup

My **KEG** is personal knowledge management and collaborative information sharing tool. It is a set of numbered nodes (I sometimes call them notes) that contain a README.md file that contains Github flavored markdown. Nodes may also contain a meta.yaml file that will typically contain tags.

1. Node Structure:

   - Each node is represented by a README.md file.
   - The file uses GitHub-flavored markdown for formatting.
   - The title is placed on the first line.
   - The first paragraph contains a synopsis of the node's content. Typically, tells what the node is about and how its associated to other nodes within the keg.

2. Interlinking:

   - Nodes may link to other nodes, providing context and creating a network.
   - Nodes may link to other nodes in a different keg. These are in the form of `keg:alias/234` where `keg` is the protocol, `alias` is the name of the keg, and `234` is the node id. For KEG nodes that reside in this KEG `../234` should be used where 234 is the node id.

3. Node Types:

   - Entity: Represents a discrete piece of information such as an article, event, or meeting.
   - Log: Describes actions or activities done in relation to an entity. Logs are specific and help in pattern identification over time.

   Here is an incomplete list of entities:

   1. Issue: - Bug or Issue Description
   2. Project: - Project Descriptions
   3. Place: - Locations or Events
   4. Person: - Notable Individuals
   5. Recipe: - Cooking or Food-related Entries
   6. Event: - Specific Events or Occasions
   7. Meeting: - An event that is business meeting
   8. SPEC: - Specifications or Detailed Descriptions
   9. Article: - Articles or Reading Material
   10. Software: - Software-related Information
   11. Hardware: - Hardware or physical thing that I own

4. Indexes:

   - Index are maintained in the `dex` directory.
   - Indexes are generated from the content of nodes
   - There is a `dex/nodes.tsv` file that contains in tsv format the node id, last update time, and its title where its context or sorted from lowest to highest id number
   - There is a `dex/changes.md` file that contains an alternative to `dex/nodes.tsv` in markdown format sorted by most recently updated at the top
   - There is a `dex/tags` file that contains an index that maps a tag to a list of nodes
   - Additional indexes may be generated

5. Purpose:

   - The primary goal is personal information capture and recall.
   - The secondary goal is sharing information with others.

6. Benefits:

   - Helps in identifying patterns through logs.
   - A powerful tool for prompt engineering. Able to feed nodes and there links to an LLM to provide additional context for chat bots
   - Facilitates the discovery of forgotten or related information by navigating through interlinked nodes.