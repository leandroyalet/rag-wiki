---
type: concept
aliases: [multi-step retrieval, iterative retrieval, chained retrieval, Iterative RAG]
tags: [rag, retrieval, reasoning]
status: stub
created: 2026-04-18
updated: 2026-05-16
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]", "[[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]]"]
---

# Multi-hop Retrieval

> **TL;DR** Answering complex questions that require chaining multiple retrieval steps — each step uses what was just found to formulate the next query.

## Definition
Multi-hop retrieval is a strategy where a single round of retrieval is insufficient to gather all evidence needed for an answer. Instead, the system performs sequential retrieval passes: the output of one retrieval informs the query for the next, building up evidence across multiple "hops" over the knowledge base.

It addresses questions like "Who is the CEO of the company that acquired X?" — which require first finding what company acquired X, then finding its CEO.

## Context
Simple RAG (one-shot retrieval) fails on **multi-document reasoning** tasks where facts are distributed across documents and must be chained. Multi-hop retrieval is a defining feature of **Agentic RAG** and is central to the [[GraphRAG]] and Corrective RAG architectures. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

## How it works / How it's used
1. **Initial retrieval**: retrieve top-k documents for the original query.
2. **Decomposition / reformulation**: the LLM reads the retrieved context, identifies what information is still missing, and generates a follow-up query.
3. **Next-hop retrieval**: retrieve documents for the follow-up query.
4. **Repeat** until sufficient evidence is gathered or a hop budget is exhausted.
5. **Generation**: the LLM synthesizes the final answer from all collected evidence.

In practice the decomposition step is often driven by an LLM agent or [[Query Expansion|sub-question decomposition]].

## Variants
- **Fixed-pipeline multi-hop**: pre-defined number of hops, no dynamic stopping.
- **Agentic / adaptive multi-hop**: the agent decides when to stop retrieving ([[GraphRAG]], ReAct-style loops).
- **Graph-guided multi-hop**: uses a [[Knowledge Graph]] to traverse entity links explicitly, avoiding free-form retrieval at each hop.

## Trade-offs
- ✅ Handles complex, compositional questions that single-hop RAG cannot answer.
- ✅ Reduces context noise: each hop is targeted, pulling only what's missing.
- ❌ Latency compounds with each hop (multiple retrieval + LLM calls).
- ❌ Error propagation: a wrong intermediate retrieval step can derail subsequent hops.
- ❌ Harder to evaluate: correctness depends on the full chain, not a single retrieval.

## Related pages
- [[Retrieval-Augmented Generation]]
- [[Query Expansion]]
- [[GraphRAG]]
- [[Knowledge Graph]]
- [[Dense Retrieval]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
- [[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]]
