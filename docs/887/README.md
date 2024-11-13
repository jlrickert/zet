# Details of how my **KEG** is setup

My **KEG** is personal knowledge management and collaborative information sharing tool. It is a set of numbered nodes that contain a README.md file that contains Github flavored markdown.

1. Node Structure:

   - Each node is represented by a README.md file.
   - The file uses GitHub-flavored markdown for formatting.
   - The title is placed on the first line.
   - The first paragraph contains a synopsis of the node's content.

2. Interlinking:

   - Nodes may link to other nodes, providing context and creating a network.
   - Nodes may link to other nodes in a different keg. These are in the form of `keg:alias/234` where `keg` is the protocol, `alias` is the name of the keg, and `234` is the node number.

3. Node Types:
   - Entity: Represents a discrete piece of information such as an article, event, or meeting.
   - Log: Describes actions or activities done in relation to an entity. Logs are specific and help in pattern identification over time.
4. Purpose:
   - The primary goal is personal information capture and recall.
   - The secondary goal is sharing information with others.
5. Benefits:
   - Helps in identifying patterns through logs.
   - Facilitates the discovery of forgotten or related information by navigating through interlinked nodes.

An additional pattern for that I do for Entity node types is place a node type at the beginning of a title. For example, I will prefix the title with something like `Meeting:` to signify that it is a meeting entity type. This gives me a way to sort through all the nodes that I have. I can then find all of the logs by looking for nodes that link back to it.
