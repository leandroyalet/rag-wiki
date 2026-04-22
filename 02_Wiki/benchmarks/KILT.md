---
type: benchmark
aliases: [Knowledge Intensive Language Tasks]
tags: [benchmark, rag, retrieval, knowledge-intensive, qa]
status: stub
created: 2026-04-21
updated: 2026-04-21
sources: ["[[oche2025ragsurvey]]"]
homepage: https://github.com/facebookresearch/KILT
repo: https://github.com/facebookresearch/KILT
docs: 
year: 2021
---

# KILT

> **TL;DR** A unified benchmark covering 11 knowledge-intensive NLP tasks — QA, slot filling, fact-checking, dialogue, and entity linking — all grounded against the same Wikipedia snapshot, enabling apples-to-apples comparison of retrieval systems.

## What it measures
KILT (Knowledge Intensive Language Tasks) evaluates retrieval-augmented systems across a wide range of tasks that require external knowledge. All tasks share a common Wikipedia knowledge source (the same 2019-08-01 dump), ensuring that retrieval quality differences between systems are not confounded by different corpora. [[oche2025ragsurvey]]

## Tasks included
| Task type | Datasets |
|-----------|---------|
| Open-domain QA | Natural Questions, TriviaQA, ELI5, HotpotQA |
| Slot filling | T-REx, Zero-Shot RE |
| Fact checking | FEVER |
| Entity linking | AY2 |
| Dialogue | Wizard of Wikipedia |

## Metrics
- **R-Precision**: retrieval metric measuring whether the gold provenance page is in the retrieved set.
- Task-specific generation metrics: Exact Match / F1 (QA), ROUGE (dialogue/ELI5), accuracy (FEVER/entity linking).
- Combined score: tasks are often reported individually and as an average.

## Dataset / Test collection
Unified Wikipedia snapshot used as the knowledge source across all tasks. Gold provenances (Wikipedia page + paragraph) are provided for all training examples, enabling both retrieval and generation supervision.

## Reported baselines
A single RAG pipeline (DPR retriever + BART generator) performs competitively across all 11 tasks, demonstrating that unified retrieval-augmented architectures generalize across diverse knowledge-intensive tasks. [[oche2025ragsurvey]]

## Limitations / caveats
- Wikipedia-only knowledge source; not suitable for evaluating domain-specific (medical, legal, enterprise) retrieval.
- Static 2019 snapshot; knowledge freshness is not evaluated.
- Does not cover multi-hop reasoning tasks that require chaining across multiple Wikipedia articles.

## Related benchmarks
- [[BEIR]] — multi-domain retrieval benchmark; focuses on retrieval quality, not generation.
- [[MTEB]] — embedding benchmark; Retrieval tab overlaps with some KILT QA datasets.

## Sources
- [[oche2025ragsurvey]]
