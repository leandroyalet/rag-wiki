---
type: concept
aliases: [CAG, cache augmented generation]
tags: [rag, context-window, caching, generation]
status: stub
created: 2026-04-19
updated: 2026-04-19
sources: ["[[agrawal2025cag]]"]
---

# Cache-Augmented Generation

> **TL;DR** An alternative to RAG that preloads a curated knowledge snapshot directly into the LLM's context window before query time, eliminating retrieval latency and noise at the cost of context-window capacity and cache staleness.

## Definition
Cache-Augmented Generation (CAG) skips the retrieval step by pre-compiling a compressed representation of the relevant knowledge base into the model's context window (and optionally into precomputed key-value tensors). At query time, no external lookup is needed — the LLM reasons over the cached context directly. [[agrawal2025cag]]

## Context
CAG emerged as LLM context windows grew large enough to hold meaningful knowledge snapshots (32K–128K+ tokens). It trades the dynamic adaptability of [[Retrieval-Augmented Generation]] for lower latency and simpler system design. [[agrawal2025cag]]

## How it works / How it's used

### Basic CAG
1. **Offline**: curate a knowledge snapshot → compress to fit the context window → cache key-value tensors.
2. **Online**: prepend the cached context to every query prompt → generate directly.

### Adaptive Contextual Compression (ACC) — CAG at scale
When the knowledge base exceeds the context window, ACC compresses it in three stages: [[agrawal2025cag]]
1. **Snippet ranking**: dual-encoder scoring balances real-time query similarity with precomputed offline relevance.
2. **Hierarchical summarization**: BART-based abstraction at document / paragraph / sentence levels — achieves 75 % token reduction while preserving 95 % of task-critical content.
3. **RL policy (PPO)**: learns compression decisions to balance generation quality vs. token cost.

### Hybrid CAG-RAG
A lightweight cache-hit detector routes queries: if the preloaded context covers the query, use CAG; otherwise, fetch from FAISS and briefly compress the result before merging. Gains 1–2 BERTScore points over standalone ACC-CAG. [[agrawal2025cag]]

## Variants
- **Standard CAG** — preload without compression; practical only for small knowledge bases.
- **ACC-CAG** — adds Adaptive Contextual Compression for large corpora.
- **Hybrid ACC-CAG-RAG** — selective retrieval augmentation on cache misses.

## Trade-offs

| | CAG | RAG |
|---|---|---|
| Latency | ✅ Lower (no retrieval) | ❌ Higher |
| Noise | ✅ No irrelevant chunks | ❌ Retrieval noise |
| Scalability | ❌ Bounded by context window | ✅ Scales to millions of docs |
| Freshness | ❌ Static snapshot | ✅ Always current |
| System complexity | ✅ Simpler (no vector DB) | ❌ Requires indexing pipeline |

[[agrawal2025cag]]

## Reported results
ACC-CAG vs. Dense RAG on HotpotQA: BERTScore 0.805 vs. 0.754 at 640 ms vs. 1,020 ms latency. Hybrid ACC-CAG-RAG: 0.812. [[agrawal2025cag]]

## Limitations
- **Lost-in-the-middle**: transformer attention degrades for mid-context facts. [[agrawal2025cag]]
- **Cache staleness**: knowledge updates require full or partial cache reconstruction. [[agrawal2025cag]]
- **Window ceiling**: even with ACC, multi-million-document corpora require segmented loading. [[agrawal2025cag]]

## Related pages
- [[Retrieval-Augmented Generation]]
- [[RAG Failure Points]] — FP3 (consolidation limits) motivates CAG
- [[Chunking]]
- [[Vector Database]]
- [[FAISS]]
- [[Multi-hop Retrieval]]

## Sources
- [[agrawal2025cag]]
