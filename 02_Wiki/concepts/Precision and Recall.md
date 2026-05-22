---
type: concept
aliases: [precision, recall, F1, F-measure, Fβ, F-score, true positive rate, positive predictive value, sensitivity]
tags: [rag, evaluation, retrieval, information-retrieval]
status: stub
created: 2026-05-22
updated: 2026-05-22
sources: ["[[01_Sources/web_clips/wikipedia-precision-recall]]"]
---

# Precision and Recall

> **TL;DR** The two fundamental retrieval quality metrics — precision measures what fraction of retrieved results are relevant; recall measures what fraction of all relevant results were retrieved — jointly captured by the F1 score.

## Definitions

Using a confusion matrix with true positives (tp), false positives (fp), and false negatives (fn):

| Metric | Formula | Answers |
|--------|---------|---------|
| **Precision** | `tp / (tp + fp)` | "Of everything I retrieved, how much was relevant?" |
| **Recall** | `tp / (tp + fn)` | "Of all relevant things, how much did I find?" |
| **F1** | `2·P·R / (P + R)` | Harmonic mean — penalises extreme imbalance |

**Confusion matrix**:

|  | Predicted relevant | Predicted irrelevant |
|--|---|---|
| **Actually relevant** | TP | FN (miss) |
| **Actually irrelevant** | FP (false alarm) | TN |

[[01_Sources/web_clips/wikipedia-precision-recall]]

## The precision-recall trade-off
Lowering a retrieval threshold returns more documents, increasing recall but decreasing precision (more false alarms). Raising the threshold does the reverse. This is the fundamental trade-off in any retrieval system, including RAG retrievers. [[01_Sources/web_clips/wikipedia-precision-recall]]

- **Optimise for recall** when missing a relevant result is costly (e.g., medical literature search, safety audits).
- **Optimise for precision** when noisy context harms generation quality (e.g., short-context RAG where every retrieved chunk matters).

## Weighted F-measure (Fβ)
```
Fβ = (1 + β²) · (P · R) / (β²·P + R)
```
- β > 1 weights recall more heavily.
- β < 1 weights precision more heavily.
- β = 1 gives standard F1.

[[01_Sources/web_clips/wikipedia-precision-recall]]

## Retrieval-specific variants

| Metric | Definition |
|--------|-----------|
| **Precision@k** | Fraction of top-k returned documents that are relevant |
| **Recall@k** | Fraction of all relevant documents appearing in top-k |
| **F1@k** | Harmonic mean of Precision@k and Recall@k |
| **HitRate@k** | Binary: 1 if ≥1 relevant document is in top-k |
| **Average Precision (AP)** | Area under the precision-recall curve over all recall levels |
| **MAP** | Mean Average Precision — AP averaged over all queries |
| **[[NDCG]]@k** | Normalised Discounted Cumulative Gain — rank-aware, graded-relevance; primary metric on MTEB and BEIR |

Precision@k and Recall@k are the standard metrics for evaluating RAG retrievers. [[Context Relevance]] operationalises Precision@k as a RAG evaluation signal. [[01_Sources/web_clips/wikipedia-precision-recall]]

## Application in RAG evaluation

| Stage | Metric(s) used | What it measures |
|-------|---------------|-----------------|
| Retrieval | Recall@k, Precision@k, NDCG@k | How well the retriever finds and ranks relevant chunks |
| Context quality | [[Context Relevance]] (≈ Precision@k on sentences) | Fraction of retrieved context that is on-topic |
| End-to-end | [[Faithfulness]], [[Answer Relevance]] | Generator quality given the retrieved context |

See [[RAGAS]] for an LLM-based implementation of these metrics without gold labels.

## Related pages
- [[Context Relevance]] — applies Precision@k at the sentence level for RAG evaluation
- [[Dense Retrieval]] — precision/recall trade-off is central to choosing k and threshold
- [[Reranking]] — improves Precision@k by re-scoring the top-k pool
- [[NDCG]] — the rank-aware, graded-relevance complement to binary precision/recall
- [[BEIR]] — benchmark that reports NDCG@10 across 18 IR datasets
- [[MTEB]] — embedding leaderboard, primary metric is NDCG@10
- [[RAGAS]] — computes context relevance as an LLM-judged precision proxy
- [[Faithfulness]]
- [[Answer Relevance]]

## Sources
- [[01_Sources/web_clips/wikipedia-precision-recall]]
