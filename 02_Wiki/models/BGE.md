---
type: model
aliases: [BAAI/bge, bge-large-en-v1.5, bge-m3, BGE-VL, BAAI/BGE-VL]
tags: [rag, model, embedding]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[emonet2024sparql]]", "[[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]"]
---

# BGE

> **TL;DR** Family of dense embedding models from BAAI (Beijing Academy of AI), frequently used as the retriever backbone in RAG pipelines for their strong performance on MTEB benchmarks.

## Description
BGE (BAAI General Embedding) models are bi-encoder [[Dense Retrieval]] models. Key variants:
- **bge-large-en-v1.5** — 335 M params, English, high accuracy; used in [[emonet2024sparql]] via the `fastembed` library for indexing SPARQL examples and ShEx class labels.
- **bge-m3** — multilingual, supports dense + sparse + ColBERT retrieval in one model.
- **bge-reranker-*** — cross-encoder rerankers for the [[Reranking]] step.

They are served via HuggingFace and wrapped by libraries like `fastembed` for lightweight inference.

## BGE-VL — multimodal variants
BAAI also releases **BGE-VL** (Vision-Language) variants for [[Multimodal Embeddings]], mapping text and images into a shared embedding space: [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

| Model | Params | Notes |
|-------|--------|-------|
| BGE-VL-base | 0.1B | Lightweight text + image |
| BGE-VL-large | 0.4B | Better quality, still efficient |
| BGE-VL-MLLM-S1 | 8B | Full-scale multimodal |
| BGE-VL-MLLM-S2 | 8B | Second-stage fine-tuned variant |
| BGE-VL-v1.5-zs | 8B | Zero-shot generalisation variant |
| BGE-VL-Screenshot | 4B | Optimised for document screenshot retrieval |

## When to use it
- ✅ Strong English retrieval quality needed without fine-tuning.
- ✅ `fastembed` integration for lightweight Python deployments.
- ❌ Multilingual or code-heavy corpora — prefer bge-m3 or [[E5]]-multilingual.

## Sources
- [[emonet2024sparql]]
- [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]
