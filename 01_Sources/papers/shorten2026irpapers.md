---
type: paper
citekey: shorten2026irpapers
title: "IRPAPERS: A Visual Document Benchmark for Scientific Retrieval and Question Answering"
authors: [Connor Shorten, Augustas Skaburskas, Daniel M. Jones, Charles Pierse, Roberto Esposito, John Trengrove, Etienne Dilocker, Bob van Luijt]
year: 2026
venue: arXiv (cs.IR)
url: https://arxiv.org/abs/2602.17687
pdf: "[[2602.17687v1.pdf]]"
tags: [paper, benchmark, retrieval, multimodal, visual-rag, scientific-papers]
status: summarized
added: 2026-04-19
added_by: Claude Code (/ingest)
---

# IRPAPERS: A Visual Document Benchmark for Scientific Retrieval and Question Answering

> **TL;DR** 3,230-page visual benchmark of IR papers testing image- vs. text-based retrieval and QA, showing that neither modality dominates and multimodal fusion achieves the best Recall@1 (49 %), with text still ahead on QA accuracy.

## Why we read it
First benchmark to directly compare image-based and text-based retrieval on scientific papers at page level — relevant for evaluating [[Docling]] and visual RAG pipelines.

## Problem
Existing benchmarks either treat documents as pure text or focus on single-document visual QA. IRPAPERS fills the gap: multi-document retrieval + QA from a semantically dense single-domain corpus, with both image and text representations.

## Contribution
- **Dataset**: 3,230 pages from 166 IR papers, 180 curated needle-in-haystack questions.
- **Dual representation**: page images (4.2 GB) + GPT-4 OCR transcriptions.
- **Baseline suite**: BM25, Arctic 2.0 dense, hybrid text; ColModernVBERT, ColPali, ColQwen2, MUVERA image; Cohere Embed v4, Voyage 3 Large closed-source.

## Results

| System | Recall@1 | Recall@5 | Recall@20 |
|--------|----------|----------|-----------|
| Text hybrid (BM25 + Arctic 2.0) | 46 % | 78 % | 91 % |
| ColModernVBERT (image) | 43 % | 78 % | 93 % |
| Multimodal fusion | **49 %** | **81 %** | **95 %** |
| Cohere Embed v4 (closed) | **58 %** | — | — |

QA: TextRAG@5 = 0.82 alignment; ImageRAG@5 = 0.71. Text ahead for QA; images ahead on t-SNE-style visual questions (70 % vs 30 %).

**Key finding**: 22 queries succeed only with text; 18 succeed only with images — neither modality is redundant. [[shorten2026irpapers]]

## Critique / Limitations
- 166 papers is a small, single-domain corpus — findings may not generalize beyond IR papers.
- OCR transcription introduces API cost and rate-limit overhead.
- Image retrieval lacks exact-match mechanisms (no BM25 analogue).
- Closed-source gap (58 % vs 49 % Recall@1) suggests open-source image retrieval has room to grow.

## Connections to other sources
- Introduces [[IRPAPERS]] benchmark.
- ColModernVBERT is a late-interaction model extending [[ColBERT]] to images/multimodal documents.
- Hybrid retrieval finding reinforces [[Hybrid Search]] as best open-source strategy.
- Motivates visual ingestion pipelines like [[Docling]].
