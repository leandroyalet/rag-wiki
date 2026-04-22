# RAG Research Vault

Shared Obsidian vault for collaborative research on **Retrieval-Augmented Generation (RAG)**.

This vault follows Andrej Karpathy's **LLM Wiki** pattern (April 2026): a living wiki, written in markdown, that an LLM agent (e.g. Claude Code) can read, query, and maintain. The core idea: instead of having the LLM "rediscover" knowledge on every query (classic RAG pattern), **we compile knowledge once into structured markdown and keep it alive**.

## Three-layer architecture

```
01_Sources/    →  Layer 1 — Raw sources (IMMUTABLE). Papers, articles, web clips.
02_Wiki/       →  Layer 2 — Knowledge synthesized by the team + LLM (editable).
CLAUDE.md      →  Layer 3 — Schema / constitution of the vault (how the LLM operates).
```

Everything that comes from outside (PDF papers, articles clipped with Web Clipper, transcripts) goes to `01_Sources/` and **is never edited**. The LLM reads these sources and writes/updates pages in `02_Wiki/`, which is the layer the team consults day-to-day.

## Full structure

- **`00_Inbox/`** — Quick capture. Anything not yet classified. Processed with `/process-inbox`.
- **`01_Sources/`** — Raw, immutable sources.
  - `papers/` — Academic papers (PDF + sibling `.md` literature note with the same basename).
  - `articles/` — Long-form articles, technical posts.
  - `web_clips/` — Everything coming in through Obsidian Web Clipper.
  - `assets/` — Images, diagrams, downloaded figures.
- **`02_Wiki/`** — The living wiki. One page per entity.
  - `concepts/` — Concepts (chunking, reranking, hallucination, etc.).
  - `methods/` — Methods and techniques (HyDE, RAG-Fusion, RAPTOR, etc.).
  - `models/` — Specific models (Llama, Claude, concrete embedding models, etc.).
  - `datasets/` — Datasets and corpora.
  - `benchmarks/` — Benchmarks (MTEB, BEIR, RAGAS, etc.).
  - `people/` — Relevant authors and researchers.
- **`03_Projects/`** — Team projects (an experiment, a review, a publication).
- **`04_Meetings/`** — Team meeting notes.
- **`05_Ideas/`** — Loose ideas, hypotheses, research directions.
- **`06_Outlines/`** — Drafts of papers, reports, presentations.
- **`_templates/`** — Templates used by Templater / Core Templates.
- **`_meta/`** — Vault metadata: `index.md`, `log.md`, glossary, contributing guide.

## Start here

1. Open [[_meta/index|_meta/index]] — it's the entry map to the whole wiki.
2. Read [[_meta/CONTRIBUTING|CONTRIBUTING]] for the collaboration rules.
3. Check [[CLAUDE|CLAUDE.md]] to understand how the LLM operates on the vault.

## Daily flows

- **Capture a paper** → `01_Sources/papers/` (PDF + note using the `paper` template).
- **Clip a web article** → Obsidian Web Clipper → `01_Sources/web_clips/`.
- **Quick idea or note** → `00_Inbox/`, no ceremony.
- **Look something up** → open `_meta/index.md` or ask Claude Code from the vault root.

---

> _"Instead of just retrieving from raw documents at query time, the LLM incrementally builds and maintains a persistent wiki."_ — A. Karpathy
