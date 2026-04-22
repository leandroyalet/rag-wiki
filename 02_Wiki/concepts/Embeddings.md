---
type: concept
aliases: [vector representations, text embeddings, dense vectors]
tags: [rag, retrieval, embedding]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[01_Sources/web_clips/embedding-models-for-rag]]", "[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]"]
---

# Embeddings

> **TL;DR** Fixed-dimension floating-point vectors that encode the semantic meaning of text, enabling similarity search in a [[Vector Database]] instead of keyword matching.

## Definition
An embedding is a dense vector (typically 384–4096 dimensions) produced by an encoder model for a given text input. Semantically similar texts map to geometrically close vectors, making cosine or dot-product similarity a proxy for meaning overlap.

Embedding models used in RAG are **bi-encoders**: documents and queries are encoded independently, allowing documents to be pre-embedded offline and queries to be embedded at inference time. [[01_Sources/web_clips/embedding-models-for-rag]]

## Context
Embeddings power step 4 of the offline RAG pipeline (Chunk → **Embed** → Index) and step 1 of the online pipeline (query → **embed** → search). [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

Without embeddings, semantic similarity search collapses to keyword matching ([[Sparse Retrieval]]). Embeddings enable [[Dense Retrieval]] but at the cost of requiring a dedicated model and GPU/CPU inference.

## How it works / How it's used

### Bi-encoder architecture
1. Pre-trained BERT-style encoder tokenizes input text.
2. Token representations are pooled (CLS pooling, mean pooling, or max pooling) into a single fixed-length vector.
3. At query time, the same model encodes the query; ANN search finds the nearest document vectors. [[01_Sources/web_clips/embedding-models-for-rag]]

### Training
Models are fine-tuned on (query, relevant passage, hard negative) triplets with a contrastive loss. High-quality academic datasets (MS MARCO, HotpotQA, Natural Questions) are used for a second fine-tuning stage. [[01_Sources/web_clips/embedding-models-for-rag]]

### Choosing a model
The [[MTEB]] (Massive Text Embedding Benchmark) leaderboard ranks models on NDCG@10 across retrieval, clustering, STS, and other tasks. For RAG, the **Retrieval** tab is most relevant. [[01_Sources/web_clips/embedding-models-for-rag]]

Start small: larger embedding models are not always better on domain-specific data, and smaller models reduce latency. [[01_Sources/web_clips/embedding-models-for-rag]]

## Variants
- **Bi-encoder** — separate encoding of query and document; enables offline pre-computation. Used for initial retrieval.
- **Cross-encoder** — jointly encodes query + document; higher accuracy but cannot be pre-computed. Used for [[Reranking]]. [[01_Sources/web_clips/embedding-models-for-rag]]
- **Late interaction (ColBERT)** — keeps per-token embeddings, computes MaxSim at query time; balances pre-computation and expressivity. See [[ColBERT]].
- **Sparse-dense hybrid** — combine dense embeddings with [[BM25]]-style sparse signals. See [[Hybrid Search]].

## Trade-offs
- ✅ Captures semantic similarity that keyword search misses (synonyms, paraphrases).
- ✅ Domain-agnostic at inference; specialization comes from fine-tuning.
- ❌ Max token limit (varies 512–8192 tokens) constrains chunk size.
- ❌ Embedding quality degrades outside the training distribution — domain-specific fine-tuning may be needed.
- ❌ Requires ANN index (HNSW, IVF) at scale; exact search is O(n) per query.

## Related pages
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Hybrid Search]]
- [[Chunking]]
- [[Vector Database]]
- [[BGE]]
- [[E5]]
- [[Sentence-BERT]]
- [[ColBERT]]
- [[MTEB]]
- [[Reranking]]

## Sources
- [[01_Sources/web_clips/embedding-models-for-rag]]
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
