---
type: meta
tags: [tag-registry]
updated: 2026-04-18
---

# Tag registry

Canonical list of vault tags. **Don't create new tags without adding them here first** (and without team consensus). Tags explode quickly in a shared vault; a small, disciplined list is more useful than 200 orphan tags.

## Type tags (exclusive, one per note — also in the `type:` frontmatter)
- `#paper` — academic source
- `#article` — long-form non-academic piece (blog, whitepaper)
- `#clip` — content clipped from the web
- `#concept` — wiki page about a concept
- `#method` — wiki page about a method/technique
- `#model` — wiki page about a concrete model
- `#dataset`, `#benchmark`, `#person`, `#venue`, `#project`, `#meeting`, `#idea`

## Domain tags (free, combine freely)
- `#rag` — anything RAG
- `#retrieval` — focus on the retrieval stage
- `#generation` — focus on conditioned generation
- `#eval` — evaluation and benchmarks
- `#embeddings`
- `#chunking`
- `#reranking`
- `#hybrid-search`
- `#agent` — RAG with agents / tool use
- `#multimodal`
- `#graph` — GraphRAG and variants

## Status tags
- `#foundational` — seminal work, must-read
- `#sota` — state of the art per the team
- `#deprecated` — superseded by later work
- `#controversial` — substantive critique in the literature

## Workflow tags (transient)
- `#to-review` — pending human review
- `#needs-source` — unsupported claim, pending
- `#to-merge` — merge candidate with another page

---

If you need a new tag, propose it with a PR / commit `meta: new tag #xxx` with one line of justification.
