# CLAUDE.md — Vault schema

This file is the **constitution** of the vault. Claude Code (or any LLM agent) reads it at startup to understand how to operate. Edit it when the structure or conventions change.

Inspired by Andrej Karpathy's LLM Wiki pattern: three layers (sources → wiki → schema), source immutability, and aggressive cross-referencing.

---

## 1. Vault identity

- **Topic**: research on Retrieval-Augmented Generation (RAG).
- **Audience**: research team (humans) + LLM agents.
- **Language**: English everywhere — templates, structure, prose, meta files. Keep it uniform so the LLM has a stable contract and the vault stays consistent as it grows.
- **Naming canon**: always prefer the standard English term as the page name (`Retrieval-Augmented Generation`, `Hybrid Search`). Add variants (translations, acronyms, common misspellings) via the `aliases` frontmatter field.

## 2. The three layers — golden rule

### Layer 1 — `01_Sources/` (IMMUTABLE)

Raw sources. The LLM **reads** but **never modifies** files in `01_Sources/`.

- Each paper in `01_Sources/papers/` exists as a **pair** of files:
  - `{citekey}.pdf` — the original PDF.
  - `{citekey}.md` — the literature note (metadata + summary + annotations). This note IS edited.
- Each clipped article lives in `01_Sources/web_clips/` with clipping frontmatter (URL, date, author).
- Images and figures go to `01_Sources/assets/`.
- **Immutability matters**: if the LLM could edit a source, we'd lose the ability to trace "what the original paper said" vs "what the wiki says about the paper".

### Layer 2 — `02_Wiki/` (ACTIVELY MAINTAINED)

Synthesized pages. Each page is an entity (a concept, a method, a model, etc.). The LLM can:
- Create new pages when an entity appears that doesn't exist yet.
- Update existing pages when ingesting new sources.
- Merge duplicates (always logging the action).
- Create cross-references with `[[wikilinks]]`.

### Layer 3 — this file (`CLAUDE.md`)

The rules. When the schema changes, edit here and the LLM adopts the change on the next session.

## 3. Naming conventions

- **Concept / method / model files**: `Title Case with spaces.md` (e.g., `Hybrid Search.md`, `RAG-Fusion.md`).
- **Papers**: `{firstAuthor}{year}{keyword}.md` (e.g., `lewis2020rag.md`, `karpukhin2020dpr.md`). Same citekey used in Zotero/BibTeX (`authEtal2+year`).
- **Meetings**: `YYYY-MM-DD - short title.md`.
- **Projects**: `kebab-case/` as a folder; each project has its own `README.md`.
- **Never** use spaces in files that will pass through a CLI (processing scripts). Use `snake_case` there.

## 4. Standard frontmatter

Every note in `02_Wiki/` must have:

```yaml
---
type: concept | method | model | dataset | benchmark | person | venue
aliases: [alternative term, acronym, translation]
tags: [rag, retrieval]
status: stub | draft | review | stable
created: 2026-04-18
updated: 2026-04-18
sources: ["[[lewis2020rag]]", "[[01_Sources/web_clips/pinecone-hybrid-search]]"]
---
```

For papers in `01_Sources/papers/`:

```yaml
---
type: paper
citekey: lewis2020rag
title: "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks"
authors: [Patrick Lewis, Ethan Perez, ...]
year: 2020
venue: NeurIPS
url: https://arxiv.org/abs/2005.11401
pdf: "[[lewis2020rag.pdf]]"
tags: [paper, rag, foundational]
status: to-read | reading | read | summarized
added: 2026-04-18
added_by: name
---
```

## 5. Body structure of a wiki page

```markdown
# {Entity name}

> **TL;DR** (one line). Claude reads this to decide whether to read the whole page.

## Context
What problem it solves, where it fits in the RAG pipeline.

## How it works
Core explanation, in prose. Cross-link to [[other pages]].

## Variants / Extensions
If applicable.

## Trade-offs
What's gained, what's lost, when to use it.

## State of the art
What recent papers say. Each claim linked to [[citekey]].

## Related pages
- [[Other page]]
- [[Other page]]

## Sources
- [[lewis2020rag]]
- [[01_Sources/web_clips/...]]
```

## 6. Operations the LLM runs

Suggested commands / slash-commands for Claude Code:

- **`/ingest`** — Read a new source (from `00_Inbox/` or `01_Sources/`) and update the relevant wiki pages (typically 5–15 pages per source). Log in `_meta/log.md`.
- **`/ingest-url <url>`** — Same but from a URL (delegates to Web Clipper or equivalent).
- **`/process-inbox`** — Classify every file in `00_Inbox/` and suggest which folder to move it to / which tags to add.
- **`/lint-wiki`** — Look for: broken links, orphan pages (no backlinks), duplicates, contradictions between pages, concepts mentioned without their own page. Write report to `_meta/lint-YYYY-MM-DD.md`.
- **`/update-index`** — Regenerate `_meta/index.md` from existing pages.
- **`/summarize <folder|tag|query>`** — Synthesized summary over a subset of the vault, citing pages.

## 7. Editing rules for the LLM

1. **Conservative edits**: when updating an existing page, don't rewrite from scratch. Make minimal diffs and preserve the team's prior work.
2. **Always cite**: every claim in the wiki must have `[[source]]` at the end of the sentence or paragraph.
3. **Log changes**: every ingest or lint operation is recorded in `_meta/log.md` with timestamp, operation, files touched.
4. **Frontmatter first**: if a note has no frontmatter, add it before editing the body.
5. **Status promotion**: when creating a page, leave it as `status: stub`. Only a human promotes it to `stable`.
6. **Don't hallucinate sources**: if a claim has no backing in `01_Sources/`, mark it with `> [!todo] Source needed`.
7. **Don't rewrite `01_Sources/`**: never. If something in a source needs correcting, correct it in the wiki.
8. **Language**: always English. Preserve template headings and frontmatter keys as-is.

## 8. Human collaboration

- One person = one git branch for large changes (bulk ingestion, refactors).
- Small changes and daily notes can go straight to `main` via the Obsidian Git commit-and-sync.
- Commit prefixes: `paper:`, `wiki:`, `project:`, `meeting:`, `idea:`, `meta:`.
- `_meta/log.md` is append-only. Don't edit past entries.

## 9. What to do if the vault grows beyond 500 pages

- Consider `qmd` (BM25 + vector + MCP search) so the agent can index without loading everything into context.
- Partition `02_Wiki/` by sub-topics if a subfolder exceeds ~200 pages.
- Add a layer of manually curated "evergreen notes" separate from the automatic entity pages.

---

_Last edit: 2026-04-18. Changes to this file require discussion in a team meeting._
