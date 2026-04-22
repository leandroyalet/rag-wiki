---
type: project
status: active
created: 2026-04-18
updated: 2026-04-18
leads: []
tags: [project, eval, benchmark]
---

# rag-benchmark-suite

## Goal
Build a reproducible protocol to compare RAG techniques (naive, hybrid, HyDE, reranking) on **our own corpus** with [[RAGAS]] metrics.

## Research question
Which combination of techniques gives the best quality / latency / cost trade-off on a technical corpus with domain-specific jargon?

## Hypotheses
- H1: [[Hybrid Search]] will beat pure [[Dense Retrieval]] on our corpus due to the volume of technical terms and acronyms.
- H2: [[HyDE]] will help with short queries and hurt well-formed long queries.
- H3: [[Reranking]] will have a bigger impact than adding more query-rewriting techniques.

## Current status
Project just started. Pending: build the test set, choose the base embedding model.

## Deliverables
- [ ] Curated test set (~100 queries with reference answers).
- [ ] Reproducible pipeline (scripts + notebook).
- [ ] Comparative report with tables and figures.
- [ ] Documented decision on the team's default stack.

## Experiments
- [[experiments/exp-01-baselines|Experiment 1 — Baselines]] _(pending)_

## Key sources
- [[lewis2020rag]]
- [[gao2023hyde]]
- [[karpukhin2020dpr]]

## Decision log

### 2026-04-18
- Project created. Leads still to be assigned.

## Related meetings
- _(pending)_
