---
type: concept
aliases: [dense passage retrieval, DPR, semantic retrieval]
tags: [rag, retrieval]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[lewis2020rag]]", "[[01_Sources/web_clips/embedding-models-for-rag]]", "[[oche2025ragsurvey]]"]
---

# Dense Retrieval

> **TL;DR** Retrieving documents by nearest-neighbor search in embedding space rather than keyword overlap — captures semantic similarity but requires a bi-encoder and an ANN index.

## Definition
Dense retrieval encodes both queries and documents as continuous vectors using a bi-encoder model. At query time, an Approximate Nearest Neighbor (ANN) search over the document index returns the top-k closest passages by cosine or dot-product similarity. It contrasts with [[Sparse Retrieval]] ([[BM25]], TF-IDF), which matches on exact token overlap.

The canonical instantiation is **DPR (Dense Passage Retrieval)**, introduced alongside the original RAG paper: a BERT bi-encoder trained on Natural Questions and TriviaQA. [[lewis2020rag]] Retrievers are trained via **contrastive loss** — maximizing similarity for relevant query-passage pairs while minimizing it for hard negatives. [[oche2025ragsurvey]]

## Context
Dense retrieval is the default first-stage retriever in modern RAG pipelines. It is paired with [[Embeddings]] for encoding and a [[Vector Database]] for the ANN index. Optionally, a [[Reranking]] step follows to re-score the top-k candidates with a cross-encoder. [[01_Sources/web_clips/embedding-models-for-rag]]

## How it works / How it's used
1. **Offline**: every document chunk is embedded → stored in a [[Vector Database]] (HNSW/IVF index).
2. **Online**: user query is embedded with the same model → ANN search retrieves top-k chunks → chunks are passed to the LLM.

## Variants
- **Single-vector bi-encoder** (DPR, [[BGE]], [[E5]]) — one vector per passage; fast, scalable.
- **Late interaction / multi-vector** ([[ColBERT]]) — per-token vectors; MaxSim scoring; higher accuracy at higher storage cost.
- **Asymmetric retrieval** — query and document encoders are separate models (allows different-length optimization).

## Trade-offs
- ✅ Retrieves semantically related passages even without exact keyword match.
- ✅ Scales to billions of documents with ANN indexes (HNSW, ScaNN).
- ❌ Misses exact keyword matches that [[Sparse Retrieval]] catches (e.g., rare proper nouns, codes).
- ❌ Embedding quality is distribution-dependent; degrades on out-of-domain text.
- ❌ ANN index must be rebuilt or updated when the corpus changes.

## Related pages
- [[Embeddings]]
- [[Sparse Retrieval]]
- [[Hybrid Search]]
- [[Vector Database]]
- [[Reranking]]
- [[ColBERT]]
- [[Retrieval-Augmented Generation]]

## Sources
- [[lewis2020rag]]
- [[01_Sources/web_clips/embedding-models-for-rag]]
- [[oche2025ragsurvey]]
