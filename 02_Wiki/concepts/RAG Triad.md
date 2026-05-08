---
type: concept
aliases: [RAG triad, three-metric RAG evaluation]
tags: [rag, evaluation, metrics]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: []
---

# RAG Triad

> **TL;DR** Three-metric evaluation framework for RAG pipelines — Context Relevance, Groundedness, and Answer Relevance — covering every stage where failure can occur.

## Definition
The RAG Triad is an evaluation framework (popularised by [[TruLens]]) that assesses a RAG pipeline along three orthogonal dimensions:

| Metric | Question it answers | Stage |
|--------|---------------------|-------|
| **[[Context Relevance]]** | Did retrieval fetch relevant chunks? | Retriever |
| **[[Faithfulness]]** (Groundedness) | Does the answer stay within the retrieved context? | Generator |
| **[[Answer Relevance]]** | Does the answer actually address the question? | Generator |

## Context
A RAG pipeline can fail at three distinct points: it can retrieve irrelevant context, it can hallucinate facts not in the context, or it can respond off-topic. Evaluating only end-to-end accuracy hides which stage is broken. The RAG Triad makes each failure mode independently measurable.

## How it's used
Implemented in [[TruLens]] as LLM-judge feedback functions that instrument each pipeline call and score all three metrics automatically. [[RAGAS]] implements equivalent metrics (Context Precision, Faithfulness, Answer Relevancy) under different names.

A pipeline "passes" the triad only if all three scores exceed configured thresholds — common reporting uses a traffic-light view per run.

## Related pages
- [[TruLens]]
- [[RAGAS]]
- [[Context Relevance]]
- [[Faithfulness]]
- [[Answer Relevance]]
- [[Hallucination in RAG]]
- [[RAG Failure Points]]

## Sources
> [!todo] Source needed — add TrueRA / TruLens documentation or the original paper introducing the RAG Triad framing.
