---
title: "Discounted cumulative gain — Wikipedia"
source: "https://en.wikipedia.org/wiki/Discounted_cumulative_gain"
author:
  - "Wikipedia contributors"
published:
created: 2026-05-22
description: "Wikipedia reference article covering Cumulative Gain, Discounted Cumulative Gain (DCG), Ideal DCG (IDCG), and Normalized DCG (nDCG) — the rank-aware retrieval evaluation metric used in MTEB, BEIR, and most IR benchmarks."
tags:
  - clippings
---

# Discounted cumulative gain

## Cumulative Gain (CG)

Sum of graded relevance values across the top-p results, ignoring position:

```
CG_p = Σ(i=1 to p) rel_i
```

Reordering results does not change CG — it is order-unaware.

## Discounted Cumulative Gain (DCG)

Penalises relevant documents appearing lower in the ranking by dividing by a logarithmic position discount:

**Original formulation:**
```
DCG_p = Σ(i=1 to p)  rel_i / log₂(i+1)
```

**Industry / Kaggle formulation** (emphasises highly relevant documents more strongly):
```
DCG_p = Σ(i=1 to p)  (2^rel_i − 1) / log₂(i+1)
```

The industry formulation is more widely used in modern IR benchmarks and competitions.

Graded relevance values are typically integers on a 0–3 or 0–4 scale measuring document usefulness.

## Ideal DCG (IDCG)

The maximum possible DCG — documents ranked in descending relevance order:

```
IDCG_p = Σ(i=1 to |REL_p|)  (2^rel_i − 1) / log₂(i+1)
```

where REL_p is the list of truly relevant documents sorted by descending relevance.

## Normalized DCG (nDCG)

Divides actual DCG by IDCG, enabling cross-query comparison:

```
nDCG_p = DCG_p / IDCG_p
```

- Range: [0.0, 1.0]; 1.0 = perfect ranking.
- Cross-query comparable: a query with few relevant documents is not penalised relative to one with many.

## Key properties

- Position-sensitive: a relevant document at rank 1 contributes more than the same document at rank 5.
- Graded relevance: unlike binary Precision/Recall, different relevance levels are distinguished.
- Normalised: nDCG scores from different queries can be meaningfully averaged.
- Logarithmic base affects absolute DCG values but **not** nDCG comparisons (for the linear formulation).

## Limitations

1. Does not penalise irrelevant results within the evaluated set (only measures what is found, not noise).
2. Missing relevant documents are only penalised when a fixed cutoff k is enforced (nDCG@k).
3. Not ideal for queries with multiple equally valid answers at shallow evaluation depths.

## Relation to other metrics

- Extends [[Precision and Recall]] with position-sensitivity and graded relevance.
- Complements MAP (Mean Average Precision): MAP is rank-aware but binary; nDCG handles graded relevance.
- nDCG@10 is the primary metric for MTEB retrieval tasks and BEIR.
