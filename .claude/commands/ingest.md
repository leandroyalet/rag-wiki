Ingest a source file into the RAG wiki vault.

The source to ingest is: $ARGUMENTS

If no argument is provided, list every file in `00_Inbox/` and every unread/unsummarized file in `01_Sources/` and ask the user which one to process.

## Steps

1. **Read the source file** in full. Respect the immutability rule: never modify files in `01_Sources/` (the literature note `.md` sibling of a paper may be edited if it exists and is clearly a note, not the raw PDF).

2. **Extract entities** — for every concept, method, model, dataset, benchmark, tool, or person mentioned, note its name and any key claims made about it.

3. **For each entity**, check whether a page already exists in `02_Wiki/` (search by filename and by aliases in frontmatter):
   - **Page exists**: make conservative additions. Append new claims, extend sections, add cross-links. Do not rewrite existing prose.
   - **Page does not exist**: create it using the matching template from `_templates/` (`concept.md`, `method.md`, `benchmark.md`, etc.). Set `status: stub`.

4. **Frontmatter rules**:
   - Every page must have valid frontmatter before body edits.
   - Add the source to the `sources:` list using a wikilink: `"[[citekey]]"` for papers, `"[[01_Sources/web_clips/kebab-case-name]]"` for clips.
   - Set `updated:` to today's date (2026-04-18).

5. **Citation rule**: every new claim added to a wiki page must end with `[[source-citekey]]`. If a claim cannot be traced to `01_Sources/`, append `> [!todo] Source needed` instead.

6. **Cross-links**: use `[[Page Name]]` wikilinks for every entity that has (or should have) its own wiki page.

7. **Log the operation** — append to `_meta/log.md`:
```
## YYYY-MM-DD HH:MM — Claude Code (/ingest)
- **operation**: ingest
- **source**: <filename>
- **files touched**: <list of created/updated wiki pages>
- **notes**: <any relevant observations>
```

After finishing, report: source processed, pages created (list), pages updated (list).
