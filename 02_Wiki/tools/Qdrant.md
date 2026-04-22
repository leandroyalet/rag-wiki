---
type: tool
aliases: []
tags: [rag, tool, infra, vector-database]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[emonet2024sparql]]"]
---

# Qdrant

> **TL;DR** Open-source vector database (Rust) offering cosine/dot/Euclidean similarity search with filtering, used as the retrieval backend in RAG pipelines.

## What it is
Qdrant is a high-performance [[Vector Database]] designed for embedding-based similarity search. It stores vectors alongside arbitrary JSON payloads and supports filtering, named collections, and HNSW indexing. It has an HTTP API and Python/JS/Rust clients.

In [[Text-to-SPARQL]] RAG pipelines it stores indexed example question/query pairs and schema class labels, retrieved at query time via cosine similarity. [[emonet2024sparql]]

## When to use it
- Self-hosted or cloud deployment needed (Qdrant Cloud available).
- Payloads need rich metadata filtering alongside vector search.
- Rust performance characteristics matter at scale.

## Alternatives
- [[Pinecone]] — fully managed, no self-hosting.
- [[FAISS]] — library (no server), best for offline batch search.
- [[Weaviate]] — adds GraphQL query layer.

## Sources
- [[emonet2024sparql]]
