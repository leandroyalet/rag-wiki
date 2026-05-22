---
type: method
aliases: [RAG Fusion, multi-query RAG]
tags: [rag, method, query-expansion, retrieval]
status: stub
created: 2026-04-18
updated: 2026-05-16
sources: ["[[01_Sources/web_clips/Building the Entire RAG Ecosystem and Optimizing Every Component]]"]
introduced_by: Zackary Rackauckas
year: 2023
---

# RAG-Fusion

> **TL;DR** Generate N query variants with an LLM, retrieve for each independently, then merge all result lists with Reciprocal Rank Fusion — improving recall without modifying the retriever.

## Problem it solves
A single query formulation misses relevant documents that use different vocabulary or framing. Alternative phrasings of the same question retrieve complementary evidence. RAG-Fusion exploits this without modifying the underlying retriever.

## Key idea
Treat the user's query as one perspective among many. Generate N alternative phrasings, run [[Dense Retrieval]] for each, and fuse the ranked lists with **Reciprocal Rank Fusion (RRF)**:

```
RRF_score(d) = Σ_i  1 / (k + rank_i(d))
```

`k` is a smoothing constant (typically 60); `rank_i(d)` is document `d`'s rank in the i-th result list. Documents appearing high across multiple query variants accumulate the highest scores.

## Pipeline / Steps
1. User submits query `q`.
2. LLM generates N–1 alternative queries (total N including original).
3. Retrieve top-k candidates for each of the N queries independently.
4. Apply RRF to merge all N lists into one ranked set.
5. Pass top-n fused documents to the LLM for generation.

## Reference implementations
- **LangChain**: `MultiQueryRetriever` performs steps 2–4 natively.
- **LlamaIndex**: `QueryFusionRetriever` with `mode="reciprocal_rerank"`.

## When to use / when not to
- ✅ Short or ambiguous queries — multiple phrasings broaden vocabulary coverage.
- ✅ Corpus has diverse writing styles where one embedding doesn't generalise.
- ❌ Latency-critical: N retrieval passes + 1 LLM generation for variants add overhead.
- ❌ Small, well-aligned corpora — marginal gain over single-query retrieval.

## Related / alternatives
- [[Query Expansion]] — parent concept; RAG-Fusion is a concrete implementation using RRF.
- [[HyDE]] — alternative expansion: generates a hypothetical answer document instead of query variants.
- [[Reranking]] — applies after retrieval to re-score candidates; complementary to RAG-Fusion.
- [[Hybrid Search]] — also merges multiple ranked lists (dense + sparse), using the same RRF mechanism.

## Sources
- [[01_Sources/web_clips/Building the Entire RAG Ecosystem and Optimizing Every Component]] — covers RAG-Fusion with k=60 RRF default and LangChain `MultiQueryRetriever` implementation.

> [!todo] Source needed — Rackauckas 2023 original blog post; no paper in 01_Sources/
