---
type: meta
tags: [index, map-of-content]
updated: 2026-05-08
---

# Index — Entry map to the RAG wiki

This is the file you **always** look at first. Both Claude and any new human in the vault enter through here. Karpathy calls it the `index.md`: it works as a Wikipedia-style landing page for our small knowledge universe.

Keep this page up to date by hand or with `/update-index`. If it grows too big, that's a signal to split by sub-topic.

---

## 🧭 Knowledge tracks

### Concepts (23)

- [[Answer Relevance]] — Evaluation metric measuring whether the generated answer actually addresses the question asked — penalises incomplete, off-topic, or redundant answers without requiring a reference answer.
- [[BM25]] — The dominant lexical ranking function — a probabilistic TF-IDF variant that saturates term frequency and penalises long documents. Standard baseline for sparse retrieval in every RAG pipeline.
- [[Cache-Augmented Generation]] — An alternative to RAG that preloads a curated knowledge snapshot directly into the LLM's context window before query time, eliminating retrieval latency and noise at the cost of context-window capacity and cache staleness.
- [[Chunking]] — Splitting source documents into smaller, overlapping pieces before indexing so that each retrieved passage is semantically focused and fits the LLM's context window.
- [[Context Relevance]] — A RAG evaluation metric that measures how much of the retrieved context actually pertains to the query — high context relevance means little noise was injected into the prompt.
- [[Dense Retrieval]] — Retrieving documents by nearest-neighbor search in embedding space rather than keyword overlap — captures semantic similarity but requires a bi-encoder and an ANN index.
- [[Embeddings]] — Fixed-dimension floating-point vectors that encode the semantic meaning of text, enabling similarity search in a [[Vector Database]] instead of keyword matching.
- [[Faithfulness]] — A RAG evaluation metric that measures whether every claim in the generated answer can be traced back to the retrieved context — a score of 1.0 means no hallucination.
- [[Federated RAG]] — An architecture that combines Federated Learning (distributed model training, raw data never leaves the client) with RAG (grounding LLM responses in external knowledge) — enabling knowledge-intensive LLM applications in privacy-sensitive domains like healthcare and finance.
- [[Hallucination in RAG]] — When a RAG system generates claims not supported by the retrieved context — caused by retriever failure, context overload, or the LLM's tendency to fill gaps with parametric knowledge.
- [[Knowledge Graph]] — A graph-structured store of entities and typed relations, queryable with SPARQL, that acts as an external knowledge source for RAG systems.
- [[Labeled Property Graph]] — A graph data model representing data as nodes and edges with key-value property labels — optimised for traversal and analytics; no formal schema standard, but widely used in production knowledge graphs.
- [[LLM-as-Judge]] — Using a large language model (typically GPT-4 or similar) as an automatic evaluator that assigns quality scores to generated text — a scalable proxy for expensive human annotation.
- [[Multi-hop Retrieval]] — Answering complex questions that require chaining multiple retrieval steps — each step uses what was just found to formulate the next query.
- [[Multimodal Embeddings]] — Embedding models that map text, images, audio, and video into a single shared vector space — enabling cross-modal similarity search (e.g., text query → image results) using the same cosine-similarity infrastructure as text-only RAG.
- [[Query Expansion]] — Rewriting or augmenting the user's query before retrieval to broaden vocabulary coverage, resolve ambiguity, or generate multiple complementary sub-queries.
- [[RAG Failure Points]] — A seven-point taxonomy of where production RAG systems break down — from missing source content to LLM formatting failures — derived from case studies across research, education, and biomedical domains.
- [[RAG Triad]] — Three-metric evaluation framework for RAG pipelines — Context Relevance, Groundedness, and Answer Relevance — covering every stage where failure can occur.
- [[RDF]] — W3C's standard for representing knowledge as subject–predicate–object triples — the foundation for SPARQL, OWL reasoning, and semantic knowledge graphs in RAG pipelines.
- [[Retrieval-Augmented Generation]] — Two-stage architecture — *retrieve* relevant documents from an external store, then *generate* a response conditioned on them — that lets an LLM answer about specific or up-to-date information without being retrained.
- [[Shape Expressions]] — A schema language for RDF/SPARQL graphs that enumerates valid predicates and target types per class — used in RAG pipelines to validate generated SPARQL and prevent hallucinated property names.
- [[Sparse Retrieval]] — Retrieving documents by token-overlap scoring ([[BM25]], TF-IDF) — fast, interpretable, and excellent for exact-match queries; misses semantic similarity.
- [[Vector Database]] — A database purpose-built to store embedding vectors and run fast Approximate Nearest Neighbor (ANN) search, forming the retrieval backbone of most RAG systems.

### Methods & Techniques (13)

- [[Adaptive Chunking]] — Per-document chunking strategy selection guided by five intrinsic quality metrics — moving away from "one-size-fits-all" splitting to document-aware preprocessing that improves RAG answer correctness by ~10 percentage points.
- [[Contextual Retrieval]] — Prepend a short LLM-generated context summary to each chunk before embedding and BM25 indexing, so isolated chunks retain the document-level information needed to be retrieved correctly — reducing top-20 retrieval failures by 49%, and 67% when combined with reranking.
- [[Fusion-in-Decoder]] — Encode each retrieved passage independently with a T5 encoder, then concatenate all representations for the decoder — enabling the model to attend jointly across all passages at generation time without the quadratic cost of encoding them together.
- [[GraphRAG]] — Builds a knowledge graph and multi-level community summaries from the corpus at index time, then answers queries by graph traversal — enabling holistic, cross-document reasoning that naive vector search cannot do.
- [[Hybrid Search]] — Combine [[Sparse Retrieval]] ([[BM25]]) and [[Dense Retrieval]] (embeddings) and fuse their rankings to get better recall than either alone.
- [[HyDE]] — Instead of embedding the query directly, ask an LLM to generate a **hypothetical** document that would answer it, and use *that* embedding to search. Improves recall in zero-shot retrieval.
- [[Late Chunking]] — Embed the full document first using a long-context model, then segment at the token-embedding level — so each chunk retains global document context rather than being encoded in isolation.
- [[MoC]] — A granularity-aware routing framework that sends text to specialized small LMs based on target chunk size, each of which outputs regex boundary markers rather than full text — achieving LLM-level chunking quality at small-model cost.
- [[RAG-Fusion]] — Generate N query variants with an LLM, retrieve for each independently, then merge all result lists with Reciprocal Rank Fusion — improving recall without modifying the retriever.
- [[RAPTOR]] — Recursively clusters and summarises chunks into a tree of increasing abstraction; retrieval searches all levels simultaneously — getting precise detail or high-level themes as the query demands.
- [[Reciprocal Rank Fusion]] — Score-free rank aggregation that merges multiple ranked lists into one by summing reciprocal ranks — the standard fusion step in [[Hybrid Search]] and [[RAG-Fusion]].
- [[Reranking]] — A second-stage pass that rescores a small candidate set from the bi-encoder with a slower but more accurate cross-encoder, improving precision before passing context to the LLM.
- [[Text-to-SPARQL]] — Translating natural-language questions into SPARQL queries — typically by combining a RAG retrieval step (example Q/A pairs + schema context) with a validation loop that checks and corrects the generated query.

### Models (4)

- [[BGE]] — Family of dense embedding models from BAAI (Beijing Academy of AI), frequently used as the retriever backbone in RAG pipelines for their strong performance on MTEB benchmarks.
- [[ColBERT]] — Late-interaction retrieval model that keeps per-token embeddings for each document and scores query-document similarity via MaxSim at query time — bridging the quality of cross-encoders with the pre-computation efficiency of bi-encoders.
- [[E5]] — Microsoft's family of text embedding models (EmbEddings from bidirEctional Encoder rEpresentations), trained with weakly-supervised contrastive learning on large web text pairs — strong across MTEB tasks, especially retrieval.
- [[Sentence-BERT]] — The 2019 model that made BERT usable for semantic similarity at scale — a siamese bi-encoder that pools BERT into fixed-length sentence vectors, enabling cosine-similarity search without expensive pairwise inference.

### Benchmarks & Evaluation (5)

- [[BEIR]] — A heterogeneous retrieval benchmark covering 18 datasets across 9 diverse domains — the standard zero-shot transfer test for dense and sparse retrieval models.
- [[IRPAPERS]] — A 3,230-page visual benchmark of IR scientific papers comparing image- and text-based retrieval and QA, with the key finding that neither modality dominates and multimodal fusion gives the best results.
- [[KILT]] — A unified benchmark covering 11 knowledge-intensive NLP tasks — QA, slot filling, fact-checking, dialogue, and entity linking — all grounded against the same Wikipedia snapshot, enabling apples-to-apples comparison of retrieval systems.
- [[MME]] — The first comprehensive evaluation benchmark for Multimodal LLMs — 14 subtasks across perception and cognition, manually annotated to prevent data leakage, with a binary yes/no instruction format that enables clean quantitative comparison.
- [[MTEB]] — The standard leaderboard for text embedding models — 8 task types, 181 datasets, evaluated on NDCG@10 for retrieval — the first stop when choosing an embedding model for RAG.

### Infrastructure & Tools (20)

**Vector stores**
- [[FAISS]] — Meta AI's open-source C++/Python library for billion-scale similarity search — a library, not a server; no persistence, no metadata filtering, but the fastest option for batch offline search.
- [[Pinecone]] — Fully managed, serverless vector database — zero infrastructure ops, real-time updates, metadata filtering, and namespaces; the easiest path to production vector search at the cost of vendor lock-in.
- [[Qdrant]] — Open-source vector database (Rust) offering cosine/dot/Euclidean similarity search with filtering, used as the retrieval backend in RAG pipelines.
- [[Weaviate]] — Open-source vector database with built-in hybrid search ([[BM25]] + vector), a modular architecture that can embed models directly, and strong multi-tenancy support — self-hosted or managed via Weaviate Cloud.

**Graph databases**
- [[FalkorDB]] — A [[Labeled Property Graph]] database built as a Redis module, using GraphBLAS sparse-matrix operations for ultra-low-latency graph queries — marketed specifically as the graph backend for [[GraphRAG]] and agentic AI pipelines.

**Frameworks & orchestration**
- [[BeyondLLM]] — Lightweight open-source Python framework by AI Planet for building and evaluating RAG pipelines with HuggingFace models in a few lines of code — includes built-in RAG Triad evaluation.
- [[Haystack]] — Open-source AI orchestration framework by deepset built around composable, serializable pipelines of typed components — designed for production RAG, agentic loops, and multi-modal applications with full transparency into every processing step.
- [[Instructor]] — Python library that wraps LLM clients (OpenAI, Anthropic, Gemini, and 12+ others) to enforce Pydantic-validated structured output — retrying with error feedback on validation failure until the model produces a conforming response.
- [[LangChain]] — The most widely adopted open-source LLM framework — provides a composable expression language (LCEL) for chains and agents, with 500+ integrations and a large community ecosystem.
- [[LlamaIndex]] — Python/TypeScript framework purpose-built for LLM-powered data retrieval — excels at data connectors, flexible index types, and composable query engines over private documents and databases.

**Document parsing & ingestion**
- [[Docling]] — IBM Research's open-source document parser that converts PDFs, DOCX, PPTX, HTML, and other formats into clean Markdown or structured JSON — the ingestion layer before chunking in a RAG pipeline.
- [[Kreuzberg]] — Rust-core document extraction library with Python and 10+ language bindings — extracts text, metadata, tables, and code intelligence from 91+ file formats at native speeds, with multiple OCR backends and a token-efficient wire format for LLM/RAG pipelines.
- [[MarkItDown]] — Microsoft's lightweight Python utility that converts PDFs, Office files, images, audio, HTML, and more into Markdown — optimised for feeding LLM pipelines, not for human-readable output.
- [[Unstructured]] — Open-source Python toolkit (Apache-2.0) that partitions documents into typed semantic elements (Title, NarrativeText, Table, …) before chunking — the most widely-adopted open-source ingestion layer for RAG pipelines, with 20+ source/destination connectors and native LangChain/LlamaIndex integrations.

**Evaluation**
- [[ARES]] — Stanford's automated RAG evaluation system — fine-tunes lightweight LLM judges on synthetic data, then uses prediction-powered inference (PPI) with a few hundred human annotations to produce statistically calibrated scores.
- [[DeepEval]] — Open-source LLM evaluation framework by Confident AI with a pytest-like interface, covering RAG, agents, and general LLM quality via 14+ built-in metrics.
- [[MLflow]] — Open-source MLOps platform by Databricks for experiment tracking, model registry, and deployment — increasingly used for LLM/RAG evaluation logging via its `mlflow.evaluate()` API.
- [[RAGAS]] — Reference-free evaluation framework that scores RAG pipelines across faithfulness, answer relevance, and context quality — no ground-truth labels required.
- [[TruLens]] — Open-source LLM evaluation and runtime monitoring framework by TrueRA, built around the **RAG Triad** (Context Relevance, Groundedness, Answer Relevance) — instruments your pipeline to log every step and score it with configurable feedback functions.
- [[VERA]] — A RAG evaluation framework that consolidates multiple metrics into a single cross-encoder ranking score and adds Bootstrap confidence bounds — providing statistical rigour absent from RAGAS-style metric suites.

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
