---
title: "Precision and recall — Wikipedia"
source: "https://en.wikipedia.org/wiki/Precision_and_recall"
author:
  - "Wikipedia contributors"
published:
created: 2026-05-22
description: "Wikipedia reference article covering precision, recall, F-measure, confusion matrix framework, and retrieval-specific variants (Precision@k, Recall@k)."
tags:
  - clippings
---

# Precision and recall

## Core definitions

**Precision** (positive predictive value) — fraction of retrieved instances that are actually relevant:

```
Precision = tp / (tp + fp)
```

**Recall** (sensitivity) — fraction of all relevant instances that were successfully retrieved:

```
Recall = tp / (tp + fn)
```

Where:
- **tp** = true positives (relevant and retrieved)
- **fp** = false positives (retrieved but not relevant)
- **fn** = false negatives (relevant but not retrieved)

## Confusion matrix

|  | Predicted positive | Predicted negative |
|--|---|---|
| **Actually positive** | True Positive (TP) | False Negative (FN) — Type II error |
| **Actually negative** | False Positive (FP) — Type I error | True Negative (TN) |

## F-measure

Harmonic mean of precision and recall:

```
F1 = 2 · (precision · recall) / (precision + recall)
```

Weighted variant (Fβ) allows emphasis adjustment:

```
Fβ = (1 + β²) · (precision · recall) / (β² · precision + recall)
```

- β > 1 prioritises recall (e.g., β=2 for medical screening where missing a case is costly).
- β < 1 prioritises precision (e.g., β=0.5 for spam filters where false alarms are costly).

## Key properties

- **Inverse trade-off**: lowering a classification threshold increases recall at the cost of precision and vice versa.
- **Probabilistic interpretation**: Precision = P(actually positive | predicted positive); Recall = P(predicted positive | actually positive).
- **Imbalanced data**: standard accuracy is misleading when one class is rare; balanced accuracy = (TPR + TNR) / 2 normalises by class frequency.

## Practical heuristics

| Domain | Priority | Rationale |
|--------|----------|-----------|
| Medical screening | **Recall** | Missing a true case (FN) is more costly than a false alarm |
| Criminal justice | **Precision** | Wrongful conviction (FP) is more harmful than letting a guilty party go |
| Information retrieval | **Both** | Measured jointly via F1 or separately at rank k |

## Retrieval-specific variants

- **Precision@k** — fraction of the top-k retrieved documents that are relevant.
- **Recall@k** — fraction of all relevant documents that appear in the top-k.
- **F1@k** — harmonic mean of Precision@k and Recall@k.
- **Average Precision (AP)** — area under the precision-recall curve; macro-averaged across queries = MAP.
- **HitRate@k** — binary; 1 if at least one relevant document is in the top-k.

## Multi-class extension

Per-class precision and recall computed with one-vs-rest, aggregated as macro F1 (unweighted mean) or micro F1 (pooled TP/FP/FN).
