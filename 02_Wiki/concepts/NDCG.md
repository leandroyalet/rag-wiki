---
type: concept
aliases: [nDCG, DCG, Discounted Cumulative Gain, Normalized Discounted Cumulative Gain, NDCG@10, IDCG]
tags: [rag, evaluation, retrieval, information-retrieval]
status: stub
created: 2026-05-22
updated: 2026-05-22
sources: ["[[01_Sources/web_clips/wikipedia-dcg-ndcg]]"]
---

# NDCG

> **TL;DR** Normalized Discounted Cumulative Gain — the rank-aware, graded-relevance retrieval metric that rewards placing highly relevant documents at the top of a ranked list; scores range 0–1 and are cross-query comparable. The primary metric for MTEB and BEIR.

## The metric family

### Cumulative Gain (CG)
Sum of graded relevance values — order-unaware baseline:
```
CG_p = Σ(i=1 to p) rel_i
```

### Discounted Cumulative Gain (DCG)
Applies a logarithmic position discount so that relevant documents appearing earlier contribute more:

**Industry formulation** (standard in modern benchmarks — exponential gain, emphasises highly relevant docs):
```
DCG_p = Σ(i=1 to p)  (2^rel_i − 1) / log₂(i+1)
```

**Linear formulation** (original, simpler):
```
DCG_p = Σ(i=1 to p)  rel_i / log₂(i+1)
```

Graded relevance `rel_i` is an integer (typically 0–3) reflecting how useful document *i* is to the query. [[01_Sources/web_clips/wikipedia-dcg-ndcg]]

### Ideal DCG (IDCG)
The best possible DCG — all relevant documents ranked first in descending relevance order. Used as the normaliser. [[01_Sources/web_clips/wikipedia-dcg-ndcg]]

### Normalized DCG (nDCG)
```
nDCG_p = DCG_p / IDCG_p        (range: 0.0 – 1.0)
```
1.0 = perfect ranking. nDCG@k evaluates only the top-k results. [[01_Sources/web_clips/wikipedia-dcg-ndcg]]

## Why nDCG over Precision@k / Recall@k

| Property | Precision@k / Recall@k | NDCG@k |
|----------|----------------------|--------|
| Position-aware | ❌ (all positions equal) | ✅ (logarithmic discount) |
| Graded relevance | ❌ (binary: relevant / not) | ✅ (0, 1, 2, 3 …) |
| Cross-query comparable | ❌ | ✅ (normalised by IDCG) |

[[01_Sources/web_clips/wikipedia-dcg-ndcg]]

## NDCG@10 in practice

NDCG@10 (top-10 cutoff) is the **standard metric** for IR retrieval benchmarks:
- **[[MTEB]]** retrieval tasks — primary metric across 15+ retrieval datasets.
- **[[BEIR]]** — zero-shot retrieval benchmark across 18 datasets; NDCG@10 reported for every model.

A retrieval model scoring NDCG@10 = 0.65 means the average query's actual top-10 ranking is 65% as good as the ideal ranking.

## Limitations
- Does not penalise retrieval noise (irrelevant results within the top-k are ignored as long as relevant ones rank high enough).
- Missing relevant documents outside the top-k are only captured when k is large enough.
- Graded relevance annotations are expensive to create; binary fallback (0/1) loses the graded advantage. [[01_Sources/web_clips/wikipedia-dcg-ndcg]]

## Related pages
- [[Precision and Recall]] — complementary binary metrics; together with NDCG they cover the standard retrieval evaluation toolkit
- [[BEIR]] — zero-shot retrieval benchmark; primary metric NDCG@10
- [[MTEB]] — embedding benchmark; primary retrieval metric NDCG@10
- [[Dense Retrieval]] — what NDCG measures in practice
- [[Reranking]] — a reranker's goal is to improve NDCG@k vs. the first-stage retriever

## Sources
- [[01_Sources/web_clips/wikipedia-dcg-ndcg]]
