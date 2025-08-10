# Prompt: "Linkify" KEG notes

"Linkify" refers to the process of adding hyperlinks to specific keywords, phrases, or phrases in a text, connecting them to relevant documents, websites, or other resources within a system like your [KEG](../646). This enhances the text by providing instant access to more detailed information or related content, facilitating easy navigation and improved information retrieval from your KEG repository.

What "linkify" means

- To add hyperlinks to keywords or phrases in a note so readers can jump to related notes, documents, or external resources.
- This makes navigation and information retrieval faster inside your KEG.

Quick rules

- Use internal links for notes in the same KEG (e.g., ../123).
- Use the keg: protocol for links to notes in other KEGs (e.g., keg:js-resources/250).
- For external websites, prefer reference-style links to keep the body text clean and make URLs easy to update.

How to linkify — examples

1. Internal link (same KEG)

- Before: We discussed the project details in the Project Specification document.
- After: We discussed the project details in the [Project Specification](../123) document.
  - (Here ../123 is the local note ID.)

2. External KEG link (different KEG)

- Before: For functional programming concepts, see the JavaScript resources in another KEG.
- After: For a deep dive into functional programming, see [Functional JavaScript in Practice](keg:js-resources/250).
  - (Uses the keg: protocol, KEG alias, and note ID.)

3. External website (reference-style)

- Before: For more information, visit the company's homepage.
- After: For more information, visit the [company's homepage][homepage].
- Reference-style URLs (placed at the bottom):
  - [homepage]: https://www.example.com

Why use reference-style links for external URLs

- Keeps the main text uncluttered.
- Makes it easier to update URLs in one place.

Example links (short descriptions)

- [Docker Basics](../16) — spinning up a dev environment with Docker.
- [Neovim IDE Features](../35) — Neovim as an IDE.
- [Sourdough Techniques](../459) — tips for sourdough baking.
- [AWS Services Overview](../391) — summary of AWS services.
- [Bash Scripting Tips](../33) — Bash tricks and techniques.
- [Warcraft Dungeon Guides](../832) — dungeons in The War Within expansion.
- [Python Development Setup](../380) — environment setup for Python projects.
- [React Design Concepts](../516) — design ideas for React Native.
- [Running Event Preparation](../852) — race times and event prep.
- [WordPress Plugin Development](../226) — plugin dev overview.
- [Functional Programming in JavaScript](keg:js-resources/250) — external KEG guide.
- [Advanced CSS Techniques](keg:webdev/45) — external KEG on advanced CSS.
- [Cloud Infrastructure Management](keg:cloud/101) — cloud management strategies (external KEG).
- [Machine Learning Algorithms](keg:ai/89) — ML algorithms and use cases (external KEG).
- [Digital Marketing Strategies](keg:marketing/73) — marketing strategies (external KEG).

Reference-style external resources (examples)

- [js-docs]: https://developer.mozilla.org/docs/Web/JavaScript
- [python-guide]: https://docs.python.org/3/tutorial/
- [css-tricks]: https://css-tricks.com/
- [github-actions]: https://docs.github.com/en/actions
- [digitalocean-tuts]: https://www.digitalocean.com/community/tutorials

Short checklist before saving a note

- Is the target note internal or in another KEG? Use ../ID for internal, keg:alias/ID for external KEGs.
- For websites, add reference-style links at the bottom.
- Keep link text descriptive (not just raw URLs or generic words like “click here”).