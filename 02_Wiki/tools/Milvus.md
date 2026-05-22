---
type: tool
aliases: [pymilvus, Milvus Lite, Zilliz]
tags: [rag, tool, infra, vector-database]
status: stub
created: 2026-05-16
updated: 2026-05-16
sources: ["[[01_Sources/web_clips/milvus-vector-database]]"]
homepage: https://milvus.io
repo: https://github.com/milvus-io/milvus
---

# Milvus

> **TL;DR** Open-source, distributed, Kubernetes-native vector database (Go + C++) for billion-scale ANN search — supports HNSW, IVF, DiskANN, GPU indexing (NVIDIA CAGRA), sparse vectors, and hybrid BM25+dense search out of the box.

## What it is
Milvus is a [[Vector Database]] purpose-built for AI-scale similarity search. It stores embedding vectors with arbitrary metadata payloads and runs fast Approximate Nearest Neighbor (ANN) search at tens of thousands of queries-per-second over billions of vectors. It separates compute and storage layers, enabling independent horizontal scaling of query and data nodes. [[01_Sources/web_clips/milvus-vector-database]]

Governed by the LF AI & Data Foundation; Apache 2.0 licence; backed primarily by Zilliz.

## Deployment options

| Mode | When to use |
|------|-------------|
| **Milvus Lite** (`pip install pymilvus[milvus-lite]`) | Local dev, prototypes, single machine |
| **Standalone** | Single-node production or evaluation |
| **Distributed cluster** | Kubernetes, production at scale |
| **Zilliz Cloud** | Fully managed (Serverless / Dedicated / BYOC); zero infrastructure ops |

## Key capabilities
- **Index types**: HNSW, IVF, FLAT, SCANN, DiskANN; quantisation variants; memory-mapped indexing.
- **GPU indexing**: NVIDIA CAGRA for GPU-accelerated search.
- **Sparse vector support**: native BM25, SPLADE, and BGE-M3 for full-text / [[Hybrid Search]].
- **Metadata filtering**: structured predicates alongside ANN queries.
- **Multi-tenancy**: scoped at database, collection, partition, and partition-key levels.
- **Hot/cold storage**: cost-optimised tiered storage for large corpora.
- **Real-time streaming updates**: live inserts without full index rebuild.
- **Security**: mandatory authentication, TLS, Role-Based Access Control (RBAC).

## Quick start
```python
from pymilvus import MilvusClient

client = MilvusClient("milvus_demo.db")          # Milvus Lite — local file
# client = MilvusClient(uri="...", token="...")   # Zilliz Cloud / cluster

client.create_collection("docs", dimension=1536)
client.insert("docs", [{"id": 1, "vector": [...], "text": "..."}])
results = client.search("docs", query_vectors=[[...]], limit=5)
```

## Ecosystem integrations
- **RAG frameworks**: [[LangChain]], [[LlamaIndex]], [[Haystack]]
- **Embedding providers**: OpenAI, HuggingFace
- **Data connectors**: Spark, Kafka, Fivetran, Airbyte
- **Observability**: Prometheus / Grafana; Attu (GUI admin); Birdwatcher (debug CLI)

## When to use / when not to
- ✅ Billion-scale vector workloads requiring horizontal scaling.
- ✅ GPU-accelerated search (NVIDIA CAGRA).
- ✅ Hybrid sparse+dense search without a separate BM25 engine.
- ✅ Need a managed cloud option (Zilliz) with the same API.
- ❌ Simple prototypes — Milvus Lite or [[FAISS]] suffice and add less overhead.
- ❌ Relational-first workloads — pgvector keeps vectors inside an existing Postgres DB.

## Related / alternatives
- [[Vector Database]] — parent concept.
- [[FAISS]] — library (no server), best for offline batch search.
- [[Qdrant]] — Rust-core, rich filtering; simpler ops than full Milvus cluster.
- [[Pinecone]] — fully managed, no self-hosting option.
- [[Weaviate]] — built-in BM25 hybrid, GraphQL API.
- [[Hybrid Search]] — Milvus supports this natively via sparse vector indexing.

## Sources
- [[01_Sources/web_clips/milvus-vector-database]]
