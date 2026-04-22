---
type: meta
tags: [contributing, process]
updated: 2026-04-18
---

# How to contribute to the vault

This vault is shared. To keep it from becoming a markdown dumpster, we follow a few minimal rules.

## 1. Before starting any session

1. **Pull** (from Obsidian Git: `commit-and-sync` or `pull`). Never start writing without bringing in the team's changes.
2. Check the latest [[log]] to see what's been ingested / changed recently.

## 2. When adding a source (paper, article, clip)

- **Papers** (PDF):
  1. Download the PDF to `01_Sources/papers/{citekey}.pdf`.
  2. Create the sibling note `01_Sources/papers/{citekey}.md` using the `paper` template.
  3. Fill in at least: `title`, `authors`, `year`, `venue`, `url`, `tags`.
  4. Set `status: to-read` and your name in `added_by`.
  5. Optional: run `/ingest 01_Sources/papers/{citekey}.md` so Claude updates the wiki.
- **Web articles**: use [Obsidian Web Clipper](https://obsidian.md/clipper) configured to save to `01_Sources/web_clips/`.
- **Quick notes / loose ideas**: go to `00_Inbox/` without ceremony. `/process-inbox` classifies them later.

## 3. When writing in the wiki (`02_Wiki/`)

- Use the appropriate template (`concept`, `method`, `model`, etc.).
- **Frontmatter always first**.
- Every claim with `[[source]]`. If you don't have a source, leave `> [!todo] Source needed` and move on. Someone or Claude fills it in later.
- Link aggressively. If you mention a concept that already has a page, use `[[wikilink]]`. If it doesn't have one but should, create it as `status: stub` (2 lines is enough).
- Don't write monolithic 5000-word documents. One topic = one page. Split frequently.

## 4. Commit conventions (Obsidian Git)

We use prefixes so the git log stays readable:

```
paper:   lewis2020rag added and summarized
wiki:    Hybrid Search - add trade-offs section
project: kb-synth-eval - experiment 3 results
meeting: 2026-04-18 sprint retro
idea:    try HyDE with multilingual queries
meta:    update CLAUDE.md with new rule
lint:    fix 12 broken links found by /lint-wiki
```

## 5. Merge conflicts

They're rare because flat markdown merges well, but when they happen:

- Prefer resolving by hand in an external editor (VS Code), not from mobile.
- If two people edited the same section, keep both changes and ping each other in the meeting.
- Never silently discard someone else's changes.

## 6. What **not** to do

- ❌ Edit files in `01_Sources/`. They're immutable.
- ❌ Delete pages without leaving a note in `_meta/log.md`.
- ❌ Create new tags without consensus (see `_meta/tag-registry.md`).
- ❌ Use Obsidian Sync (the paid service) and Git at the same time — pick one.
- ❌ Push PDF papers > 25 MB without Git LFS.
- ❌ Move many files without running `/lint-wiki` afterwards (it breaks wikilinks).

## 7. Suggested cycle

- **Daily**: capture what you read. Don't process anything.
- **Weekly**: `/process-inbox`, `/lint-wiki`, review [[reading-list]].
- **Monthly**: review contradictions, open questions, promote `draft → stable` pages.
- **Per sprint**: team meeting, retro, decide new lines.

## 8. Security and privacy

- This vault is **team-private**. Don't clip content with credentials, sensitive data, or unpublished drafts from third parties.
- Never commit API keys or tokens. Use `.env` outside the vault.
- `.gitignore` already excludes `.obsidian/workspace*` (local preferences).

---

If this guide fails you or falls short, edit it and commit with the `meta:` prefix.
