---
type: meta
tags: [glossary]
updated: 2026-04-18
---

# Glossary

One-line definitions. If a term deserves more, give it its own page in `02_Wiki/` and link it here.

| Term              | Short definition                                                                                     | Page                               |
| ----------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------- |
| **RAG**           | Retrieval-Augmented Generation: LLM generation conditioned on documents retrieved at inference time. | [[Retrieval-Augmented Generation]] |
| **Chunking**      | Splitting documents into fragments for indexing.                                                     | [[Chunking]]                       |
| **Embedding**     | Dense vector representation of a text.                                                               | [[Embeddings]]                     |
| **Reranker**      | Model that reorders retrieved candidates by fine-grained relevance to the query.                     | [[Reranking]]                      |
| **BM25**          | Classic lexical ranking function, strong baseline for sparse retrieval.                              | [[Sparse Retrieval]]               |
| **HyDE**          | Hypothetical Document Embeddings: generate a hypothetical answer document to improve recall.         | [[HyDE]]                           |
| **Hallucination** | When the LLM produces content not supported by the retrieved context.                                | [[Hallucination in RAG]]           |
| **Faithfulness**  | How well the answer sticks to the retrieved context.                                                 | [[Faithfulness]]                   |
| **Citekey**       | Unique identifier of a reference. Vault format: `authEtal2+year` (e.g., `lewisEtal2020`).            | —                                  |

_Keep this table alphabetized._
