---
type: tool
aliases: [FalkorDB graph database]
tags: [rag, tool, infra, graph-database, knowledge-graph]
status: stub
created: 2026-04-23
updated: 2026-04-23
sources: []
homepage: https://www.falkordb.com
repo: https://github.com/falkordb/falkordb
---

# FalkorDB

> **TL;DR** A [[Labeled Property Graph]] database built as a Redis module, using GraphBLAS sparse-matrix operations for ultra-low-latency graph queries — marketed specifically as the graph backend for [[GraphRAG]] and agentic AI pipelines.

## What it is
FalkorDB is an open-core graph database (SSPLv1 licence) that represents graphs internally as **sparse adjacency matrices** processed via [GraphBLAS](https://graphblas.org/) — a linear-algebra library optimised for sparse matrix operations. This is architecturally distinct from adjacency-list engines like Neo4j. It runs as a **Redis module**, inheriting Redis's in-memory speed and persistence model.

Query language: **OpenCypher** (Neo4j-compatible) plus proprietary extensions.

## Key features
| Feature | Description |
|---------|-------------|
| **GraphBLAS engine** | Sparse matrix graph representation; linear-algebra query optimisation |
| **Redis module** | Runs inside Redis 7.4+; in-memory by default with persistence options |
| **OpenCypher** | Standard Cypher queries; Neo4j migration path |
| **GraphRAG-native** | Ontology auto-detection, built-in agent orchestration, NL query support |
| **Multi-tenancy** | Supported natively (vs. AWS Neptune which lacks it) |
| **Multi-language SDKs** | Python, Java, Node.js, Rust, Go, C# |

## Performance claims
FalkorDB publishes benchmark comparisons against Neo4j, Neptune, TigerGraph, and ArangoDB:
- **496× faster P50 latency** — 36 ms vs 469 ms (competitor)
- **6× better memory efficiency** — 100 MB vs 600 MB
- P95: 74 ms vs 13,969 ms; P99: 83 ms vs 41,157 ms

> [!todo] Source needed — benchmarks from falkordb.com; independent verification not yet in 01_Sources/

## Deployment options
- **Docker** — `docker run -p 6379:6379 -p 3000:3000 falkordb/falkordb`
- **Redis module** — load into existing Redis 7.4+ instance
- **FalkorDB Cloud** — managed SaaS on GCP / AWS / Azure
  - Free tier available; Startup $1/GB/month; Pro $50/8 GB/month; Enterprise custom

## GraphRAG integration
FalkorDB is positioned as the graph layer in [[GraphRAG]] pipelines:
- Integrates with [[LangChain]], [[LlamaIndex]], and Graphiti
- Supports structured + unstructured data ingestion with NL-to-Cypher query generation
- Aims to reduce hallucinations by grounding LLM responses in a domain knowledge graph

```python
from falkordb import FalkorDB

db = FalkorDB(host="localhost", port=6379)
graph = db.select_graph("rag_kg")

# Create entities
graph.query("CREATE (:Concept {name: 'RAG', year: 2020})")

# Query
result = graph.query("MATCH (c:Concept) RETURN c.name")
```

## When to use it
- ✅ GraphRAG pipeline needing ultra-low-latency graph queries.
- ✅ Already using Redis infrastructure — zero extra infra for the graph layer.
- ✅ Need Neo4j-compatible Cypher without Neo4j licensing costs.
- ❌ Semantic reasoning / OWL inference needed — use [[RDF]]-based stores.
- ❌ SSPLv1 is incompatible with your commercial use case — consider Neo4j Community or [[Labeled Property Graph|other LPG options]].
- ❌ Large on-disk graphs that don't fit in RAM — FalkorDB is primarily in-memory.

## Alternatives
| Need | Alternative |
|------|-------------|
| RDF / SPARQL / reasoning | GraphDB, Apache Jena |
| On-disk LPG, mature ecosystem | Neo4j |
| Multi-model (graph + doc + vector) | ArangoDB |
| Managed, AWS-native | Amazon Neptune |

## Related pages
- [[Knowledge Graph]]
- [[Labeled Property Graph]]
- [[GraphRAG]]
- [[RDF]]
- [[LangChain]]
- [[LlamaIndex]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/; information from falkordb.com and github.com/falkordb/falkordb
