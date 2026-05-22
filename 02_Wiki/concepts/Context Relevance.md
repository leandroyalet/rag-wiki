---
type: concept
aliases: [context precision, retrieval relevance, context quality]
tags: [rag, evaluation, retrieval]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[01_Sources/web_clips/mouschoutzi-retrieval-quality-precision-recall-f1]]"]
---

# Context Relevance

> **TL;DR** A RAG evaluation metric that measures how much of the retrieved context actually pertains to the query — high context relevance means little noise was injected into the prompt.

## Definition
Context Relevance quantifies the proportion of retrieved passages (or sentences within passages) that are relevant to the user's query. It is distinct from [[Faithfulness]] (which checks whether the answer is grounded in the context) — this metric checks whether the context itself was well-chosen by the retriever.

`Context Relevance ≈ |relevant sentences in retrieved context| / |total sentences in retrieved context|`

## Context
Context Relevance is the retrieval-side quality metric in [[RAGAS]] and related frameworks. Poor context relevance means the retriever surfaced noisy, off-topic chunks that:
- Waste prompt tokens.
- Risk confusing the LLM and inducing hallucination or topic drift.

It connects to classical information retrieval metrics ([[Precision and Recall|Precision@k, Recall@k, F1@k]]) evaluated on retrieved chunks. [[01_Sources/web_clips/mouschoutzi-retrieval-quality-precision-recall-f1]]

## How it works / How it's used

### Classical retrieval metrics (binary, order-unaware)
- **Precision@k** — fraction of the top-k retrieved chunks that are relevant. Emphasizes quality of the retrieved set. [[01_Sources/web_clips/mouschoutzi-retrieval-quality-precision-recall-f1]]
- **Recall@k** — fraction of all relevant chunks that appear in the top-k. Emphasizes completeness. [[01_Sources/web_clips/mouschoutzi-retrieval-quality-precision-recall-f1]]
- **F1@k** — harmonic mean of Precision@k and Recall@k; balances both. [[01_Sources/web_clips/mouschoutzi-retrieval-quality-precision-recall-f1]]
- **HitRate@k** — binary; 1 if at least one relevant chunk is in top-k. [[01_Sources/web_clips/mouschoutzi-retrieval-quality-precision-recall-f1]]

### RAGAS context relevance
RAGAS uses an LLM to judge each retrieved sentence as relevant or not to the query, then computes the ratio. This is reference-free — no gold context set required.

## Trade-offs
- ✅ Isolates retriever quality independently of the LLM generator.
- ✅ Directly guides chunking and retriever tuning — a low score points to over-retrieval or poor chunk boundaries.
- ❌ Classical metrics (Precision/Recall) require a gold relevant-chunk annotation set, which is costly to create.
- ❌ LLM-based context relevance is reference-free but subject to judge model bias.

## Related pages
- [[Precision and Recall]] — parent concept for Precision@k, Recall@k, F1@k
- [[Faithfulness]]
- [[RAGAS]]
- [[Dense Retrieval]]
- [[Chunking]]
- [[Reranking]]
- [[Retrieval-Augmented Generation]]

## Sources
- [[01_Sources/web_clips/mouschoutzi-retrieval-quality-precision-recall-f1]]
