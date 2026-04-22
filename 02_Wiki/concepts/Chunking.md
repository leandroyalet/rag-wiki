---
type: concept
aliases: [text splitting, document splitting, chunk size]
tags: [rag, indexing, preprocessing]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]"]
---

# Chunking

> **TL;DR** Splitting source documents into smaller, overlapping pieces before indexing so that each retrieved passage is semantically focused and fits the LLM's context window.

## Definition
Chunking is the process of dividing long documents into shorter fragments that are individually embedded and stored in a [[Vector Database]]. Each chunk becomes the atomic unit of retrieval; the LLM receives only the chunks surfaced by the query, not the full document.

## Context
Chunking is step 3 of the offline (indexing) RAG phase: Load → Clean → **Chunk** → Embed → Index. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

It governs the precision/recall trade-off of the retrieval step: chunks that are too large dilute the [[Dense Retrieval|dense signal]] and waste prompt space; chunks that are too small lose surrounding context. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

## How it works / How it's used

### Common strategies
- **Fixed-size with overlap**: split every N tokens (e.g., 512) with a sliding overlap (e.g., 50–100 tokens) to avoid cutting sentences mid-thought.
- **Recursive character splitting**: try `\n\n` → `\n` → ` ` in order, respecting natural paragraph structure.
- **Semantic chunking**: embed sentences and split where cosine similarity between adjacent sentences drops below a threshold — keeps coherent units together.
- **Document-structure-aware**: respect Markdown headings, HTML `<p>` tags, or PDF page boundaries.

### Overlap
A 10–20 % token overlap ensures that context spanning a boundary is retrievable from both adjacent chunks.

## Variants
- **Hierarchical / parent-child chunking**: small chunks are embedded for precision; at retrieval time, the parent (larger) chunk is returned for richer context.
- **Proposition-based chunking**: split on atomic factual claims rather than fixed windows.
- **RAPTOR tree summaries**: recursive summarization produces multi-granularity representations. See [[RAPTOR]].

## Trade-offs
- ✅ Smaller chunks → higher embedding precision, less off-topic context injected into the prompt.
- ✅ Larger chunks → richer context, fewer boundary-cut artifacts.
- ❌ No universally optimal size — depends on domain, query type, and embedding model token limit.
- ❌ Overlapping chunks increase index size and may introduce near-duplicate content in the prompt.

## Related pages
- [[Embeddings]]
- [[Vector Database]]
- [[Dense Retrieval]]
- [[Retrieval-Augmented Generation]]
- [[RAPTOR]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
