---
title: "VERA: Validation and Evaluation of Retrieval-Augmented Systems"
authors: "Tianyu Ding, Adi Banerjee, Laurent Mombaerts, Yunhong Li, Tarik Borogovac, Juan Pablo De la Cruz Weinstein"
citekey: ding2024vera
aliases: [ding2024vera]
year: 2024
venue: "ArXiv"
url: "https://arxiv.org/abs/2409.03759"
tags: [paper, arxiv, rag, evaluation, framework]
status: summarized
added_by: Pablo
---

# VERA: Validation and Evaluation of Retrieval-Augmented Systems

## Summary
Introduces **VERA**, a RAG evaluation framework with two key innovations over RAGAS-style metric suites: (1) cross-encoder composite ranking and (2) Bootstrap confidence intervals.

**Four base metrics:**
| Metric | Scope |
|--------|-------|
| Faithfulness | Generation phase — answer grounded in context? |
| Retrieval Recall | Retrieval phase — all relevant documents retrieved? |
| Retrieval Precision | Retrieval phase — retrieved docs are relevant? |
| Answer Relevance | Generation phase — answer addresses the question? |

**Innovation 1 — Cross-encoder ranking:**
Individual metric scores are enhanced with natural-language descriptions, then fed to a cross-encoder (ms-marco-MiniLM-L-12-v2) to produce a single aggregated ranking logit. Avoids the "compensatory effect" where high scores on one metric mask low scores on another.

**Innovation 2 — Bootstrap confidence bounds:**
Metric values are computed across B bootstrap samples of the document repository, producing mean estimates and 95% confidence intervals. This quantifies LLM stochasticity and validates repository topical coverage (domain-relevant queries score higher than random queries).

**Results on MS MARCO TREC 2023:**
| Model | Faithfulness | Relevance | Recall | Precision |
|-------|-------------|-----------|--------|-----------|
| Llama3 + e5-mistral-7b | 0.94 | 0.87 | 0.76 | 0.68 |
| Haiku + e5-mistral-7b | 0.95 | 0.85 | 0.75 | 0.65 |
| T-5 Flan baseline | 0.82 | 0.53 | 0.61 | 0.50 |

## Abstract
VERA is a framework designed to enhance the transparency and reliability of RAG system outputs. It introduces: (1) a cross-encoder mechanism that consolidates multidimensional metrics into a single comprehensive ranking score, and (2) Bootstrap statistics on LLM-based metrics to establish confidence bounds, ensuring repository topical coverage.

# VERA: Validation and Evaluation of Retrieval-Augmented Systems

## Resumen
The increasing use of Retrieval-Augmented Generation (RAG) systems in various applications necessitates stringent protocols to ensure RAG systems accuracy, safety, and alignment with user intentions. In this paper, we introduce VERA (Validation and Evaluation of Retrieval-Augmented Systems), a framework designed to enhance the transparency and reliability of outputs from large language models (LLMs) that utilize retrieved information. VERA improves the way we evaluate RAG systems in two important ways: (1) it introduces a cross-encoder based mechanism that encompasses a set of multidimensional metrics into a single comprehensive ranking score, addressing the challenge of prioritizing individual metrics, and (2) it employs Bootstrap statistics on LLM-based metrics across the document repository to establish confidence bounds, ensuring the repositorys topical coverage and improving the overall reliability of retrieval systems. Through several use cases, we demonstrate how VERA can strengthen decision-making processes and trust in AI applications. Our findings not only contribute to the theoretical understanding of LLM-based RAG evaluation metric but also promote the practical implementation of responsible AI systems, marking a significant advancement in the development of reliable and transparent generative AI technologies.
