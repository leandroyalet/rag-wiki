---
type: model
aliases: [SBERT, sentence-transformers]
tags: [rag, model, embedding]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: ["[[01_Sources/web_clips/embedding-models-for-rag]]"]
---

# Sentence-BERT

> **TL;DR** The 2019 model that made BERT usable for semantic similarity at scale — a siamese bi-encoder that pools BERT into fixed-length sentence vectors, enabling cosine-similarity search without expensive pairwise inference.

## Description
Sentence-BERT (Reimers & Gurevych, 2019) solved a critical limitation of vanilla BERT: computing similarity between N sentences with BERT required N²/2 forward passes (cross-encoding every pair). SBERT adds a **siamese network** structure and a **pooling layer** (mean pooling over token embeddings) to produce fixed-length sentence vectors that can be pre-computed and compared with cosine similarity in O(N).

Training uses a siamese / triplet network objective on NLI (natural language inference) and STS (semantic textual similarity) datasets to pull semantically similar sentences together in embedding space.

### Architecture
```
Sentence A → BERT → Mean Pool → u
Sentence B → BERT → Mean Pool → v
Similarity = cosine(u, v)
```

The `sentence-transformers` Python library (also by Reimers) became the standard interface for loading and using SBERT-style models and is the foundation most modern embedding models (BGE, E5, etc.) are served through.

## Historical significance
SBERT established the bi-encoder paradigm for semantic search that underpins modern RAG [[Dense Retrieval]]. Before SBERT, semantic search with BERT was impractical at corpus scale.

## When to use it
- ✅ Semantic similarity, clustering, deduplication tasks where interpretable cosine scores are needed.
- ✅ Loading any HuggingFace embedding model via `sentence-transformers` — the library is model-agnostic.
- ❌ State-of-the-art retrieval accuracy — newer models ([[BGE]], [[E5]], [[ColBERT]]) substantially outperform original SBERT on [[MTEB]].
- ❌ Domain-specific retrieval without fine-tuning — SBERT was trained on NLI/STS, not retrieval datasets.

## Related pages
- [[BGE]]
- [[E5]]
- [[ColBERT]]
- [[Embeddings]]
- [[Dense Retrieval]]
- [[MTEB]]

## Sources
- [[01_Sources/web_clips/embedding-models-for-rag]]
