---
title: "Sentence Transformers — Library Overview & Sparse Encoder Documentation"
source: "https://sbert.net/index.html"
author:
  - "UKP Lab / Hugging Face"
published:
created: 2026-05-08
description: "Official documentation landing page for the Sentence Transformers library, covering dense embedding, reranking, and sparse encoder model types including SPLADE."
tags:
  - clippings
---

# Sentence Transformers — Library Overview

## What It Is

Sentence Transformers (sbert.net) is the go-to Python library for computing embeddings and similarity scores. Maintained by Hugging Face (originally created by UKP Lab). Requires Python 3.10+ and PyTorch 1.11.0+.

`pip install -U sentence-transformers`

## Three Model Types

The library exposes three distinct model classes:

| Class | Purpose |
|-------|---------|
| `SentenceTransformer` | Dense embedding models — encode text/images/audio/video into fixed-size vectors |
| `CrossEncoder` | Reranker models — score query-document pairs jointly |
| `SparseEncoder` | Sparse embedding models — produce high-dimensional mostly-zero vectors |

## Key Features

- **10,000+ pretrained models** on Hugging Face Hub
- **Multimodal support** (v5.4): text, images, audio, video via `SentenceTransformer` and `CrossEncoder`
- **Training**: fine-tuning support for all three model types
- **Production optimizations**: ONNX, OpenVINO, Flash Attention 2

## Sparse Encoder Models (SPLADE)

Sparse Encoder models generate vectors where >99% of dimensions are zero. Each non-zero dimension corresponds to a specific vocabulary token, making the representation highly interpretable and efficient for inverted-index retrieval.

```python
from sentence_transformers import SparseEncoder

model = SparseEncoder("naver/splade-cocondenser-ensembledistil")
embeddings = model.encode(["The weather is lovely today."])
# Output: sparse vector with vocabulary-size dimensions (e.g., 30,522 for BERT vocab)
# Typically only dozens of non-zero dimensions per embedding
```

### Asymmetric encoding (query vs. document)
```python
query_embedding = model.encode_query("What is the weather like?")
doc_embedding = model.encode_document("The weather is lovely today.")
```

### Key SPLADE models
- `naver/splade-cocondenser-ensembledistil` — main SPLADE variant
- Inference-free SPLADE variants — faster encoding, slight quality trade-off

### Characteristics
- **Sparsity**: >99% zero dimensions; only ~30–100 active dimensions per embedding
- **Dimension count**: vocabulary-sized (e.g., 30,522 for BERT tokenizer)
- **Interpretability**: non-zero dimensions correspond to specific tokens — score breakdowns are human-readable
- **Mechanism**: an LM scores each vocabulary token's relevance to the input and expands the query/document with related terms (learned expansion)

### When to use
- ✅ Complement dense retrieval in hybrid pipelines — SPLADE provides the sparse signal
- ✅ High-throughput: sparse vectors slot into standard inverted-index infrastructure
- ✅ Interpretability needed — inspecting active tokens reveals why a document was retrieved
- ❌ Semantic-only use cases — dense embeddings capture paraphrase/synonym better

## Pretrained Model Families

| Family | Notes |
|--------|-------|
| `all-mpnet-base-v2` | Best quality general-purpose dense model |
| `all-MiniLM-L6-v2` | 5× faster, acceptable quality for most tasks |
| Multi-QA series | Trained on 215M Q&A pairs; semantic search |
| MSMARCO models | Passage ranking optimised |
| Multilingual | distiluse, paraphrase-multilingual, LaBSE (50+ languages) |
| CLIP variants | Legacy image-text alignment |
| Qwen3-VL, BGE-VL | Modern multimodal (text + image + video) |
