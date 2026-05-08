---
type: method
aliases: [re-ranking, cross-encoder reranking, two-stage retrieval]
tags: [rag, method, retrieval, ranking]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: ["[[01_Sources/web_clips/embedding-models-for-rag]]", "[[oche2025ragsurvey]]", "[[01_Sources/web_clips/Contextual Retrieval in AI Systems]]", "[[01_Sources/web_clips/How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI]]"]
introduced_by: 
year: 
---

# Reranking

> **TL;DR** A second-stage pass that rescores a small candidate set from the bi-encoder with a slower but more accurate cross-encoder, improving precision before passing context to the LLM.

## Problem it solves
Bi-encoder [[Dense Retrieval]] is fast but approximate — its single pooled vector can't model fine-grained query-document interactions. Reranking adds an accurate second pass over a small candidate set (~100 docs) without the prohibitive cost of full cross-encoding across millions of documents. Directly addresses **FP2** (missed top-ranked docs) from the [[RAG Failure Points]] taxonomy.

## Key idea
**Two-stage pipeline:**
1. **Recall stage** (bi-encoder + ANN): fast retrieval of top-k candidates (k = 50–200). High recall, moderate precision.
2. **Precision stage** (cross-encoder): jointly encodes query + each candidate, outputs a relevance score 0–1. Slow per pair but run only over the small candidate set.

The cross-encoder sees both query and document simultaneously — enabling token-level interaction that bi-encoders miss (e.g., exact number or name matching). [[01_Sources/web_clips/embedding-models-for-rag]]

## Pipeline / Steps
1. Retrieve top-k (e.g., 100) with the bi-encoder.
2. For each candidate, run `reranker.score(query, document)`.
3. Sort by reranker score descending.
4. Pass top-n (e.g., 3–10) reranked documents as LLM context.

## Reference implementations
- **Models**: `cross-encoder/ms-marco-MiniLM-L-6-v2` (sentence-transformers), Cohere Rerank API, Jina Reranker v2, BGE-Reranker, **Qwen Reranker**. [[01_Sources/web_clips/How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI]]
- **LangChain**: `CohereRerank` document compressor.
- **LlamaIndex**: `SentenceTransformerRerank` node postprocessor.
- **Haystack**: `TransformersSimilarityRanker` component.

## Reported results
Two-stage retrieval (dense + rerank) substantially improves precision on knowledge-intensive benchmarks vs. single-stage. [[oche2025ragsurvey]] On [[BEIR]], cross-encoder reranking typically adds 5–15 % NDCG@10 over the bi-encoder baseline.

Anthropic tested reranking as the final stage in a [[Contextual Retrieval]] pipeline (Contextual Embeddings + Contextual BM25 + Reranking using **Cohere Rerank**), reducing top-20 retrieval failures from 5.7% to **1.9%** — a 67% reduction vs. the embedding-only baseline. [[01_Sources/web_clips/Contextual Retrieval in AI Systems]]

## Recall vs. precision framing
Reranking improves *both* dimensions simultaneously [[01_Sources/web_clips/How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI]]:
- **Recall**: puts relevant documents that ranked below the original top-k back into the final set.
- **Precision**: pushes irrelevant documents that ranked in the top-k back out of the final set.

### LLM verification (alternative/complement)
A simpler precision filter: pass each retrieved chunk through an LLM judge that classifies it as relevant or not. Keeps only positively-classified chunks. Trade-off: higher cost and added latency per query. [[01_Sources/web_clips/How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI]]

## Multimodal reranking
As of 2026, cross-encoder reranking extends to mixed-modality inputs — a text query can be ranked against image, text, or combined (text + image) documents within a single `rank()` call. This is the precision stage of a visual document RAG pipeline: [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

```python
from sentence_transformers import CrossEncoder

model = CrossEncoder("Qwen/Qwen3-VL-Reranker-2B")
rankings = model.rank("revenue growth chart", [
    "path/to/slide_revenue.png",          # image
    "Annual revenue grew 14% in Q3.",     # text
    {"text": "Q3 results", "image": "path/to/chart.png"},  # combined
])
```

Key multimodal rerankers: **Qwen3-VL-Reranker-2B/8B** (text, image, video), **nvidia/llama-nemotron-rerank-vl-1b-v2** (text, image), **jinaai/jina-reranker-m0** (text, image). [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]

## When to use / when not to
- ✅ Retrieval precision is the bottleneck — top-k from the bi-encoder is noisy.
- ✅ Context window is tight — fewer, better chunks are worth the latency.
- ✅ Latency budget allows an extra 50–200 ms model call.
- ❌ Very low-latency requirements — cross-encoder adds meaningful overhead.
- ❌ Large candidate sets (>500) — [[ColBERT]] late-interaction is a better trade-off.

## Related / alternatives
- [[Dense Retrieval]] — the first-stage retriever reranking improves.
- [[Hybrid Search]] — dense + sparse fusion often combined with reranking.
- [[ColBERT]] — late-interaction model achieving reranker quality at bi-encoder speed.
- [[Context Relevance]] — the evaluation metric reranking is designed to improve.

## Sources
- [[01_Sources/web_clips/embedding-models-for-rag]]
- [[oche2025ragsurvey]]
- [[01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers]]
