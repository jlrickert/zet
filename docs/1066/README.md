# Example search output for my KEG

- Each line is **max 80 characters wide**, including padding.
- Columns:

  - **ID:** KEG node number, right-padded to 5 chars for alignment.
  - **Title:** Node title, truncated if too long to keep line width.
  - **Tags:** A short list of main tags or categories (kept brief).
  - **Link:** Short relative path/link, e.g., `keg:example/123` to node source.

- Header and footer lines with dashes visually separate the search output.
- A short footer reminds user how to view the full note with a simple command.
- A summary should be given about the search results
- By default do 10 results
- The top result should be on the bottom

Here is an example output for a search:

```text
**Summary:**

This search result displays five entries related to "Asana Task," including completed tasks and project updates. The entries cover various topics such as project updates, compliance module commits, task reviews, and marketing project prompts. Each entry is linked to a specific note ID for further reference.

--------------------------------------------------------------------------------
Search Results for query: "Asana Task"
-------------------------------------------------------------------------------
ID    | Title                                                   | Link
-------------------------------------------------------------------------------
0045  | [x] Project Alpha Update | improved search and speedup   | keg:abc/45
0361  | Compliance Module git commit                             | keg:abc/361
0911  | [x] Task Review | Beta Corp - February Dev Timeline      | keg:abc/911
1314  | Prompt: Drafting a marketing project note                | keg:abc/1314
1350  | [x] Task Complete | Delta Rider - Q3 2025                | keg:abc/1350
1420  | [ ] New Feature Planning | Q4 Roadmap                    | keg:abc/1420
1475  | [x] Bug Fixes and Improvements | Sprint 12               | keg:abc/1475
1502  | [ ] Client Feedback Summary | March 2025                 | keg:abc/1502
1580  | [x] Team Retrospective Notes | April 2025                | keg:abc/1580
1623  | [ ] Resource Allocation | Project Phoenix                | keg:abc/1623
-------------------------------------------------------------------------------
Found 10 results. Use "zet abc cat <ID>" to view note content.
-------------------------------------------------------------------------------
```
