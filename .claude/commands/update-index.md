Regenerate `_meta/index.md` from the current state of the vault.

## Steps

1. **Scan `02_Wiki/`** — read the frontmatter of every `.md` file. Collect: filename, title (H1 heading), `type`, `tags`, `status`, and TL;DR line (the blockquote immediately after the H1).

2. **Group pages** by their subfolder / type:
   - `concepts/` → Concepts
   - `methods/` → Methods & Techniques
   - `models/` → Models
   - `datasets/` → Datasets
   - `benchmarks/` → Benchmarks & Evaluation
   - `tools/` → Infrastructure & Tools
   - `people/` → People

3. **Within each group**, sort pages alphabetically by title. Format each entry as:
   `- [[Page Name]] — TL;DR line` (omit TL;DR if the page is a stub with no content yet).

4. **Preserve the non-generated sections** of `_meta/index.md`:
   - The YAML frontmatter block.
   - The intro paragraph ("This is the file you always look at first…").
   - The `## Collections`, `## Active projects`, and `## Team and processes` sections at the bottom.
   Only the `## Knowledge tracks` section (and its subsections) is regenerated.

5. **Write** the updated `_meta/index.md`.

6. **Append to `_meta/log.md`**:
```
## YYYY-MM-DD HH:MM — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: _meta/index.md
- **notes**: <N pages indexed across M sections>
```

After writing, report how many pages were indexed per section.
