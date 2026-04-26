---
type: tool
aliases: [VERA framework, Validation and Evaluation of Retrieval-Augmented Systems]
tags: [rag, tool, evaluation]
status: stub
created: 2026-04-26
updated: 2026-04-26
sources: ["[[ding2024vera]]"]
homepage:
repo:
---

# VERA

> **TL;DR** A RAG evaluation framework that consolidates multiple metrics into a single cross-encoder ranking score and adds Bootstrap confidence bounds — providing statistical rigour absent from RAGAS-style metric suites.

## What it is
VERA (Validation and Evaluation of Retrieval-Augmented Systems) is a framework that evaluates RAG pipelines across four standard dimensions, then adds two innovations: a cross-encoder to aggregate the scores into a single comparable ranking, and Bootstrap statistics to quantify reliability and assess repository topical coverage. [[ding2024vera]]

## Metrics
| Metric | Phase | What it measures |
|--------|-------|-----------------|
| **Faithfulness** | Generation | Answer is grounded in retrieved context, not fabricated |
| **Retrieval Recall** | Retrieval | All relevant documents retrieved |
| **Retrieval Precision** | Retrieval | Retrieved documents are relevant (no noise) |
| **Answer Relevance** | Generation | Answer directly addresses the query |

[[ding2024vera]]

## Key innovations

### 1 — Cross-encoder composite ranking
Each metric score is enhanced with a natural-language description of what it measures, then the enriched answer + original query are fed to a **cross-encoder** (ms-marco-MiniLM-L-12-v2) to produce a single aggregated logit score. This enables direct comparison across RAG configurations without manually weighting individual metrics, and avoids the "compensatory effect" where a high faithfulness score masks poor retrieval recall. [[ding2024vera]]

### 2 — Bootstrap confidence bounds
VERA computes metric values across B bootstrap samples of the document repository:
1. Draw random samples with replacement from the repository evaluation set.
2. Compute metric mean and variance across samples.
3. Report 95% CI from the 2.5th and 97.5th percentiles of the bootstrap distribution.

This accounts for LLM stochasticity and validates **topical coverage**: domain-relevant queries score measurably higher than random queries, confirming the repository contains the right content. [[ding2024vera]]

## Results (MS MARCO TREC 2023)
| Retriever + Generator | Faithfulness | Relevance | Recall | Precision |
|-----------------------|-------------|-----------|--------|-----------|
| Llama3 + e5-mistral-7b | **0.94** | **0.87** | 0.76 | 0.68 |
| Haiku + e5-mistral-7b | 0.95 | 0.85 | 0.75 | 0.65 |
| T-5 Flan (baseline) | 0.82 | 0.53 | 0.61 | 0.50 |

[[ding2024vera]]

## Comparison with similar tools
| Capability | VERA | [[RAGAS]] | [[ARES]] | [[DeepEval]] |
|------------|------|-----------|----------|--------------|
| Reference-free | ✅ | ✅ | ✅ | ✅ |
| Single composite score | ✅ | ❌ | ❌ | ❌ |
| Statistical confidence bounds | ✅ | ❌ | Partial (PPI) | ❌ |
| Repository coverage validation | ✅ | ❌ | ❌ | ❌ |
| Human-annotation calibration | ❌ | ❌ | ✅ | ❌ |

## When to use it
- ✅ Need to rank multiple RAG configurations with a single comparable score.
- ✅ Want statistical confidence on evaluation metrics (noisy LLM judges).
- ✅ Validating that an indexed repository covers the target domain before deployment.
- ❌ Need per-metric transparency rather than a composite score.
- ❌ Require calibration against human judgements — use [[ARES]] instead.

## Related pages
- [[RAGAS]]
- [[ARES]]
- [[DeepEval]]
- [[TruLens]]
- [[LLM-as-Judge]]
- [[Faithfulness]]
- [[Answer Relevance]]

## Sources
- [[ding2024vera]]
