---
type: method
aliases: [Hypothetical Document Embeddings]
tags: [rag, retrieval, query-expansion]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: ["[[gao2023hyde]]"]
introduced_by: "Luyu Gao et al."
year: 2023
---

# HyDE

> **TL;DR** Instead of embedding the query directly, ask an LLM to generate a **hypothetical** document that would answer it, and use *that* embedding to search. Improves recall in zero-shot retrieval.

## Problem it solves
A query is typically short (5–15 tokens), under-specified, and sits in a region of embedding space distinct from long documents. This introduces a **query–document gap**: cosine similarity between a query and a relevant document is usually lower than between two documents on the same topic.

## Key idea
LLMs are good at generating plausible text. If we ask the LLM *"write a paragraph that answers this question"*, the result has length and lexical distribution similar to corpus documents, even if it contains factual errors. **For retrieval it doesn't matter whether the synthetic document is true; it matters that it's close to the real document in embedding space.**

## Pipeline
1. Original query `q`.
2. InstructGPT (or equivalent) generates `d_hypothetical = generate("Write a paragraph answering: {q}")`.
3. Contriever (or another unsupervised encoder) embeds `d_hypothetical` → `e_hyp`.
4. Nearest-neighbour search over corpus using `e_hyp`.
5. Retrieved **real** documents fed to the final LLM — the hypothetical document is discarded.

The contrastive encoder's dense bottleneck filters out factual errors in the hypothetical; only the topical signal survives [[gao2023hyde]].

## When to use / when not to
- ✅ Short or ambiguous queries, technical corpora where the query's jargon doesn't match the doc's.
- ✅ Zero-shot setups with no training data to fine-tune the retriever.
- ❌ Queries already specific and aligned with the corpus: adds latency without recall gain.
- ❌ Domains where the LLM consistently generates out-of-distribution content (may *hurt* retrieval by introducing noise).

See [[_meta/open-questions#Q3|Q3 — When does HyDE actually help?]].

## Empirical results
- Significant NDCG@10 gains over [[BM25]] and Contriever on BEIR (16 datasets: SCIFACT, TREC-COVID, NFCorpus, etc.) [[gao2023hyde]].
- Competitive with supervised fine-tuned DPR despite zero relevance labels [[gao2023hyde]].
- Multilingual: generating in-language hypotheticals (Swahili, Korean, Japanese) transfers without any labelled data [[gao2023hyde]].

## Trade-offs
- ✅ No training required.
- ✅ Easy to add to an existing pipeline.
- ✅ Generalises multilingually without additional supervision.
- ❌ Adds an extra LLM call per query (latency + cost).
- ❌ If the LLM generates out-of-distribution hypotheticals, retrieval can degrade rather than improve [[gao2023hyde]].

## Related
- [[Query Expansion]] — HyDE is a special case with generative expansion.
- [[Dense Retrieval]] — HyDE is an embedding trick over the dense retriever.
- [[RAG-Fusion]] — alternative based on multi-query instead of a hypothetical document.

## Sources
- [[gao2023hyde]] — *Precise Zero-Shot Dense Retrieval without Relevance Labels*.
