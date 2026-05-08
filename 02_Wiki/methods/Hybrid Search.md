---
type: method
aliases: [Hybrid Retrieval, Dense + Sparse]
tags: [rag, retrieval, hybrid-search]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[01_Sources/web_clips/Contextual Retrieval in AI Systems]]", "[[01_Sources/web_clips/How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI]]", "[[01_Sources/web_clips/sbert-net-sentence-transformers-library]]"]
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

## SPLADE as a learned sparse signal
Beyond BM25, **SPLADE** (Sparse Lexical and Expansion model) is a drop-in learned sparse retriever that closes the vocabulary-mismatch gap: it activates related vocabulary tokens not present in the raw text (e.g., "car" activates "vehicle"). A SPLADE + dense hybrid therefore covers both exact keyword matching and semantic paraphrase matching better than BM25 + dense alone. [[01_Sources/web_clips/sbert-net-sentence-transformers-library]]

SPLADE vectors are vocabulary-sized and >99% sparse, making them compatible with the same inverted-index infrastructure as BM25. Served via `sentence-transformers` as `SparseEncoder("naver/splade-cocondenser-ensembledistil")`. See [[Sparse Retrieval]] for details.

## Contextual BM25
[[Contextual Retrieval]] (Anthropic, 2024) extends standard hybrid search by prepending an LLM-generated context blurb to each chunk *before* building the BM25 index. This makes the BM25 index aware of document-level context (entity names, dates, section headings) that the raw chunk text omits. [[01_Sources/web_clips/Contextual Retrieval in AI Systems]]

Benchmarked result: Contextual Embeddings + Contextual BM25 reduces top-20 retrieval failures by **49%** (5.7% → 2.9%) vs. embedding-only baseline; adding reranking reaches **67%** reduction.

## Context bloat and context poisoning
Two failure modes that hybrid search + reranking help mitigate [[01_Sources/web_clips/How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI]]:
- **Context bloat** — too many chunks injected into the LLM context, most of them irrelevant; degrades generation quality.
- **Context poisoning** — factually incorrect chunks pass retrieval and contaminate the LLM's context window; causes confident wrong answers.

Both are worsened by fetching large k without a precision stage (reranking or LLM verification).

## When to use / when not to
- ✅ Corpora with lots of jargon, product codes, IDs, citations.
- ✅ When a single modality has low recall in internal evals.
- ✅ Combined with [[Contextual Retrieval]] for documents where chunks lose entity context in isolation.
- ❌ If the corpus is homogeneous prose without rare vocabulary, the overhead may not pay off.

## Related
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Reranking]] — complementary, not alternative.
- [[RAG-Fusion]] — generalizes the idea to multiple reformulated queries.
- [[Contextual Retrieval]] — extends Hybrid Search with LLM-generated context prepended to both embedding and BM25 inputs.

## Sources
- [[01_Sources/web_clips/Contextual Retrieval in AI Systems]]
- [[01_Sources/web_clips/How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI]]
> [!todo] Source needed — add the original RRF paper (Cormack et al., 2009) and comparative benchmarks on [[BEIR]].
