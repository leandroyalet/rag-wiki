---
type: method
aliases: [re-ranking, cross-encoder reranking, two-stage retrieval]
tags: [rag, method, retrieval, ranking]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: ["[[01_Sources/web_clips/embedding-models-for-rag]]", "[[oche2025ragsurvey]]"]
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
- **Models**: `cross-encoder/ms-marco-MiniLM-L-6-v2` (sentence-transformers), Cohere Rerank API, Jina Reranker v2, BGE-Reranker.
- **LangChain**: `CohereRerank` document compressor.
- **LlamaIndex**: `SentenceTransformerRerank` node postprocessor.
- **Haystack**: `TransformersSimilarityRanker` component.

## Reported results
Two-stage retrieval (dense + rerank) substantially improves precision on knowledge-intensive benchmarks vs. single-stage. [[oche2025ragsurvey]] On [[BEIR]], cross-encoder reranking typically adds 5–15 % NDCG@10 over the bi-encoder baseline.

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
