---
type: tool
aliases: [Weaviate vector database]
tags: [rag, tool, infra, vector-database]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: []
---

# Weaviate

> **TL;DR** Open-source vector database with built-in hybrid search ([[BM25]] + vector), a modular architecture that can embed models directly, and strong multi-tenancy support — self-hosted or managed via Weaviate Cloud.

## What it is
Weaviate (BSD-3 licence) is an open-source [[Vector Database]] built in Go, developed by Weaviate B.V. Its distinguishing features are a **module system** (plug in embedding models, generative models, or rerankers directly into the database) and first-class [[Hybrid Search]] support combining [[BM25]] sparse retrieval with dense ANN search in a single query.

### Key features
| Feature | Description |
|---------|-------------|
| **Hybrid search** | [[BM25]] + vector fusion in one API call; weight configurable via `alpha` |
| **Module system** | Embed `text2vec-openai`, `text2vec-cohere`, `multi2vec-clip`, etc. — vectorisation happens inside the DB |
| **Generative modules** | `generative-openai`, `generative-cohere` — RAG in a single GraphQL query |
| **Multi-tenancy** | First-class tenant isolation per collection with automatic data partitioning |
| **BQ / PQ compression** | Binary Quantisation and Product Quantisation reduce memory usage |
| **HNSW + flat index** | HNSW for ANN at scale; flat index for exact search on small collections |
| **GraphQL & REST API** | Rich query interface; GraphQL enables filtered aggregations and joins |
| **Cross-references** | Link objects across classes — property-graph-like relationships |

### Deployment options
- **Weaviate Cloud** — fully managed SaaS (free sandbox tier available).
- **Docker** — single-command local setup: `docker run weaviate/weaviate`.
- **Kubernetes** (Helm chart) — production self-hosted deployment.
- **Embedded Weaviate** — in-process Python/JS instance for quick evaluation.

### Minimal RAG example (Python)
```python
import weaviate
client = weaviate.connect_to_local()

# Hybrid search
results = client.collections.get("Documents").query.hybrid(
    query="what is retrieval augmented generation",
    alpha=0.5,  # 0 = pure BM25, 1 = pure vector
    limit=5,
)
```

## When to use it
- ✅ Hybrid search needed out of the box — no external [[BM25]] index required.
- ✅ Modules preferred over external embedding calls — reduces latency and simplifies pipeline.
- ✅ Multi-tenant SaaS — best-in-class tenant isolation primitives.
- ✅ Open-source + self-hosted with cloud-managed option.
- ❌ Pure Python / lightweight deployment — [[Qdrant]] (Rust) or [[FAISS]] have lower overhead.
- ❌ Maximum ANN throughput — [[Qdrant]] benchmarks faster on raw vector search.

## Alternatives
| Need | Alternative |
|------|-------------|
| Maximum performance, self-hosted | [[Qdrant]] |
| Fully managed, no ops | [[Pinecone]] |
| Offline batch search | [[FAISS]] |

## Related pages
- [[Vector Database]]
- [[Hybrid Search]]
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Qdrant]]
- [[Pinecone]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/; information from docs.weaviate.io
