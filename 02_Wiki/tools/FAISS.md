---
type: tool
aliases: [Facebook AI Similarity Search]
tags: [rag, tool, infra, vector-database]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: []
---

# FAISS

> **TL;DR** Meta AI's open-source C++/Python library for billion-scale similarity search — a library, not a server; no persistence, no metadata filtering, but the fastest option for batch offline search.

## What it is
FAISS (Facebook AI Similarity Search) is a library for efficient dense vector search and clustering, developed by Meta AI Research. It provides CPU and GPU implementations of multiple ANN index types and is the backbone underlying several managed [[Vector Database|vector databases]] and RAG frameworks.

FAISS is **not a database** — it has no server, no persistence layer, no metadata filtering, and no CRUD API. It is a compute library you embed into your application.

### Index types
| Index | Description | Use case |
|-------|-------------|----------|
| `IndexFlatL2` / `IndexFlatIP` | Exact brute-force search | Ground truth / small corpora (<1M) |
| `IndexIVFFlat` | Inverted file index — partitions space into Voronoi cells | Medium corpora, ~10× speedup over flat |
| `IndexHNSW` | Hierarchical Navigable Small World graph | Fast approximate search, good recall |
| `IndexIVFPQ` | IVF + Product Quantisation — compresses vectors | Billion-scale, reduces memory 8–64× |
| `IndexPQ` | Pure PQ without IVF | Extreme memory compression |

GPU variants (`GpuIndex*`) are available for all major types.

## When to use it
- ✅ Offline batch processing — embed + search millions of vectors without infrastructure overhead.
- ✅ Maximum throughput — FAISS is the fastest available for large-scale exact or approximate search.
- ✅ Research / prototyping — zero infrastructure, pure Python API.
- ✅ Embedded in a larger application where a server-based [[Vector Database]] would be overkill.
- ❌ Production with real-time updates — FAISS has no incremental add without re-indexing `IndexIVF*`.
- ❌ Metadata filtering needed — FAISS has no payload store; filtering must be done externally.
- ❌ Multi-user / multi-tenant — no access control or concurrency primitives.

## Common usage pattern
```python
import faiss, numpy as np

d = 768  # embedding dimension
index = faiss.IndexHNSWFlat(d, 32)  # M=32 neighbours per node
index.add(np.array(embeddings, dtype="float32"))

D, I = index.search(np.array([query_embedding], dtype="float32"), k=10)
# D = distances, I = indices of top-10 results
```

## Alternatives
| Need | Alternative |
|------|-------------|
| Managed cloud | [[Pinecone]] |
| Self-hosted + metadata filtering | [[Qdrant]], [[Weaviate]] |
| Metadata-heavy + relational | pgvector |
| Framework-native | [[LangChain]] / [[LlamaIndex]] wrap FAISS natively |

## Related pages
- [[Vector Database]]
- [[Dense Retrieval]]
- [[Embeddings]]
- [[Qdrant]]
- [[Pinecone]]
- [[Weaviate]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/; FAISS is described in Johnson et al. 2017 "Billion-scale similarity search with GPUs"
