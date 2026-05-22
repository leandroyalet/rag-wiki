---
type: tool
aliases: [Infinity DB, infiniflow/infinity]
tags: [rag, tool, infra, vector-database, hybrid-search]
status: stub
created: 2026-05-17
updated: 2026-05-17
sources: ["[[01_Sources/web_clips/infiniflow-ragflow-infinity]]"]
homepage: https://infiniflow.org
repo: https://github.com/infiniflow/infinity
---

# Infinity

> **TL;DR** AI-native, single-binary database (no external dependencies) by InfiniFlow for LLM applications — supports dense, sparse, tensor, and full-text hybrid search with sub-millisecond vector latency and 15K+ QPS on million-scale datasets.

## What it is
Infinity is a purpose-built [[Vector Database]] for LLM applications from InfiniFlow (the same team behind [[RAGFlow]]). Its single-binary, dependency-free architecture makes it the lightest production-ready option for hybrid AI search. It is the default search backend for RAGFlow but is independently deployable. [[01_Sources/web_clips/infiniflow-ragflow-infinity]]

## Search capabilities
Infinity uniquely combines four search modalities in a single engine [[01_Sources/web_clips/infiniflow-ragflow-infinity]]:

| Modality | Use case |
|----------|----------|
| **Dense embedding** | Semantic similarity (standard ANN search) |
| **Sparse embedding** | Keyword-weighted semantic search (SPLADE, BGE-M3) |
| **Tensor search** | Late-interaction models ([[ColBERT]]-style) |
| **Full-text search** | BM25 lexical search |

All four can be combined in a single hybrid query with configurable fusion (RRF, weighted sum, or [[ColBERT]] reranking).

## Performance
| Workload | Latency | QPS |
|----------|---------|-----|
| Vector search (million-scale) | **0.1 ms** | 15K+ |
| Full-text search (33M docs) | **1 ms** | 12K+ |

[[01_Sources/web_clips/infiniflow-ragflow-infinity]]

## Deployment options
| Mode | How |
|------|-----|
| Docker | `docker run` on Linux x86_64, macOS, Windows (WSL2) |
| Binary | Separate server + client processes |
| Python module | Embedded in-process (`import infinity_embedded`) |

**No external dependencies** — no Kafka, Zookeeper, etcd, or separate vector engine required.

## Language bindings
- **Python SDK** (primary): `pip install infinity-sdk`
- **HTTP API**

System requirements: x86_64 CPU with AVX2, Python 3.11+, glibc 2.17+ (Linux).

## When to use / when not to
- ✅ Need all four search modalities (dense + sparse + tensor + full-text) without stitching multiple systems together.
- ✅ Deploying RAGFlow — Infinity is the native, preferred backend.
- ✅ Minimal operational overhead required (single binary, no deps).
- ✅ Python-embedded mode for local or lightweight deployments.
- ❌ Need a mature managed cloud offering — Infinity is primarily self-hosted.
- ❌ Ecosystem integrations with LangChain/LlamaIndex are the priority — [[Milvus]], [[Qdrant]], [[Weaviate]] have deeper connector support.

## Related / alternatives
- [[Vector Database]] — parent concept.
- [[RAGFlow]] — same vendor; Infinity is RAGFlow's default search backend.
- [[Milvus]] — similar scale, more mature managed cloud (Zilliz), less minimal footprint.
- [[Qdrant]] — Rust-based, strong filtering, no full-text native.
- [[Weaviate]] — built-in BM25 hybrid, mature ecosystem, self-hosted or cloud.
- [[Hybrid Search]] — Infinity is a first-class hybrid search engine.
- [[ColBERT]] — supported as a tensor reranking mode.

## Sources
- [[01_Sources/web_clips/infiniflow-ragflow-infinity]]
