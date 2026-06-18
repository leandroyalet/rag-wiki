---
type: concept
aliases: [[[BM25]], TF-IDF, lexical retrieval, keyword search]
tags: [rag, retrieval]
status: stub
created: 2026-04-18
updated: 2026-06-18
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]", "[[01_Sources/web_clips/sbert-net-sentence-transformers-library]]", "[[sen2026grep]]"]
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
- **SPLADE** — learned sparse model; see below.
- **uniCOIL** — per-token learned weights on a sparse [[BM25]]-like representation.

## SPLADE — learned sparse retrieval

SPLADE (Sparse Lexical and Expansion model) uses a masked language model to assign a relevance score to every vocabulary token for a given input, producing a vocabulary-sized vector (e.g., 30,522 dimensions for BERT's tokenizer) where >99% of values are zero. Non-zero dimensions correspond to specific tokens — making the representation interpretable and compatible with standard inverted-index infrastructure. [[01_Sources/web_clips/sbert-net-sentence-transformers-library]]

Key properties:
- **Learned expansion**: the LM infers which related terms should also be active (e.g., "car" also activates "vehicle", "automobile") — closing the vocabulary-mismatch gap that BM25 cannot.
- **~30–100 active dimensions** per embedding in practice; the rest are exactly zero.
- **Asymmetric encoding**: separate `encode_query()` and `encode_document()` calls apply different prompts, mirroring the dense bi-encoder pattern.

```python
from sentence_transformers import SparseEncoder

model = SparseEncoder("naver/splade-cocondenser-ensembledistil")
query_emb = model.encode_query("What causes hallucination in RAG?")
doc_emb = model.encode_document("Hallucination occurs when retrieved context is missing...")
# Both are sparse vectors; similarity = dot product over shared non-zero dimensions
```

SPLADE is served through the `sentence-transformers` library as the `SparseEncoder` class and slots naturally into [[Hybrid Search]] pipelines alongside a dense [[Embeddings|bi-encoder]]. [[01_Sources/web_clips/sbert-net-sentence-transformers-library]]

## Grep as agentic lexical search
In tool-using agents, the simplest sparse retriever is `grep` — regex/substring matching over raw text, with no inverted index, embedding model, or external service. When `grep` is a native bash tool, the agent constructs its own search terms, flags, and file targets dynamically rather than calling a fixed search API (see [[Agentic Search]]). In a 116-question [[LongMemEval]] study, lexical `grep` generally beat dense/vector retrieval and inline grep exceeded inline vector for *every* harness–model pair — because that task rewards recovering literal witnesses (exact dates, counts, preferences, spans) that remain stable under tokenization. Grep is "deliberately narrow": high-precision on the patterns it generates, but a vocabulary mismatch returns nothing. [[sen2026grep]]

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
- [[Agentic Search]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
- [[01_Sources/web_clips/sbert-net-sentence-transformers-library]]
- [[sen2026grep]]
