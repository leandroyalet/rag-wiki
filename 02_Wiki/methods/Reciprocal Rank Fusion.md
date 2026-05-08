---
type: method
aliases: [RRF, rank fusion]
tags: [rag, retrieval, ranking]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: []
introduced_by: "Cormack et al."
year: 2009
---

# Reciprocal Rank Fusion

> **TL;DR** Score-free rank aggregation that merges multiple ranked lists into one by summing reciprocal ranks — the standard fusion step in [[Hybrid Search]] and [[RAG-Fusion]].

## Problem it solves
When two retrievers (e.g., [[BM25]] and a dense bi-encoder) each return a ranked list, their raw scores are on incomparable scales. Normalisation heuristics are fragile. RRF sidesteps this by discarding scores entirely and using only rank positions.

## Key idea
Each document `d` receives a contribution from each ranked list `r`:

$$\text{RRF}(d) = \sum_{r \in R} \frac{1}{k + \text{rank}_r(d)}$$

`k ≈ 60` is a smoothing constant that reduces the weight advantage of rank-1 results. Documents not present in a list contribute 0. Final ranking is by descending RRF score.

## Where it appears in RAG
- **[[Hybrid Search]]** — merges BM25 and dense ANN lists.
- **[[RAG-Fusion]]** — merges lists from multiple query reformulations.
- **[[Contextual Retrieval]]** — fuses contextual embeddings + contextual BM25 lists.

## Properties
- No score calibration needed — only rank positions matter.
- Robust to outliers: a single very high-scoring result in one list cannot dominate.
- `k = 60` chosen empirically; lower values increase influence of top ranks.

## When to use / when not to
- ✅ Fusing retrievers with incompatible score distributions.
- ✅ Fusing multiple reformulated query results ([[RAG-Fusion]]).
- ❌ When raw score confidence matters (e.g., classification threshold tasks).
- ❌ When one retriever is substantially higher quality — equal weighting may hurt.

## Related
- [[Hybrid Search]]
- [[RAG-Fusion]]
- [[BM25]]
- [[Dense Retrieval]]
- [[Reranking]]

## Sources
> [!todo] Source needed — add Cormack, Clarke & Buettcher (2009) "Reciprocal Rank Fusion outperforms Condorcet and Individual Rank Learning Methods" SIGIR 2009.
