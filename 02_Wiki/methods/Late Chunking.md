---
type: method
aliases: [late chunking, contextualized chunking]
tags: [rag, method, chunking, embeddings]
status: stub
created: 2026-04-26
updated: 2026-04-26
sources: ["[[zhou2026chunktaxonomy]]"]
introduced_by: Günther et al. (Jina AI)
year: 2024
---

# Late Chunking

> **TL;DR** Embed the full document first using a long-context model, then segment at the token-embedding level — so each chunk retains global document context rather than being encoded in isolation.

## Problem it solves
In standard "chunk-then-embed" pipelines, each chunk is embedded independently, discarding any context from surrounding text. A sentence that refers to "the above table" or uses a pronoun from earlier in the document loses meaning when isolated. Late Chunking preserves that context by encoding the whole document before splitting. [[zhou2026chunktaxonomy]]

## Key idea
Use a long-context encoder to produce token-level embeddings for the entire document. Then apply a segmentation algorithm (fixed-size, sentence, or semantic) to those token embeddings rather than the raw text, and mean-pool each segment's embeddings to get a chunk vector. The chunk vector carries information from the full document context. [[zhou2026chunktaxonomy]]

## Pipeline / Steps
1. Feed the full document to a long-context embedding model (e.g., jina-embeddings-v3 with 8192-token window).
2. Obtain per-token embeddings.
3. Apply a segmentation method (any structure- or semantic-based rule) on the token sequence.
4. Mean-pool token embeddings within each segment → chunk vector.
5. Index chunk vectors normally.

## Reported results
From [[zhou2026chunktaxonomy]] (reproduction study across multiple retrievers):
- **In-corpus retrieval**: contextualized chunking improves effectiveness, especially for LLM-guided methods (+22–27% for proposition-based / DenseX).
- **In-document retrieval (needle-in-haystack)**: Late Chunking *degrades* performance across all configurations — the global context introduces noise when pinpointing a specific passage.

## When to use / when not to
- ✅ Standard in-corpus retrieval where chunks benefit from document context.
- ✅ Combined with LLM-guided segmentation (DenseX, LumberChunker) for additional gains.
- ❌ Needle-in-haystack / in-document retrieval — pre-embedding chunking outperforms.
- ❌ Short documents where each chunk already contains sufficient context.
- ❌ Corpora too large to fit document-level context in the encoder's window.

## Related / alternatives
- [[Chunking]] — parent concept.
- [[Adaptive Chunking]] — selects chunking strategy per document.
- [[Embeddings]] — the long-context encoder is the key enabler.

## Sources
- [[zhou2026chunktaxonomy]]
