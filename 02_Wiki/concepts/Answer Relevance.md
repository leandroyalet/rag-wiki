---
type: concept
aliases: [answer relevancy]
tags: [rag, evaluation, metrics]
status: stub
created: 2026-04-21
updated: 2026-04-21
sources: ["[[Es2023ragas]]"]
---

# Answer Relevance

> **TL;DR** Evaluation metric measuring whether the generated answer actually addresses the question asked — penalises incomplete, off-topic, or redundant answers without requiring a reference answer.

## Definition
Answer relevance measures the semantic alignment between the original question and the generated answer. It is a *reference-free* metric: it does not compare the answer to a gold standard but instead assesses whether the answer responds to the question appropriately.

## Context
In the RAG pipeline, retrieval quality and faithfulness can both be high while the answer still fails the user if it answers a different question or only partially addresses it. Answer relevance is the third leg of both the [[RAGAS]] metric suite and the [[TruLens]] [[RAG Triad]].

## How it's measured

### RAGAS approach (reverse question generation)
1. The LLM generates `n` questions that could plausibly have produced the given answer.
2. Each generated question is embedded (text-embedding-ada-002 in the original paper).
3. Cosine similarity between each generated question and the original query is computed.
4. Score `AR = (1/n) Σ sim(q, qᵢ)`.
A low score means the answer implies questions different from what was asked — i.e., the answer went off-topic or is incomplete. [[Es2023ragas]]

### TruLens approach (RAG Triad)
TruLens calls this metric "Answer Relevance" and uses an LLM judge to rate whether the answer addresses the question, as part of the RAG Triad alongside Context Relevance and Groundedness. [[TruLens]]

### Simple cosine baseline
Some pipelines compute cosine similarity directly between the question embedding and the answer embedding, but this is coarser and does not penalise redundancy or incompleteness.

## Variants
- **Answer Correctness** (RAGAS) — adds factual accuracy against a reference; requires ground truth.
- **Answer Similarity** (RAGAS) — pure embedding cosine between answer and reference; no LLM judge needed.

## Trade-offs
- ✅ Reference-free: no human annotations required.
- ✅ Penalises over-hedging, topic drift, and partial answers.
- ❌ Reverse-question generation can be inconsistent on ambiguous or multi-part questions.
- ❌ Does not capture factual accuracy — a confidently wrong answer can score high.

## Related pages
- [[Faithfulness]]
- [[Context Relevance]]
- [[RAGAS]]
- [[TruLens]]
- [[RAG Triad]]
- [[Hallucination in RAG]]

## Sources
- [[Es2023ragas]] — *RAGAS: Automated Evaluation of Retrieval Augmented Generation*
