---
type: meta
tags: [index, map-of-content]
updated: 2026-04-18
---

# Index — Entry map to the RAG wiki

This is the file you **always** look at first. Both Claude and any new human in the vault enter through here. Karpathy calls it the `index.md`: it works as a Wikipedia-style landing page for our small knowledge universe.

Keep this page up to date by hand or with `/update-index`. If it grows too big, that's a signal to split by sub-topic.

---

## 🧭 Knowledge tracks

### Fundamentals
- [[Retrieval-Augmented Generation]] — the umbrella
- [[Dense Retrieval]] — dense retrieval with embeddings
- [[Sparse Retrieval]] — BM25, TF-IDF
- [[Hybrid Search]] — combining dense + sparse
- [[Embeddings]]
- [[Vector Database]]
- [[Chunking]]

### Advanced techniques
- [[HyDE]] — Hypothetical Document Embeddings
- [[RAG-Fusion]]
- [[RAPTOR]] — recursive clustering
- [[GraphRAG]]
- [[Reranking]]
- [[Query Expansion]]
- [[Multi-hop Retrieval]]

### Evaluation
- [[RAGAS]]
- [[MTEB]] — Massive Text Embedding Benchmark
- [[BEIR]]
- [[Hallucination in RAG]]
- [[Faithfulness]]
- [[Context Relevance]]

### Models
- [[Sentence-BERT]]
- [[E5]]
- [[BGE]]
- [[ColBERT]]

### Infrastructure and tools (`02_Wiki/tools/`)
- [[Pinecone]]
- [[Weaviate]]
- [[Qdrant]]
- [[FAISS]]
- [[LlamaIndex]]
- [[LangChain]]

---

## 📚 Collections

- [[_meta/reading-list|📖 Reading list]] — what to read next
- [[_meta/glossary|🔤 Glossary]] — short definitions for each term
- [[_meta/open-questions|❓ Open questions]] — what the team hasn't resolved yet
- [[_meta/contradictions|⚠️ Detected contradictions]] — claims in tension across sources

---

## 🧪 Active projects

- [[03_Projects/README|See all projects]]

---

## 🧑‍🤝‍🧑 Team and processes

- [[_meta/CONTRIBUTING|How to contribute]]
- [[_meta/log|Vault log]] (append-only)
- [[CLAUDE|CLAUDE.md — vault schema]]

---

> This index is a **living map**. If you added an important page and it's not linked from here, it's orphaned and the team probably won't find it. Link it or ask Claude: `/update-index`.
