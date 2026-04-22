---
type: method
aliases: [Recursive Abstractive Processing for Tree-Organized Retrieval]
tags: [rag, method, chunking, summarisation, multi-level]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: []
introduced_by: Sarthi et al.
year: 2024
---

# RAPTOR

> **TL;DR** Recursively clusters and summarises chunks into a tree of increasing abstraction; retrieval searches all levels simultaneously — getting precise detail or high-level themes as the query demands.

## Problem it solves
Flat [[Chunking]] indexes local windows but misses cross-document or cross-section themes. Long-range questions ("What is the overall argument of this paper?") require synthesising many chunks, but stuffing all of them into context is expensive and noisy. RAPTOR builds multi-granularity representations at index time so the retriever can match at the right level of abstraction.

## Key idea
Build a **retrieval tree**: leaf nodes are original chunks; parent nodes are LLM-generated summaries of clustered siblings. Repeat recursively until a single root covers the full corpus. At query time, a standard embedding retriever searches *all levels at once*, returning whichever node best matches — whether a detailed leaf or a broad summary.

## Pipeline / Steps
**Indexing (offline):**
1. Embed all leaf chunks.
2. Cluster embeddings using Gaussian Mixture Models (soft clustering allows chunk overlap).
3. LLM summarises each cluster → new parent node.
4. Embed parent nodes; repeat until root.

**Retrieval (online) — two modes:**
- **Tree traversal**: start at root, greedily descend to the most relevant child. Fast but can miss leaves.
- **Collapsed tree** (recommended): flatten all nodes across all levels into one pool; run standard top-k retrieval. Empirically outperforms tree traversal.

## Reference implementations
- Original: `parthsarthi26/raptor` (GitHub).
- **LlamaIndex**: `RaptorPack` wraps the full indexing and retrieval pipeline.

## Reported results
On QASPER and QuALITY (long-document QA), RAPTOR + GPT-4 improves over standard chunk-based RAG by up to 20 % accuracy; gains are largest on synthesis questions spanning multiple sections.

> [!todo] Source needed — Sarthi et al. ICLR 2024 not yet in 01_Sources/.

## When to use / when not to
- ✅ Long documents or corpora where questions span sections or the whole document.
- ✅ Mixed queries — some need detail, some need high-level synthesis.
- ❌ Short / narrow corpora — tree overhead not justified; flat chunking is sufficient.
- ❌ Rapidly changing documents — tree must be rebuilt on each update.

## Related / alternatives
- [[Chunking]] — RAPTOR replaces flat chunking with hierarchical summarisation.
- [[GraphRAG]] — similar motivation but uses an explicit entity graph instead of summary clusters.
- [[Multi-hop Retrieval]] — handles multi-step reasoning at query time without pre-built trees.
- [[Fusion-in-Decoder]] — multi-document synthesis at generation time rather than index time.

## Sources
> [!todo] Source needed — Sarthi et al. "RAPTOR: Recursive Abstractive Processing for Tree-Organized Retrieval" ICLR 2024 not yet in 01_Sources/
