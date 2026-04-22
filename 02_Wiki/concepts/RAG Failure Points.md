---
type: concept
aliases: [RAG failure modes, RAG failure taxonomy, FP1-FP7]
tags: [rag, engineering, evaluation, quality]
status: stub
created: 2026-04-19
updated: 2026-04-19
sources: ["[[barnett2024failures]]"]
---

# RAG Failure Points

> **TL;DR** A seven-point taxonomy of where production RAG systems break down — from missing source content to LLM formatting failures — derived from case studies across research, education, and biomedical domains.

## Definition
[[barnett2024failures]] identifies seven distinct failure points (FP1–FP7) that occur when engineering RAG systems in practice. Each maps to a different stage of the pipeline and requires a different mitigation. The taxonomy was derived from three deployed systems: a literature-review assistant, an AI tutor, and a biomedical QA system (BioASQ, 4,017 PDFs, 1,000 questions). [[barnett2024failures]]

## The Seven Failure Points

| ID | Stage | Name | Description |
|----|-------|------|-------------|
| **FP1** | Knowledge base | Missing content | The answer doesn't exist in any indexed document; the system hallucinates rather than saying "I don't know" |
| **FP2** | Retrieval | Missed top-ranked docs | The answer exists but didn't rank in the top-k returned to the LLM |
| **FP3** | Retrieval → context | Consolidation limits | Many retrieved docs exceed the context window; reduction strategies lose the relevant passage |
| **FP4** | Generation | Extraction failure | The answer is present in context but the LLM fails to extract it correctly |
| **FP5** | Generation | Wrong format | The LLM ignores structural instructions (tables, lists, JSON) |
| **FP6** | Generation | Incorrect specificity | The answer is returned but is too vague or too specific for the user's need |
| **FP7** | Generation | Incomplete answer | The LLM omits available information that is present in the context |

[[barnett2024failures]]

## Context
The key engineering insight: **RAG system validation is only feasible during operation**. Offline benchmarks won't surface FP5, FP6, or FP7 reliably because they depend on the distribution of real user queries and implicit formatting expectations. [[barnett2024failures]]

Robustness evolves at runtime rather than being designed upfront — implying continuous monitoring and self-adaptive pipelines. [[barnett2024failures]]

## Mitigations by failure point

| Failure point | Mitigation |
|--------------|-----------|
| FP1 | Semantic caching for frequent queries; explicit "no answer" prompting |
| FP2 | [[Reranking]]; [[Hybrid Search]] (dense + sparse); metadata-enriched embeddings |
| FP3 | Smaller [[Chunking]] (chunk sizes); [[RAPTOR]] hierarchical summaries; larger context window |
| FP4 | Larger context window (8K > 4K tokens shown effective); metadata (filename, chunk number) |
| FP5 | Output parsers; structured generation; schema enforcement |
| FP6 | Calibrated prompt instructions; user intent classification |
| FP7 | Increase top-k; [[Multi-hop Retrieval]]; completeness checks |

[[barnett2024failures]]

## Relation to other evaluation frameworks
- [[RAGAS]] and [[DeepEval]] metrics map onto FP2 (Context Relevance/Precision), FP1 + FP4 (Faithfulness), and FP6 + FP7 (Answer Relevance).
- [[Hallucination in RAG]] covers FP1 and FP4 specifically.
- FP2 is the target of [[Reranking]] research.
- FP3 motivates [[RAPTOR]] and [[Cache-Augmented Generation]].

## Related pages
- [[Hallucination in RAG]]
- [[Retrieval-Augmented Generation]]
- [[Chunking]]
- [[Reranking]]
- [[Hybrid Search]]
- [[RAPTOR]]
- [[RAGAS]]

## Sources
- [[barnett2024failures]]
