---
type: concept
aliases: [vector store, ANN index, embedding store]
tags: [rag, infra, retrieval]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]"]
---

# Vector Database

> **TL;DR** A database purpose-built to store embedding vectors and run fast Approximate Nearest Neighbor (ANN) search, forming the retrieval backbone of most RAG systems.

## Definition
A vector database stores numerical vectors (produced by [[Embeddings]] models) alongside payload metadata, and provides similarity search over those vectors via ANN algorithms such as HNSW (Hierarchical Navigable Small World) or IVF (Inverted File Index). It returns the k vectors closest to a query vector in O(log n) rather than O(n) time.

## Context
Vector databases are the persistence layer for the offline indexing phase and the search engine for the online retrieval phase of RAG. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

They pair with:
- An [[Embeddings]] model to produce and query vectors.
- Optional metadata filters for hybrid structured + semantic search.
- A [[Reranking]] step downstream to refine results.

Many systems also support [[Hybrid Search]] by combining ANN with a [[Sparse Retrieval|[[BM25]] index]] in the same query.

## How it works / How it's used
1. **Indexing**: document [[Chunking|chunks]] are embedded → upserted into the vector DB with a unique ID and payload (source, page number, etc.).
2. **Query**: the user query is embedded → the DB performs ANN search → returns top-k (ID, score, payload) tuples.
3. **Filtering**: metadata filters (e.g., `doc_type == "contract"`) can narrow the search space before or after ANN.

## Variants / Examples
| Tool | Hosting | Highlights |
|------|---------|------------|
| [[Qdrant]] | Self-hosted / Cloud | Rust core, rich filtering, cosine/dot/Euclidean |
| [[Pinecone]] | Managed cloud | Serverless, no ops |
| [[FAISS]] | Library (no server) | Fastest for batch offline search, Meta OSS |
| [[Weaviate]] | Self-hosted / Cloud | GraphQL API, built-in [[BM25]] hybrid |
| [[Infinity]] | Self-hosted (single binary) | Dense + sparse + tensor + full-text hybrid; 0.1 ms vector latency; no external dependencies; InfiniFlow |
| [[Milvus]] | Self-hosted / Zilliz Cloud | Go+C++, HNSW/DiskANN/GPU (CAGRA), sparse BM25, Kubernetes-native |
| Chroma | Embedded / Hosted | Lightweight, popular in prototypes |
| pgvector | PostgreSQL extension | Keeps vectors inside the relational DB |

## Trade-offs
- ✅ Sub-linear ANN search at billions-of-vectors scale.
- ✅ Metadata filtering allows structured + semantic queries.
- ✅ Managed services (Pinecone, Weaviate Cloud) eliminate ops burden.
- ❌ ANN is approximate: recall is tunable but never 100 %.
- ❌ Index must be rebuilt/updated when the embedding model changes.
- ❌ Adds infrastructure complexity vs. a plain SQL or search engine.

> **Developer note**: a vector DB is *not* always necessary. For corpora under ~10k documents, in-memory FAISS or even brute-force cosine search is often fast enough. [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]

## Related pages
- [[Embeddings]]
- [[Dense Retrieval]]
- [[Hybrid Search]]
- [[Chunking]]
- [[Qdrant]]
- [[Pinecone]]
- [[FAISS]]
- [[Weaviate]]
- [[Infinity]]
- [[Milvus]]

## Sources
- [[01_Sources/web_clips/iwai-2026-rag-architectures-roadmap]]
