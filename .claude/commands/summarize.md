Produce a synthesized summary over a subset of the vault.

The scope to summarize is: $ARGUMENTS

## Interpreting the argument

- **Folder name** (e.g., `methods`, `benchmarks`): summarize all pages in `02_Wiki/<folder>/`.
- **Tag** (e.g., `retrieval`, `eval`): summarize all pages whose frontmatter `tags` list includes that tag.
- **Free-text query** (e.g., `hybrid search`, `how to evaluate RAG`): identify the most relevant pages by reading their TL;DR lines and frontmatter, then summarize those.

If no argument is given, ask the user to provide a folder, tag, or question.

## Steps

1. **Identify the relevant page set** using the method above. List the pages you will read.

2. **Read each page in full** (or up to the `## Sources` section if very long).

3. **Synthesize** — write a structured summary that:
   - Opens with a one-paragraph overview of the topic.
   - Covers the key ideas, organized thematically (not page by page).
   - Highlights agreements, tensions, and open questions across pages.
   - Every non-trivial claim ends with `[[Page Name]]` citing which wiki page it comes from.
   - Closes with a "Further reading" list of the pages consulted, in order of relevance.

4. **Format rules**:
   - Use `##` headings for themes.
   - Do not reproduce large blocks of text verbatim; synthesize in your own words.
   - Mark gaps with `> [!todo] No wiki page yet covers X` when the query reveals a missing entity.

5. Output the summary directly in the conversation. Do **not** write it to a file unless the user asks.
