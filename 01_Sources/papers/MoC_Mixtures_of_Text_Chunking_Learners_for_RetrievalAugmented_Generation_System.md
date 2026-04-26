---
title: "MoC: Mixtures of Text Chunking Learners for Retrieval-Augmented Generation System"
authors: "Jihao Zhao, Zhiyuan Ji, Zhaoxin Fan, Hanyu Wang, Simin Niu, Bo Tang, Feiyu Xiong, Zhiyu Li"
citekey: zhao2025moc
aliases: [zhao2025moc]
year: 2025
venue: "ArXiv"
url: "https://arxiv.org/abs/2503.09600"
tags: [paper, arxiv, chunking, rag]
status: summarized
added_by: Pablo
---

# MoC: Mixtures of Text Chunking Learners for Retrieval-Augmented Generation System

## Summary
Introduces two chunking evaluation metrics and the **Mixture-of-Chunkers (MoC)** framework, which routes text to specialized small models based on granularity.

**Evaluation metrics:**
- **Boundary Clarity (BC)** — `BC(q,d) = ppl(q|d) / ppl(q)` — measures how independent chunks are; values near 1 mean chunks are semantically self-contained.
- **Chunk Stickiness (CS)** — structural entropy over a semantic association graph: `CS(G) = −∑(hᵢ/2m)·log₂(hᵢ/2m)` — lower = better semantic independence between chunks.

Finding: semantic chunking shows only *marginal* Boundary Clarity improvement over fixed-length splitting, and fails to recognize logically connected content — demonstrating embedding-based approaches alone are insufficient.

**MoC three-stage pipeline:**
1. **Multi-granularity router** — small LM classifies text into 4 target chunk-size buckets (0–120, 120–150, 150–180, 180+ characters).
2. **Specialized meta-chunkers** — instead of outputting full text, each model generates structured regex patterns with boundary markers, reducing generation overhead.
3. **Edit-distance recovery** — post-processing corrects hallucinated regexes via character-level matching against original text.

**Results:** Meta-chunker-1.5B outperforms semantic chunking and matches larger models on CRUD, DuReader, and WebCPM datasets while maintaining efficiency comparable to a single small model.

## Abstract
Retrieval-Augmented Generation (RAG), while serving as a viable complement to large language models (LLMs), often overlooks the crucial aspect of text chunking within its pipeline. This paper initially introduces a dual-metric evaluation method, comprising Boundary Clarity and Chunk Stickiness, to enable the direct quantification of chunking quality. Leveraging this assessment method, we highlight the inherent limitations of traditional and semantic chunking in handling complex contextual nuances, thereby substantiating the necessity of integrating LLMs into chunking process. To address the inherent tool between computational efficiency and chunking precision in LLM-based approaches, we devise the granularity-aware Mixture-of-Chunkers (MoC) framework, which consists of a three-stage processing mechanism. Notably, our objective is to guide the chunker towards generating a structured list of chunking regular expressions, which are subsequently employed to extract chunks from the original text. Extensive experiments demonstrate that both our proposed metrics and the MoC framework effectively settle challenges of the chunking task, revealing the chunking kernel while enhancing the performance of the RAG system.
