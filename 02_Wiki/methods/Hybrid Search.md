---
type: method
aliases: [Hybrid Retrieval, Dense + Sparse]
tags: [rag, retrieval, hybrid-search]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: []
introduced_by: 
year: 
---

# Hybrid Search

> **TL;DR** Combine [[Sparse Retrieval]] ([[BM25]]) and [[Dense Retrieval]] (embeddings) and fuse their rankings to get better recall than either alone.

## Problem it solves
Dense retrievers are good with synonyms and semantics but struggle with proper nouns, acronyms, and rare terms not well represented in the embedding space. [[BM25]] does the opposite: it shines at exact lexical match but is blind to paraphrase.

## Key idea
Run both retrievers, normalize scores, and fuse. The most common fusion method is **Reciprocal Rank Fusion (RRF)**:

$$\text{RRF}(d) = \sum_{r \in R} \frac{1}{k + \text{rank}_r(d)}$$

with `k ≈ 60`. RRF ignores raw scores and uses only rankings, which makes it robust to incomparable scales.

## Pipeline
1. Query → in parallel:
   - Top-N by [[BM25]] over an inverted index.
   - Top-N by cosine similarity over embeddings.
2. Fusion (RRF, convex combination, or joint reranking).
3. Optional: [[Reranking]] over the top-M fused.
4. Pass final top-k to the LLM.

## Reference implementations
- Elastic / OpenSearch with vector fields.
- [[Weaviate]] — native hybrid search.
- [[Qdrant]] — sparse + dense vectors.
- [[Pinecone]] — hybrid with sparse-dense vectors.

## When to use / when not to
- ✅ Corpora with lots of jargon, product codes, IDs, citations.
- ✅ When a single modality has low recall in internal evals.
- ❌ If the corpus is homogeneous prose without rare vocabulary, the overhead may not pay off.

## Related
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Reranking]] — complementary, not alternative.
- [[RAG-Fusion]] — generalizes the idea to multiple reformulated queries.

## Sources
> [!todo] Source needed
> Add the original RRF paper (Cormack et al., 2009) and comparative benchmarks on [[BEIR]].
