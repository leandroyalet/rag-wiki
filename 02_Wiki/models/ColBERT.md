---
type: model
aliases: [Contextualized Late Interaction over BERT, ColBERT v2]
tags: [rag, model, embedding, late-interaction, retrieval]
status: stub
created: 2026-04-18
updated: 2026-04-19
sources: ["[[shorten2026irpapers]]"]
---

# ColBERT

> **TL;DR** Late-interaction retrieval model that keeps per-token embeddings for each document and scores query-document similarity via MaxSim at query time — bridging the quality of cross-encoders with the pre-computation efficiency of bi-encoders.

## Description
ColBERT (Contextualized Late Interaction over BERT) represents documents as a *matrix* of per-token vectors rather than a single pooled vector. At query time it computes a MaxSim score: for each query token, find the maximum cosine similarity across all document tokens, then sum. This late interaction captures fine-grained term-level matches that single-vector bi-encoders miss.

**ColBERT v2** adds distillation from a cross-encoder teacher and denoised supervision, achieving stronger accuracy with compressed residual vector storage (PLAID engine).

### Architecture summary
- Query and document encoders share a BERT backbone.
- Documents: matrix `D ∈ ℝ^(n × d)` (n tokens, d dims), stored in a compressed index.
- Query: matrix `Q ∈ ℝ^(m × d)` computed at runtime.
- Score: `Σ_i max_j (Q_i · D_j)` (MaxSim).

## Multimodal extensions
The [[IRPAPERS]] benchmark evaluates **ColModernVBERT** (250M params), a late-interaction model that applies the ColBERT paradigm to page *images* rather than text tokens. **ColPali** and **ColQwen2** are larger multimodal variants. On IRPAPERS they achieve 43 % Recall@1 (images alone) vs. 46 % for text hybrid, with multimodal fusion reaching 49 %. [[shorten2026irpapers]]

## When to use it
- ✅ Higher retrieval accuracy needed beyond single-vector bi-encoders, without full cross-encoder latency.
- ✅ Token-level precision matters (e.g., technical or scientific text with specific terminology).
- ✅ Multimodal document retrieval (ColModernVBERT / ColPali for image-heavy corpora).
- ❌ Storage-constrained: ColBERT indexes are 10–20× larger than single-vector indexes.
- ❌ Simpler pipelines where bi-encoder quality is sufficient.

## Related pages
- [[Dense Retrieval]]
- [[Embeddings]]
- [[Reranking]]
- [[IRPAPERS]]
- [[Hybrid Search]]

## Sources
- [[shorten2026irpapers]]
