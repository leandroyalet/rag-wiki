---
type: concept
aliases: [RAG failure modes, RAG failure taxonomy, FP1-FP7]
tags: [rag, engineering, evaluation, quality]
status: stub
created: 2026-04-19
updated: 2026-04-19
sources: ["[[barnett2024failures]]", "[[brehme2025ragindustry]]", "[[simon2024rageval]]", "[[muller2025grouse]]"]
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

## Industry perspective
[[brehme2025ragindustry]] (13-practitioner interview study) identifies **data preprocessing** as the most commonly cited operational challenge in production RAG — cleaning, formatting, and normalising source documents before indexing. This is a pre-FP1 failure mode: if raw documents are noisy or poorly structured, the knowledge base is incomplete regardless of retrieval quality, directly causing FP1 (missing content) and FP2 (wrong chunks ranked). Industry evaluation of failure points is still predominantly human-conducted rather than automated. [[brehme2025ragindustry]]

## Evaluation methodology
[[simon2024rageval]] proposes a reusable evaluation blueprint for RAG systems with three principles: (1) careful baseline and metric selection, (2) systematic refinements guided by qualitative failure analysis of the failure points, and (3) transparent reporting of design decisions for replication. Applied empirically to software configuration dependency validation, the methodology produced the highest accuracy in that field — validating FP-driven iterative refinement as an effective engineering strategy. [[simon2024rageval]]

## Generator failure modes (GroUSE taxonomy)
[[muller2025grouse]] proposes a complementary taxonomy focused on the **generation step** (grounded QA) with 7 failure modes that automated evaluation frameworks must detect:

| ID | Failure mode | Metric |
|----|-------------|--------|
| FM1 | Irrelevant information in answer | Answer Relevancy |
| FM2 | Fails to abstain on unanswerable question | Negative Rejection |
| FM3 | Missing relevant information | Completeness |
| FM4 | Wrongly abstains on answerable question | Positive Acceptance |
| FM5 | Correct abstention + unrelated added info | Usefulness |
| FM6 | Missing or incorrect citation | Faithfulness |
| FM7 | Distorted or unsupported claim | Faithfulness |

RAGAS and DeepEval miss several of these modes in unit testing despite strong aggregate GPT-4 correlation. [[muller2025grouse]]

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
- [[GroUSE]]

## Sources
- [[barnett2024failures]]
- [[simon2024rageval]]
- [[muller2025grouse]]
