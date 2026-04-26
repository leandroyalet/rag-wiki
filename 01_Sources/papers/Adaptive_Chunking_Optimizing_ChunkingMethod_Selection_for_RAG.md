---
title: "Adaptive Chunking: Optimizing Chunking-Method Selection for RAG"
authors: "Paulo Roberto de Moura Júnior, Jean Lelong, Annabelle Blangero"
citekey: moura2026adaptive
aliases: [moura2026adaptive]
year: 2026
venue: "ArXiv"
url: "https://arxiv.org/abs/2603.25333"
tags: [paper, arxiv, chunking, rag]
status: summarized
added_by: Pablo
---

# Adaptive Chunking: Optimizing Chunking-Method Selection for RAG

## Summary
Introduces **Adaptive Chunking** — a framework that selects the best chunking strategy *per document* rather than applying a single method to all inputs.

**Five intrinsic evaluation metrics** (document-based, independent of downstream task):
| Metric | What it measures |
|--------|-----------------|
| **RC** — References Completeness | Whether in-text references/citations remain intact within a chunk |
| **ICC** — Intrachunk Cohesion | Semantic coherence within each individual chunk |
| **DCC** — Document Contextual Coherence | How well chunks preserve broader document context |
| **BI** — Block Integrity | Whether structural elements (tables, lists, code) remain unbroken |
| **SC** — Size Compliance | Whether chunks meet target length constraints |

**Two new chunkers introduced:**
- *LLM-regex splitter* — LLM identifies split points, outputs regex patterns applied to the text.
- *Split-then-merge recursive splitter* — initially over-segments, then merges fragments to restore coherence.

**Results** (legal, technical, social science corpus; no model or prompt changes):
- Answer correctness: **72%** vs. 62–64% baseline.
- Questions successfully answered: **65 vs. 49** (+33%).

Code: https://github.com/ekimetrics/adaptive-chunking

## Abstract
The effectiveness of Retrieval-Augmented Generation (RAG) is highly dependent on how documents are chunked, that is, segmented into smaller units for indexing and retrieval. Yet, commonly used "one-size-fits-all" approaches often fail to capture the nuanced structure and semantics of diverse texts. Despite its central role, chunking lacks a dedicated evaluation framework, making it difficult to assess and compare strategies independently of downstream performance. We challenge this paradigm by introducing Adaptive Chunking, a framework that selects the most suitable chunking strategy for each document based on a set of five novel intrinsic, document-based metrics: References Completeness (RC), Intrachunk Cohesion (ICC), Document Contextual Coherence (DCC), Block Integrity (BI), and Size Compliance (SC), which directly assess chunking quality across key dimensions. To support this framework, we also introduce two new chunkers, an LLM-regex splitter and a split-then-merge recursive splitter, alongside targeted post-processing techniques. On a diverse corpus spanning legal, technical, and social science domains, our metric-guided adaptive method significantly improves downstream RAG performance. Without changing models or prompts, our framework increases RAG outcomes, raising answers correctness to 72% (from 62-64%) and increasing the number of successfully answered questions by over 30% (65 vs. 49). These results demonstrate that adaptive, document-aware chunking, guided by a complementary suite of intrinsic metrics, offers a practical and effective path to more robust RAG systems. Code available at https://github.com/ekimetrics/adaptive-chunking.
