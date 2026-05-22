---
type: benchmark
aliases: [Benchmarking IR, Heterogeneous Retrieval Benchmark]
tags: [rag, eval, benchmark, retrieval]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: ["[[oche2025ragsurvey]]"]
homepage: https://github.com/beir-cellar/beir
repo: https://github.com/beir-cellar/beir
docs: 
year: 2021
---

# BEIR

> **TL;DR** A heterogeneous retrieval benchmark covering 18 datasets across 9 diverse domains — the standard zero-shot transfer test for dense and sparse retrieval models.

## What it measures
BEIR (Benchmarking Information Retrieval) evaluates retrieval models on their ability to generalize across diverse domains and task types without domain-specific fine-tuning. It exposes the gap between in-domain retrieval performance (e.g., MS MARCO) and out-of-domain generalization. [[oche2025ragsurvey]]

## Datasets
18 datasets spanning 9 domains and task types:

| Domain | Datasets |
|--------|---------|
| Web / News | TREC-COVID, NFCorpus, HotpotQA |
| Wikipedia QA | Natural Questions, FiQA-2018, DBPedia |
| Bio / Medical | BioASQ, TREC-COVID, NFCorpus |
| Argument / Fact | FEVER, Climate-FEVER, SciFact, Touché-2020 |
| Scientific | SCIDOCS, CQADupStack |
| Other | ArguAna, Quora, Signal-1M |

## Metrics
| Metric | Description |
|--------|-------------|
| **[[NDCG]]@10** | Primary metric — normalized discounted cumulative gain at rank 10 |
| Recall@100 | Coverage metric — fraction of relevant docs in top 100 |
| MRR@10 | Mean reciprocal rank; used for single-answer tasks |

## Reported baselines
- **[[BM25]]**: surprisingly strong baseline, especially on keyword-heavy domains.
- **Dense models (DPR, ANCE, TAS-B)**: strong on in-domain tasks, often weaker than [[BM25]] on out-of-domain BEIR datasets.
- **Hybrid ([[BM25]] + dense)**: consistently best across domains. See [[Hybrid Search]].
- Models on the [[MTEB]] Retrieval tab are evaluated on BEIR datasets.

## Limitations / caveats
- Static snapshot: datasets are fixed and well-known to model developers, risking overfitting.
- Binary relevance judgments (relevant / not relevant) — nuanced relevance not captured.
- Does not evaluate generation quality — retrieval-only benchmark.
- Does not cover visual or multimodal retrieval (see [[IRPAPERS]]).

## Related benchmarks
- [[MTEB]] — broader embedding benchmark; Retrieval tab uses BEIR datasets.
- [[KILT]] — knowledge-intensive NLP tasks including both retrieval and generation evaluation.
- [[IRPAPERS]] — page-level visual + text retrieval for scientific papers.

## Sources
- [[oche2025ragsurvey]]
