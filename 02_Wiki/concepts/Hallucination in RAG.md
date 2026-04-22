---
type: concept
aliases: [confabulation, grounding failures, faithfulness failure]
tags: [rag, quality, evaluation, safety]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]", "[[emonet2024sparql]]", "[[barnett2024failures]]", "[[chatzikyriakidis2025raggedevents]]"]
---

# Hallucination in RAG

> **TL;DR** When a RAG system generates claims not supported by the retrieved context — caused by retriever failure, context overload, or the LLM's tendency to fill gaps with parametric knowledge.

## Definition
Hallucination in RAG occurs when the generated answer contains statements that are absent from or contradict the retrieved passages. Unlike hallucination in standalone LLMs (which lack any grounding), RAG hallucination means the model deviated from the context it was explicitly given.

Two subtypes:
- **Retrieval-induced hallucination**: the retrieved context is wrong, incomplete, or irrelevant — the LLM has no good signal to work from.
- **Generation-induced hallucination**: the retriever found correct context but the LLM ignored it, fabricated details, or blended parametric knowledge with retrieved facts.

## Context
RAG was introduced partly to *reduce* hallucination by anchoring the LLM to a verifiable knowledge base ([[lewis2020rag]]). Yet hallucination persists because:
1. The retriever may fail to surface the relevant passage ([[Context Relevance]] failure).
2. The LLM over-relies on parametric knowledge when context is ambiguous or insufficient.
3. Long or noisy contexts dilute the relevant signal. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

In structured-output RAG (e.g., SPARQL generation), hallucination manifests as invented property names, class IRIs, or entity identifiers. [[emonet2024sparql]]

## Failure point taxonomy
[[barnett2024failures]] maps hallucination to specific pipeline stages:
- **FP1** (missing content) — system generates an answer when no source exists; the most dangerous hallucination type.
- **FP4** (extraction failure) — context contains the answer but the LLM fails to extract it correctly, substituting a plausible-sounding fabrication.

Critically, RAG augmentation can *introduce* hallucination in capable models. [[chatzikyriakidis2025raggedevents]] found GPT-4o and Claude-3.5 Sonnet produced more hallucinations *with* RAG than without on a well-documented historical corpus — the inverse calibration principle: retrieved context creates conflicting signals for models that already have strong parametric knowledge. [[chatzikyriakidis2025raggedevents]]

## How it works / How it's used

### Detection
- **[[Faithfulness]]** score (RAGAS): fraction of answer statements traceable to context. Score < 1.0 → hallucination present.
- **NLI-based entailment**: check if each answer sentence is entailed by the retrieved passages.
- **Validation loops**: for structured outputs, parse the result and check against a schema (ShEx, JSON Schema). [[emonet2024sparql]]

### Mitigation strategies
1. **Better retrieval**: improve [[Context Relevance]] — more accurate chunks leave fewer gaps for the LLM to fill.
2. **[[Reranking]]**: surface the single most relevant chunk rather than a noisy top-10.
3. **Prompt constraints**: instruct the LLM to answer "I don't know" when context is insufficient.
4. **Self-consistency / chain-of-thought**: verify reasoning steps before committing to an answer.
5. **Post-hoc validation**: parse and validate outputs against a schema or fact database. [[emonet2024sparql]]
6. **[[RAPTOR]] / hierarchical context**: provide multi-granularity context to reduce the chance of missing key facts.

## Trade-offs
- Fully eliminating hallucination is unsolved — especially for entity-level facts (specific IDs, numbers, dates) not present verbatim in retrieved text.
- Detection is cheaper than prevention but introduces latency (additional LLM / NLI pass).

## Related pages
- [[Faithfulness]]
- [[Context Relevance]]
- [[RAGAS]]
- [[Reranking]]
- [[Retrieval-Augmented Generation]]
- [[Shape Expressions]]

## Related pages
- [[RAG Failure Points]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
- [[emonet2024sparql]]
- [[barnett2024failures]]
- [[chatzikyriakidis2025raggedevents]]
