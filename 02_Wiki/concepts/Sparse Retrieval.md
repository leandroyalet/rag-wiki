---
type: concept
aliases: [[[BM25]], TF-IDF, lexical retrieval, keyword search]
tags: [rag, retrieval]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]"]
---

# Sparse Retrieval

> **TL;DR** Retrieving documents by token-overlap scoring ([[BM25]], TF-IDF) — fast, interpretable, and excellent for exact-match queries; misses semantic similarity.

## Definition
Sparse retrieval represents documents and queries as high-dimensional, mostly-zero vectors over the vocabulary. Each non-zero dimension corresponds to a token that appears in the text, weighted by term frequency and inverse document frequency. Similarity is computed by inner product over these sparse vectors.

The dominant algorithm is **[[BM25]]** (Best Match 25), a probabilistic ranking function that normalizes TF by document length and saturates at high term frequency. It has been the standard baseline in information retrieval for decades.

## Context
Sparse retrieval preceded [[Dense Retrieval]] and still provides complementary signal, especially for:
- Rare proper nouns, product codes, version numbers.
- Queries where the exact term matters (e.g., API names, medical codes).

It is commonly combined with dense retrieval in [[Hybrid Search]] pipelines.

## How it works / How it's used
1. At indexing time, an inverted index maps each vocabulary token to the list of documents containing it (with frequency statistics).
2. At query time, each query token is looked up in the inverted index; [[BM25]] scores all matching documents in O(|query tokens| × posting list length).
3. Results are ranked by score and the top-k are returned.

No GPU is required; [[BM25]] runs efficiently on CPU with standard search libraries (Elasticsearch, OpenSearch, Whoosh, `rank_bm25` in Python).

## Variants
- **[[BM25]]** — the standard; used in virtually all modern hybrid baselines.
- **TF-IDF** — simpler ancestor of [[BM25]]; no length normalization saturation.
- **SPLADE** — learned sparse model that expands query and document tokens using an LM; bridges sparse and dense worlds.
- **uniCOIL** — per-token learned weights on a sparse [[BM25]]-like representation.

## Trade-offs
- ✅ Exact keyword match — catches rare terms that dense models miss.
- ✅ No GPU at query time; very fast at scale with inverted indexes.
- ✅ Fully interpretable: score breakdowns show which tokens drove the match.
- ❌ Vocabulary mismatch: query "automobile" doesn't match document "car".
- ❌ No semantic understanding — paraphrases and synonyms are invisible.
- ❌ Requires pre-processing (tokenization, stopword removal, stemming) that affects recall.

## Related pages
- [[Dense Retrieval]]
- [[Hybrid Search]]
- [[Embeddings]]
- [[Retrieval-Augmented Generation]]
- [[BEIR]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
