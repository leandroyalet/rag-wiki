---
type: concept
aliases: [query rewriting, query augmentation]
tags: [rag, retrieval, query]
status: stub
created: 2026-04-18
updated: 2026-05-16
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]", "[[01_Sources/web_clips/Building the Entire RAG Ecosystem and Optimizing Every Component]]"]
---

# Query Expansion

> **TL;DR** Rewriting or augmenting the user's query before retrieval to broaden vocabulary coverage, resolve ambiguity, or generate multiple complementary sub-queries.

## Definition
Query expansion is a pre-retrieval technique that transforms the original user query into one or more alternative or enriched queries. The expanded queries are used to retrieve a larger or more diverse candidate set, which is then merged and optionally [[Reranking|reranked]] before being passed to the LLM.

## Context
A single short user query often under-specifies the information need and misses relevant documents due to vocabulary mismatch. Query expansion is a core component of **Advanced RAG** — sitting before the retrieval step — to increase recall. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

## How it works / How it's used

### Common approaches
- **LLM paraphrasing**: prompt an LLM to rewrite the query in N alternative phrasings → retrieve for each → union results (as in [[RAG-Fusion]]).
- **Sub-question decomposition**: break a complex question into simpler atomic sub-questions, retrieve for each separately (foundation of [[Multi-hop Retrieval]]).
- **Hypothetical Document Embedding ([[HyDE]])**: generate a hypothetical answer document, embed it, and use the embedding as the retrieval query instead of the original question.
- **Keyword extraction**: extract key entities and search for each individually to improve sparse retrieval ([[Sparse Retrieval|BM25]]) coverage.
- **Thesaurus / synonym expansion**: classical IR technique; replaced by LLM-based approaches in modern RAG.

## Variants
- [[HyDE]] — generates a full hypothetical document to bridge the query-document embedding gap.
- [[RAG-Fusion]] — generates multiple query variants, retrieves for each, fuses results with Reciprocal Rank Fusion (RRF).
- **Step-back prompting** — rephrase to a more abstract / higher-level question to retrieve conceptual context first. [[01_Sources/web_clips/Building the Entire RAG Ecosystem and Optimizing Every Component]]
- **Sub-question decomposition** — break a complex question into simpler atomic sub-questions, retrieve independently, then synthesize; implemented in LangChain as `MultiQueryRetriever` with decomposition prompt. [[01_Sources/web_clips/Building the Entire RAG Ecosystem and Optimizing Every Component]]

## Trade-offs
- ✅ Higher recall: more diverse queries surface a wider range of relevant documents.
- ✅ Compensates for vocabulary mismatch between user language and document language.
- ❌ Higher latency: multiple LLM calls and retrieval passes add up.
- ❌ Risk of query drift: an overly broad expansion retrieves irrelevant content, increasing noise in the prompt.
- ❌ Merging and deduplicating multi-query result sets adds pipeline complexity.

## Related pages
- [[Retrieval-Augmented Generation]]
- [[HyDE]]
- [[RAG-Fusion]]
- [[Multi-hop Retrieval]]
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Reranking]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
- [[01_Sources/web_clips/Building the Entire RAG Ecosystem and Optimizing Every Component]]
