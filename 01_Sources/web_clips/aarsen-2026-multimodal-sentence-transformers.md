---
title: "Multimodal Embedding & Reranker Models with Sentence Transformers"
source: "https://huggingface.co/blog/multimodal-sentence-transformers"
author:
  - "Tom Aarsen"
published: 2026-04-09
created: 2026-05-08
description: "Introduces Sentence Transformers v5.4 multimodal capabilities — encoding and reranking across text, images, audio, and video in a shared embedding space using the same API."
tags:
  - clippings
---

# Multimodal Embedding & Reranker Models with Sentence Transformers

## Overview

Sentence Transformers v5.4 introduces multimodal capabilities, enabling encoding and comparison of texts, images, audio, and videos using the same familiar API. Multimodal embedding models map inputs from different modalities into a shared embedding space, while multimodal reranker models score the relevance of mixed-modality pairs.

## Installation

```bash
pip install -U "sentence-transformers[image]"
pip install -U "sentence-transformers[audio]"
pip install -U "sentence-transformers[video]"
pip install -U "sentence-transformers[image,video,train]"
```

Hardware Requirements: VLM-based models like Qwen3-VL require ~8 GB VRAM (minimum). 8B variants need ~20 GB. CPU inference is extremely slow.

## Multimodal Embedding Models

### Loading and Encoding

```python
from sentence_transformers import SentenceTransformer

model = SentenceTransformer("Qwen/Qwen3-VL-Embedding-2B")

img_embeddings = model.encode([
    "https://example.com/car.jpg",
    "https://example.com/bee.jpg",
])
# shape: (2, 2048)
```

### Cross-Modal Similarity

```python
text_embeddings = model.encode(["A green car parked near a building", "A bee on a flower"])
similarities = model.similarity(text_embeddings, img_embeddings)
```

**Key finding — modality gap**: cross-modal similarities are systematically lower than within-modal ones, but relative ordering is preserved for retrieval purposes.

### encode_query / encode_document

For retrieval tasks, use `encode_query()` and `encode_document()` which apply the correct instruction prompts:

```python
query_embeddings = model.encode_query(["Find me a photo of a vehicle near a building"])
doc_embeddings = model.encode_document(["path/to/image.jpg"])
similarities = model.similarity(query_embeddings, doc_embeddings)
```

## Multimodal Reranker Models

```python
from sentence_transformers import CrossEncoder

model = CrossEncoder("Qwen/Qwen3-VL-Reranker-2B")
query = "A green car parked in front of a yellow building"
documents = [
    "https://example.com/car.jpg",         # image URL
    "A vintage Volkswagen painted green.",  # text
    {"text": "A car in a European city", "image": "https://example.com/car.jpg"},  # text + image
]
rankings = model.rank(query, documents)
```

Scores example: image doc 0.9375 > combined 0.5000 > text -1.25 > wrong image -2.44.

## Retrieve and Rerank Pipeline

```python
from sentence_transformers import SentenceTransformer, CrossEncoder

embedder = SentenceTransformer("Qwen/Qwen3-VL-Embedding-2B")
query_embedding = embedder.encode_query("revenue growth chart")
corpus_embeddings = embedder.encode_document(document_screenshots)

similarities = embedder.similarity(query_embedding, corpus_embeddings)
top_k_indices = similarities.argsort(descending=True)[0][:10]

reranker = CrossEncoder("nvidia/llama-nemotron-rerank-vl-1b-v2", trust_remote_code=True)
top_k_documents = [document_screenshots[i] for i in top_k_indices]
rankings = reranker.rank(query, top_k_documents)
```

## Supported Input Formats

| Modality | Accepted Formats |
|----------|-----------------|
| Text | Strings |
| Image | PIL.Image, file paths, URLs, numpy arrays, torch tensors |
| Audio | File paths, URLs, numpy/torch arrays, dicts with `array` + `sampling_rate` |
| Video | File paths, URLs, numpy/torch arrays, dicts with `array` + `video_metadata` |
| Multimodal | Dicts mapping modality names to values |
| Message | List of dicts with `role` and `content` |

## Multimodal Embedding Models (as of April 2026)

| Model | Params | Modalities |
|-------|--------|-----------|
| Qwen/Qwen3-VL-Embedding-2B | 2B | Text, Image, Video |
| Qwen/Qwen3-VL-Embedding-8B | 8B | Text, Image, Video |
| nvidia/llama-nemotron-embed-vl-1b-v2 | 1.7B | Text, Image |
| nvidia/omni-embed-nemotron-3b | 4.7B | Text, Image |
| LCO-Embedding/LCO-Embedding-Omni-3B | 5B | Text, Image, Audio, Video |
| LCO-Embedding/LCO-Embedding-Omni-7B | 9B | Text, Image, Audio, Video |
| BidirLM/BidirLM-Omni-2.5B-Embedding | 2.5B | Text, Image, Audio |
| BAAI/BGE-VL-base | 0.1B | Text, Image |
| BAAI/BGE-VL-large | 0.4B | Text, Image |
| BAAI/BGE-VL-MLLM-S1 | 8B | Text, Image |
| BAAI/BGE-VL-MLLM-S2 | 8B | Text, Image |
| BAAI/BGE-VL-v1.5-zs | 8B | Text, Image |
| BAAI/BGE-VL-Screenshot | 4B | Text, Image |
| royokong/e5-v | 8B | Text, Image |
| nomic-ai/nomic-embed-multimodal-3b | 5B | Text, Image |
| Haon-Chen/e5-omni-3B | 5B | Text, Image, Audio, Video |
| Haon-Chen/e5-omni-7B | 9B | Text, Image, Audio, Video |

## Multimodal Reranker Models

| Model | Params | Modalities |
|-------|--------|-----------|
| Qwen/Qwen3-VL-Reranker-2B | 2B | Text, Image, Video |
| Qwen/Qwen3-VL-Reranker-8B | 8B | Text, Image, Video |
| nvidia/llama-nemotron-rerank-vl-1b-v2 | 2B | Text, Image |
| jinaai/jina-reranker-m0 | 2B | Text, Image |

## CLIP Models (Legacy)

| Model | ImageNet Zero-Shot Top-1 |
|-------|--------------------------|
| clip-ViT-L-14 | 75.4% |
| clip-ViT-B-16 | 68.1% |
| clip-ViT-B-32 | 63.3% |
| clip-ViT-B-32-multilingual-v1 | N/A (50+ languages) |

## Key Takeaways

1. Unified API — same methods for text, images, audio, video
2. Modality gap — cross-modal similarities lower than within-modal, but ordering preserved
3. Flexible input — URLs, file paths, PIL Images, numpy arrays
4. Retrieve & Rerank pattern is the standard pipeline for visual document search
5. 20+ multimodal embedding models and 4+ multimodal rerankers available
6. GPU required for VLM-based models; CLIP models are lighter weight
