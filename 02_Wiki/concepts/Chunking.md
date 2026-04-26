---
type: concept
aliases: [text splitting, document splitting, chunk size]
tags: [rag, indexing, preprocessing]
status: draft
created: 2026-04-18
updated: 2026-04-26
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]", "[[zhou2026chunktaxonomy]]", "[[moura2026adaptive]]", "[[zhao2025moc]]", "[[01_Sources/web_clips/Contextual Retrieval in AI Systems]]"]
---

# Chunking

> **TL;DR** Splitting source documents into smaller, overlapping pieces before indexing so that each retrieved passage is semantically focused and fits the LLM's context window.

## Definition
Chunking is the process of dividing long documents into shorter fragments that are individually embedded and stored in a [[Vector Database]]. Each chunk becomes the atomic unit of retrieval; the LLM receives only the chunks surfaced by the query, not the full document.

## Context
Chunking is step 3 of the offline (indexing) RAG phase: Load → Clean → **Chunk** → Embed → Index. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

It governs the precision/recall trade-off of the retrieval step: chunks that are too large dilute the [[Dense Retrieval|dense signal]] and waste prompt space; chunks that are too small lose surrounding context. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

## Taxonomy

[[zhou2026chunktaxonomy]] unifies chunking strategies along two orthogonal dimensions:

### Dimension 1 — Segmentation method
| Category | Method | Description |
|----------|--------|-------------|
| Structure-based | Fixed-size | Split every N tokens with optional overlap |
| Structure-based | Sentence | Split at sentence boundaries |
| Structure-based | Paragraph | Split at `\n\n` or heading boundaries |
| Semantic | Semantic splitting | Split where cosine similarity between adjacent sentences falls below a threshold |
| LLM-guided | **DenseX** | LLM decomposes text into atomic propositions; each proposition is a chunk |
| LLM-guided | **LumberChunker** | LLM inserts breakpoints between paragraphs where it detects a topic shift |

### Dimension 2 — Embedding timing
| Paradigm | How it works |
|----------|-------------|
| **Pre-embedding chunking** | Segment first; embed each chunk independently |
| **Contextualized chunking** ([[Late Chunking]]) | Embed full document first (long-context model), then segment at token-embedding level |

### Which strategy to choose

| Retrieval task | Best segmentation | Best embedding timing |
|---|---|---|
| In-corpus (standard IR) | Structure-based (paragraph or fixed-size) | Pre-embedding; [[Late Chunking]] adds +22–27% for LLM-guided methods |
| In-document (needle-in-haystack) | LumberChunker (+10–30% over paragraph) | Pre-embedding ([[Late Chunking]] degrades) |

DenseX (proposition-based) shows 15–27% effectiveness *loss* vs. paragraph for in-corpus retrieval. Chunk size correlates moderately with in-document effectiveness but weakly with in-corpus — method choice matters beyond size alone. [[zhou2026chunktaxonomy]]

## How it works / How it's used

### Common strategies (structure-based)
- **Fixed-size with overlap**: split every N tokens (e.g., 512) with a sliding overlap (e.g., 50–100 tokens) to avoid cutting sentences mid-thought.
- **Recursive character splitting**: try `\n\n` → `\n` → ` ` in order, respecting natural paragraph structure.
- **Semantic chunking**: embed sentences and split where cosine similarity between adjacent sentences drops below a threshold — keeps coherent units together.
- **Document-structure-aware**: respect Markdown headings, HTML `<p>` tags, or PDF page boundaries.

### Overlap
A 10–20 % token overlap ensures that context spanning a boundary is retrievable from both adjacent chunks.

## Variants
- **Hierarchical / parent-child chunking**: small chunks are embedded for precision; at retrieval time, the parent (larger) chunk is returned for richer context.
- **Proposition-based chunking (DenseX)**: split on atomic factual claims rather than fixed windows; best for in-document retrieval. [[zhou2026chunktaxonomy]]
- **[[Late Chunking]]**: embed full document with long-context model first, then segment embeddings — preserves cross-sentence context. [[zhou2026chunktaxonomy]]
- **[[Adaptive Chunking]]**: per-document strategy selection guided by 5 intrinsic quality metrics (RC, ICC, DCC, BI, SC); +10 pp answer correctness on mixed-domain corpora. [[moura2026adaptive]]
- **[[MoC]] (Mixture-of-Chunkers)**: route text segments to specialized small LMs by target chunk size; each outputs regex boundary patterns. [[zhao2025moc]]
- **RAPTOR tree summaries**: recursive summarization produces multi-granularity representations. See [[RAPTOR]].

## Contextual enrichment
Rather than changing how documents are split, **contextual enrichment** improves chunk quality by prepending an LLM-generated context blurb (50–100 tokens) to each chunk before embedding and BM25 indexing. This preserves document-level information (entity names, dates, section context) that would otherwise be lost. See [[Contextual Retrieval]]. [[01_Sources/web_clips/Contextual Retrieval in AI Systems]]

## Evaluating chunking quality
Two intrinsic metrics from [[zhao2025moc]] that measure chunking quality directly (without running downstream RAG):
- **Boundary Clarity (BC)** = `ppl(q|d) / ppl(q)` — near 1 means chunks are self-contained; lower values signal inter-chunk semantic leakage.
- **Chunk Stickiness (CS)** = structural entropy of a semantic association graph — lower = better semantic independence between chunks.

Five document-based metrics from [[moura2026adaptive]]: References Completeness (RC), Intrachunk Cohesion (ICC), Document Contextual Coherence (DCC), Block Integrity (BI), Size Compliance (SC).

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
- [[Adaptive Chunking]]
- [[Late Chunking]]
- [[MoC]]
- [[Contextual Retrieval]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
- [[zhou2026chunktaxonomy]]
- [[moura2026adaptive]]
- [[zhao2025moc]]
- [[01_Sources/web_clips/Contextual Retrieval in AI Systems]]
