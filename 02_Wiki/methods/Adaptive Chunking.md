---
type: method
aliases: [adaptive chunking, document-aware chunking]
tags: [rag, method, chunking, preprocessing]
status: stub
created: 2026-04-26
updated: 2026-04-26
sources: ["[[moura2026adaptive]]"]
introduced_by: Moura Júnior et al. (Ekimetrics)
year: 2026
---

# Adaptive Chunking

> **TL;DR** Per-document chunking strategy selection guided by five intrinsic quality metrics — moving away from "one-size-fits-all" splitting to document-aware preprocessing that improves RAG answer correctness by ~10 percentage points.

## Problem it solves
Standard RAG pipelines apply a single chunking method (e.g., fixed-size with overlap) to every document. This works poorly for a mixed corpus where legal briefs, technical manuals, and narrative prose have fundamentally different structure. There is also no principled way to compare chunking strategies without running the full downstream RAG pipeline. [[moura2026adaptive]]

## Key idea
Evaluate each document against five intrinsic metrics before indexing, and select the chunking strategy that scores best. The metrics are independent of downstream task performance — they assess chunking quality directly from the text. [[moura2026adaptive]]

## Five intrinsic metrics
| Metric | Abbreviation | What it measures |
|--------|--------------|-----------------|
| References Completeness | RC | In-text citations/references remain intact within a chunk |
| Intrachunk Cohesion | ICC | Semantic coherence *within* each chunk |
| Document Contextual Coherence | DCC | How well chunks preserve the broader document context |
| Block Integrity | BI | Structural elements (tables, code, lists) remain unbroken |
| Size Compliance | SC | Chunks fall within target length bounds |

[[moura2026adaptive]]

## Pipeline / Steps
1. For each document, compute the five intrinsic metrics across candidate chunking strategies.
2. Select the strategy with the best composite metric score for that document.
3. Apply the chosen strategy; optionally apply post-processing (e.g., merge orphaned fragments).
4. Embed and index chunks as normal.

## New chunkers introduced
- **LLM-regex splitter** — an LLM identifies semantically appropriate split points and outputs regex patterns applied to the text, combining linguistic intelligence with exact-match precision.
- **Split-then-merge recursive splitter** — over-segments the document first, then intelligently recombines fragments to restore coherence at the desired granularity.

[[moura2026adaptive]]

## Reported results
Tested on a diverse corpus spanning legal, technical, and social science domains with no changes to retrieval model or generation prompt:

| Metric | Baseline | Adaptive Chunking |
|--------|----------|-------------------|
| Answer correctness | 62–64% | **72%** |
| Questions answered | 49 | **65** (+33%) |

[[moura2026adaptive]]

## Reference implementations
- Code: https://github.com/ekimetrics/adaptive-chunking (Ekimetrics)

## When to use / when not to
- ✅ Mixed-format corpus (legal + technical + prose) where no single strategy dominates.
- ✅ When answer quality matters more than indexing speed (metric computation adds overhead).
- ✅ When you want to evaluate chunking strategies independently of downstream RAG metrics.
- ❌ Homogeneous corpora (e.g., plain news articles) — overhead likely not justified.
- ❌ Real-time or streaming ingestion — per-document metric evaluation adds latency.

## Related / alternatives
- [[Chunking]] — parent concept; all chunking strategies and trade-offs.
- [[Late Chunking]] — alternative approach: embed before segmenting to preserve context.
- [[RAPTOR]] — hierarchical chunking via recursive summarization.
- [[MoC]] — another LLM-routing approach to chunking (Mixture-of-Chunkers).

## Sources
- [[moura2026adaptive]]
