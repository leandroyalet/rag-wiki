---
type: benchmark
aliases: [IRPAPERS benchmark, Visual IR Benchmark]
tags: [benchmark, retrieval, multimodal, visual-rag, scientific-papers]
status: stub
created: 2026-04-19
updated: 2026-04-19
sources: ["[[shorten2026irpapers]]"]
homepage: 
repo: 
docs: 
year: 2026
---

# IRPAPERS

> **TL;DR** A 3,230-page visual benchmark of IR scientific papers comparing image- and text-based retrieval and QA, with the key finding that neither modality dominates and multimodal fusion gives the best results.

## What it measures
IRPAPERS measures page-level retrieval recall and end-to-end QA accuracy for both image-based and text-based RAG systems on a semantically dense single-domain corpus. It uniquely answers: *which information can only be recovered from images vs. text?* [[shorten2026irpapers]]

## Dataset / Test collection
- **3,230 pages** from **166 scientific papers** on Information Retrieval (sourced from citations of "LLMs for IR: A Survey").
- **180 curated questions** — needle-in-haystack style, one question per non-reference page.
- **Dual representation**: page images (4.2 GB total, ~1.3 MB/page) and GPT-4 OCR transcriptions (~4.5 KB/page).
- Semantic density is high: papers discuss similar techniques, requiring fine-grained discrimination. [[shorten2026irpapers]]

## Metrics
| Metric | Description |
|--------|-------------|
| Recall@1 / @5 / @20 | Fraction of queries where the correct page is in the top-k retrieved |
| QA Alignment Score | LLM-as-judge binary semantic equivalence, majority vote over 3 runs |

## Key results

| System | Recall@1 | Recall@5 | Recall@20 |
|--------|----------|----------|-----------|
| [[BM25]] (sparse text) | — | — | — |
| Arctic 2.0 (dense text) | — | — | — |
| **Text hybrid** ([[BM25]] + Arctic 2.0) | 46 % | 78 % | 91 % |
| ColModernVBERT (image) | 43 % | 78 % | 93 % |
| **Multimodal fusion** | **49 %** | **81 %** | **95 %** |
| Cohere Embed v4 (closed-source, image) | **58 %** | — | — |

QA: TextRAG@5 = 0.82 · ImageRAG@5 = 0.71. Images outperform text on visual-layout questions (t-SNE plots: 70 % vs. 30 %). [[shorten2026irpapers]]

**Complementarity**: 22 queries succeed *only* with text; 18 succeed *only* with images — confirming neither modality is redundant. [[shorten2026irpapers]]

## Reported baselines
Best open-source: multimodal fusion (49 % Recall@1). Best overall: Cohere Embed v4 (58 % Recall@1) — 9-point gap over open-source. [[shorten2026irpapers]]

## Limitations / caveats
- Single domain (IR papers); findings may not generalize.
- OCR transcription adds API cost and rate-limit complexity.
- 166 papers is a small corpus; some questions may have overlapping relevant pages.
- Image retrieval lacks exact-match analogues for precise lexical queries. [[shorten2026irpapers]]

## Related benchmarks
- **ViDoRe v3** — current multimodal retrieval gold standard (26,000 pages, 10 domains); IRPAPERS complements with deeper single-domain coverage.
- **LitSearch** — document-level scientific retrieval (title/abstract); IRPAPERS is page-level with full visual content.
- [[BEIR]] — multi-dataset text retrieval; no visual component.
- [[MTEB]] — embedding benchmark; Retrieval tab is the closest counterpart.

## Related pages
- [[ColBERT]] — ColModernVBERT is its multimodal successor
- [[Hybrid Search]]
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Docling]] — visual document parsing for ingestion into such pipelines

## Sources
- [[shorten2026irpapers]]
