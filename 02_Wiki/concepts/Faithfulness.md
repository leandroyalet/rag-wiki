---
type: concept
aliases: [groundedness, answer grounding, non-hallucination]
tags: [rag, evaluation, quality]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: []
---

# Faithfulness

> **TL;DR** A RAG evaluation metric that measures whether every claim in the generated answer can be traced back to the retrieved context — a score of 1.0 means no hallucination.

## Definition
Faithfulness (also called *groundedness*) is the fraction of statements in the LLM's answer that are supported by the retrieved context. A statement is faithful if it can be inferred from the provided passages without any external knowledge. A score < 1.0 indicates hallucination.

Formally: `Faithfulness = |supported statements| / |total statements in answer|`

## Context
Faithfulness is the generation-side complement to [[Context Relevance]] (which measures the retrieval side). Together they are two of the three core metrics in [[RAGAS]]:
1. **Context Relevance** — was the right context retrieved?
2. **Faithfulness** — did the LLM stay within the retrieved context?
3. **Answer Relevance** — does the answer actually address the user's question?

Faithfulness directly tracks [[Hallucination in RAG]]: a low faithfulness score means the model invented facts not present in the context.

## How it works / How it's used
RAGAS and similar frameworks measure faithfulness by:
1. Using an LLM to decompose the generated answer into atomic statements.
2. For each statement, asking an LLM (or NLI model) whether it can be inferred from the retrieved passages.
3. Dividing the count of supported statements by the total.

This is an LLM-as-judge approach — results depend on the judge model's quality.

## Trade-offs
- ✅ Directly operationalizes hallucination detection without a reference answer.
- ✅ Applicable to open-domain QA where gold answers are unavailable.
- ❌ LLM-as-judge can itself hallucinate or make borderline judgments inconsistently.
- ❌ Does not penalize *omission* — a model can score 1.0 by giving a trivially safe, incomplete answer.
- ❌ Expensive to evaluate at scale (requires multiple LLM calls per sample).

## Related pages
- [[Hallucination in RAG]]
- [[Context Relevance]]
- [[RAGAS]]
- [[Retrieval-Augmented Generation]]

## Sources
> [!todo] Source needed — link to RAGAS paper once ingested
