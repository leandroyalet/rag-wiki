---
type: method
aliases: [Mixture-of-Chunkers, MoC framework]
tags: [rag, method, chunking]
status: stub
created: 2026-04-26
updated: 2026-04-26
sources: ["[[zhao2025moc]]"]
introduced_by: Zhao et al.
year: 2025
---

# MoC (Mixture of Chunkers)

> **TL;DR** A granularity-aware routing framework that sends text to specialized small LMs based on target chunk size, each of which outputs regex boundary markers rather than full text — achieving LLM-level chunking quality at small-model cost.

## Problem it solves
LLM-based chunkers (e.g., LumberChunker) produce high-quality splits but are computationally expensive. Traditional fixed-size and semantic chunkers are cheap but fail on complex contextual dependencies. MoC finds a middle path: use small specialized models routed by text granularity. [[zhao2025moc]]

## Key idea
Rather than using one LLM to chunk all text, route each text segment to a specialized small model calibrated for its target chunk size. Models output *regex patterns* with boundary markers (not full text), reducing generation cost. A post-processing step corrects hallucinated patterns via edit distance. [[zhao2025moc]]

## Evaluation metrics introduced
MoC proposes two intrinsic metrics for chunking quality:

- **Boundary Clarity (BC)** — `BC(q,d) = ppl(q|d) / ppl(q)` — ratio of conditional to unconditional perplexity. Values near 1 → chunks are semantically independent. Lower values indicate strong inter-chunk dependency. [[zhao2025moc]]
- **Chunk Stickiness (CS)** — structural entropy of a semantic association graph: `CS(G) = −∑(hᵢ/2m) · log₂(hᵢ/2m)` — lower = better semantic independence between chunks. [[zhao2025moc]]

Key finding: semantic chunking shows only marginal BC improvement over fixed-length splitting and fails on logically connected content — embedding-based approaches alone are insufficient for optimal chunking.

## Pipeline / Steps
1. **Multi-granularity router** — a small classifier LM assigns text to one of four target chunk-size buckets (0–120, 120–150, 150–180, 180+ characters).
2. **Specialized meta-chunkers** — each bucket has a dedicated small model that generates structured regex patterns with boundary tokens (not full chunked text).
3. **Edit-distance recovery** — post-processing aligns generated regex patterns against the original text, correcting hallucinated boundaries via character-level matching.

[[zhao2025moc]]

## Reported results
Tested on CRUD, DuReader, and WebCPM datasets:
- Meta-chunker-1.5B consistently outperforms semantic chunking.
- Matches larger models while maintaining efficiency comparable to a single small model.

[[zhao2025moc]]

## When to use / when not to
- ✅ Need LLM-quality chunking with constrained compute budget.
- ✅ Text with highly variable granularity (short snippets alongside long paragraphs).
- ❌ Homogeneous, well-structured documents — simpler methods may suffice.
- ❌ Languages/domains not covered by training data of the small router and meta-chunkers.

## Related / alternatives
- [[Chunking]] — parent concept.
- [[Adaptive Chunking]] — selects *strategy* per document; MoC routes by text *granularity*.
- [[Late Chunking]] — context-preserving embedding approach.

## Sources
- [[zhao2025moc]]
