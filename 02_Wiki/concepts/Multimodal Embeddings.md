---
type: concept
aliases: [multimodal embedding, cross-modal embeddings, vision-language embeddings, multimodal retrieval]
tags: [rag, embedding, multimodal, retrieval, vision]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: ["[[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]"]
---

# Multimodal Embeddings

> **TL;DR** Embedding models that map text, images, audio, and video into a single shared vector space — enabling cross-modal similarity search (e.g., text query → image results) using the same cosine-similarity infrastructure as text-only RAG.

## Definition
A multimodal embedding model encodes inputs from multiple modalities (text, image, audio, video) into a **shared embedding space** where semantically related content is geometrically close, regardless of modality. This enables a text query to retrieve relevant images, or an image query to retrieve relevant documents. [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

## Context in RAG
Standard RAG retrieves text chunks. Multimodal RAG extends this to visual documents (PDFs rendered as page images, product photos, charts, slide decks) where important information is encoded in layout and visuals that text extraction cannot capture. Multimodal embeddings form the retrieval backbone of such pipelines. [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

## How it works

### Shared embedding space
Each modality encoder is trained to produce vectors in the same high-dimensional space. Contrastive training aligns corresponding pairs (caption ↔ image, question ↔ answer screenshot) while pushing non-matching pairs apart.

### encode_query / encode_document
Most multimodal retrievers expose separate methods because asymmetric instruction prompts improve recall:

```python
from sentence_transformers import SentenceTransformer

model = SentenceTransformer("Qwen/Qwen3-VL-Embedding-2B")

query_embedding = model.encode_query("revenue growth chart from Q3 report")
doc_embeddings = model.encode_document(["slide1.png", "slide2.png", "slide3.png"])

similarities = model.similarity(query_embedding, doc_embeddings)
```

[[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

### Retrieve and Rerank pipeline
The standard two-stage pattern extends naturally to visual documents:
1. **Embed** all document screenshots offline with a multimodal bi-encoder.
2. **Retrieve** top-k most similar to the query embedding (ANN search).
3. **Rerank** the top-k with a multimodal cross-encoder that jointly scores query + image.

```python
reranker = CrossEncoder("nvidia/llama-nemotron-rerank-vl-1b-v2", trust_remote_code=True)
rankings = reranker.rank(query, top_k_screenshots)
```

[[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

## The modality gap
Cross-modal similarities (text ↔ image) are systematically *lower* than within-modal similarities (text ↔ text, image ↔ image) due to the distribution gap between modalities in the shared space. This means raw cosine scores cannot be compared across modalities — but **relative ordering within a retrieval result set is preserved**, making the models usable for ranking. [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

## Key models (as of April 2026)

### Multimodal embedding models
| Model | Params | Modalities | Notes |
|-------|--------|-----------|-------|
| Qwen3-VL-Embedding-2B/8B | 2B / 8B | Text, Image, Video | Strong general-purpose; 8B needs ~20 GB VRAM |
| BAAI/BGE-VL-base/large | 0.1B / 0.4B | Text, Image | Lightweight; see [[BGE]] |
| BAAI/BGE-VL-MLLM-S1/S2 | 8B | Text, Image | Full-scale BGE-VL variants |
| BAAI/BGE-VL-Screenshot | 4B | Text, Image | Optimised for document screenshot retrieval |
| e5-v (royokong) | 8B | Text, Image | Multimodal extension of [[E5]] |
| LCO-Embedding-Omni-3B/7B | 5B / 9B | Text, Image, Audio, Video | Broadest modality coverage |
| nomic-embed-multimodal-3b/7b | 5B / 9B | Text, Image | Open-weights, no API key |
| clip-ViT-L-14 (CLIP) | — | Text, Image | Legacy; lighter weight, no GPU required |

[[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

### Multimodal reranker models
| Model | Params | Modalities |
|-------|--------|-----------|
| Qwen3-VL-Reranker-2B/8B | 2B / 8B | Text, Image, Video |
| nvidia/llama-nemotron-rerank-vl-1b-v2 | 2B | Text, Image |
| jinaai/jina-reranker-m0 | 2B | Text, Image |

[[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

## Input formats
The Sentence Transformers v5.4 API accepts images as URLs, local file paths, PIL Image objects, numpy arrays, or torch tensors — and supports mixing modalities in a single `encode()` call via dicts: `{"text": "caption", "image": "photo.jpg"}`. [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

## Hardware requirements
- VLM-based models (Qwen3-VL, BGE-VL-MLLM): GPU required; 2B variants need ~8 GB VRAM, 8B ~20 GB.
- CLIP-family models: can run on CPU; designed for lighter deployments.

## When to use
- ✅ Documents where visual layout carries meaning (charts, slides, scanned PDFs) — text extraction loses critical information.
- ✅ Image or product search alongside text search.
- ✅ Multimodal RAG pipeline answering questions over visual document corpora (see [[IRPAPERS]] for benchmark).
- ❌ Text-only corpora — standard [[Embeddings]] are cheaper and faster.
- ❌ Resource-constrained deployments — VLM-based models require substantial GPU VRAM.

## Related pages
- [[Embeddings]]
- [[Dense Retrieval]]
- [[Reranking]]
- [[Sentence-BERT]] — the library (sentence-transformers) that hosts these models
- [[BGE]] — has multimodal BGE-VL variants
- [[E5]] — has multimodal e5-v variant
- [[IRPAPERS]] — benchmark for multimodal scientific document retrieval
- [[MME]] — benchmark for multimodal LLM capabilities
- [[Hallucination in RAG]] — faithfulness failures apply equally in multimodal RAG

## Sources
- [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]
