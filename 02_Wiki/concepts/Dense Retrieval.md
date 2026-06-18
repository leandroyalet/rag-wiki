---
type: concept
aliases: [dense passage retrieval, DPR, semantic retrieval]
tags: [rag, retrieval]
status: stub
created: 2026-04-18
updated: 2026-06-18
sources: ["[[lewis2020rag]]", "[[01_Sources/web_clips/embedding-models-for-rag]]", "[[oche2025ragsurvey]]", "[[chen2024densex]]", "[[sen2026grep]]"]
---

# Dense Retrieval

> **TL;DR** Retrieving documents by nearest-neighbor search in embedding space rather than keyword overlap — captures semantic similarity but requires a bi-encoder and an ANN index.

## Definition
Dense retrieval encodes both queries and documents as continuous vectors using a bi-encoder model. At query time, an Approximate Nearest Neighbor (ANN) search over the document index returns the top-k closest passages by cosine or dot-product similarity. It contrasts with [[Sparse Retrieval]] ([[BM25]], TF-IDF), which matches on exact token overlap.

The canonical instantiation is **DPR (Dense Passage Retrieval)**, introduced alongside the original RAG paper: a BERT bi-encoder trained on Natural Questions and TriviaQA. [[lewis2020rag]] Retrievers are trained via **contrastive loss** — maximizing similarity for relevant query-passage pairs while minimizing it for hard negatives. [[oche2025ragsurvey]]

## Context
Dense retrieval is the default first-stage retriever in modern RAG pipelines. It is paired with [[Embeddings]] for encoding and a [[Vector Database]] for the ANN index. Optionally, a [[Reranking]] step follows to re-score the top-k candidates with a cross-encoder. [[01_Sources/web_clips/embedding-models-for-rag]]

## How it works / How it's used
1. **Offline**: every document chunk is embedded → stored in a [[Vector Database]] (HNSW/IVF index).
2. **Online**: user query is embedded with the same model → ANN search retrieves top-k chunks → chunks are passed to the LLM.

## Retrieval granularity
The choice of index unit — document, passage, sentence, or proposition — significantly impacts retrieval quality independently of the retriever model. [[DenseX]] (Chen et al. 2024) shows that indexing a corpus at the **proposition level** improves average Recall@5 by +9–12 points for unsupervised retrievers across five QA datasets, by providing higher signal-to-noise per token. [[chen2024densex]]

## Variants
- **Single-vector bi-encoder** (DPR, [[BGE]], [[E5]]) — one vector per passage; fast, scalable.
- **Late interaction / multi-vector** ([[ColBERT]]) — per-token vectors; MaxSim scoring; higher accuracy at higher storage cost.
- **Asymmetric retrieval** — query and document encoders are separate models (allows different-length optimization).

## In agentic search
When dense retrieval is one tool among several in an [[Agentic Search]] loop, its end-to-end effectiveness is not a property of the retriever alone. In a 116-question [[LongMemEval]] study, **inline vector retrieval lost to inline `grep` for every harness–model pair**, and the gap depended strongly on the [[Agent Harness]] and on whether results were delivered inline or via files. Dense retrieval is "deliberately broad": it surfaces paraphrases and oblique mentions but also elevates semantically *near* distractors, which hurts when questions are short or under-specified. File-based ("programmatic") delivery sometimes lets vector exceed grep, because large vector result dumps no longer crowd the context window. [[sen2026grep]]

## Trade-offs
- ✅ Retrieves semantically related passages even without exact keyword match.
- ✅ Scales to billions of documents with ANN indexes (HNSW, ScaNN).
- ❌ Misses exact keyword matches that [[Sparse Retrieval]] catches (e.g., rare proper nouns, codes).
- ❌ Embedding quality is distribution-dependent; degrades on out-of-domain text.
- ❌ ANN index must be rebuilt or updated when the corpus changes.

## Related pages
- [[Embeddings]]
- [[Sparse Retrieval]]
- [[Hybrid Search]]
- [[Vector Database]]
- [[Reranking]]
- [[ColBERT]]
- [[Retrieval-Augmented Generation]]
- [[Agentic Search]]

## Sources
- [[lewis2020rag]]
- [[01_Sources/web_clips/embedding-models-for-rag]]
- [[oche2025ragsurvey]]
- [[sen2026grep]]
