---
type: paper
citekey: agrawal2025cag
title: "Enhancing Cache-Augmented Generation (CAG) with Adaptive Contextual Compression for Scalable Knowledge Integration"
authors: [Rishabh Agrawal, Himanshu Kumar]
year: 2025
venue: arXiv (cs.AI / cs.IR)
url: https://arxiv.org/abs/2505.08261
pdf: "[[2505.08261v1.pdf]]"
tags: [paper, rag, cag, cache, compression, context-window]
status: summarized
added: 2026-04-19
added_by: Claude Code (/ingest)
---

# Enhancing Cache-Augmented Generation (CAG) with Adaptive Contextual Compression for Scalable Knowledge Integration

> **TL;DR** Proposes Adaptive Contextual Compression (ACC) to overcome CAG's context-window bottleneck, achieving 5–10 % BERTScore improvement over RAG baselines on HotpotQA at lower latency; a hybrid CAG-RAG mode adds a further 1–2 points.

## Why we read it
Introduces CAG as a named alternative to RAG and provides the clearest treatment of the CAG vs RAG trade-off space.

## Problem
CAG preloads curated knowledge into the context window, eliminating retrieval latency and noise — but real-world knowledge bases exceed even 32K-token windows. Without compression, CAG doesn't scale.

## Contribution
- **Adaptive Contextual Compression (ACC)**: three-component pipeline (snippet ranking → hierarchical summarization → RL policy) that achieves 75 % token reduction while preserving 95 % of task-critical content.
- **Hybrid CAG-RAG framework**: preloaded core context + selective retrieval on cache misses using FAISS.
- Empirical comparison on HotpotQA and NaturalQuestions against sparse RAG, dense RAG, and standard CAG.

## Method
- **Snippet ranking**: dual-encoder scoring with `α·(mean query similarity) + (1-α)·(offline relevance)`.
- **Hierarchical summarization**: BART-based abstraction at document / paragraph / sentence levels.
- **Policy optimization**: PPO (Proximal Policy Optimization) to learn compression decisions as MDP, balancing quality vs. token cost.
- **Cache management**: incremental updates (–70 % recompute), token truncation (10–20 % extra reduction), segmented topic-cluster loading (–30–40 % peak memory).

## Results

| Method | BERTScore (HotpotQA) | Latency (ms) |
|--------|----------------------|--------------|
| Sparse RAG (BM25) | 0.732 | 850 |
| Dense RAG (DPR+FAISS) | 0.754 | 1,020 |
| Standard CAG | 0.741 | 620 |
| **ACC-CAG** | **0.805** | **640** |
| Hybrid ACC-CAG-RAG | 0.812 | 710 |

## Critique / Limitations
- "Lost-in-the-middle" phenomenon: mid-sequence key facts still underperform due to transformer attention bias.
- Cache staleness: preloaded context doesn't reflect post-build knowledge updates without a full rebuild.
- Context window mismatch: even with ACC, millions-of-document corpora require segmented loading.
- BERTScore as primary metric doesn't fully capture factual accuracy.

## Connections to other sources
- Defines [[Cache-Augmented Generation]] as an alternative to [[Retrieval-Augmented Generation]].
- Uses [[FAISS]] for selective retrieval in the hybrid mode.
- HotpotQA benchmark relates to [[Multi-hop Retrieval]].
