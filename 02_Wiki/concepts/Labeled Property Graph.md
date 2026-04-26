---
type: concept
aliases: [LPG, property graph, labeled property graph]
tags: [rag, knowledge-graph, graph-database, retrieval]
status: stub
created: 2026-04-23
updated: 2026-04-23
sources: ["[[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]"]
---

# Labeled Property Graph

> **TL;DR** A graph data model representing data as nodes and edges with key-value property labels — optimised for traversal and analytics; no formal schema standard, but widely used in production knowledge graphs.

## Definition
A Labeled Property Graph (LPG) represents data as **nodes** (entities) and **edges** (relationships) in a directed graph. Both nodes and edges carry **labels** and **properties** as key-value pairs. Unlike [[RDF]], there is no centrally mandated schema or serialisation standard, though the ISO-standardised Graph Query Language (GQL, released April 2024) is emerging as a common query interface. [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## Context
LPGs are the graph model used by Neo4j, Amazon Neptune (LPG mode), [[FalkorDB]] (Redis module with GraphBLAS engine), and other production graph databases. In RAG, an LPG can power [[GraphRAG]]-style pipelines where the emphasis is on graph traversal, community detection, and machine-learning algorithms over the graph structure rather than on semantic inference. [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## How it works
- Nodes and edges each have a **type label** (e.g., `Person`, `KNOWS`) and a set of typed properties (e.g., `{name: "Alice", age: 30}`).
- Queried via Cypher (Neo4j), Gremlin, or GQL.
- No formal validation mechanism by default — schema governance is an application-layer concern.
- Graph algorithms (clustering, centrality, shortest path) run natively via library support (e.g., Neo4j Graph Data Science, NetworkX).

## Strengths and weaknesses
| Strengths | Weaknesses |
|-----------|-----------|
| Efficient storage and updates for large, frequently-changing data | No formal schema enforcement — data correctness relies on application discipline |
| Designed for graph traversal and ML algorithms | Vendor lock-in (proprietary serialisations and query languages) |
| Developer-friendly — maps naturally to SQL/object thinking | No native logical reasoning (OWL-style inference) |
| Supports property labels on relationships natively | Switching between LPG vendors is difficult |

[[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## LPG vs RDF
Where [[RDF]] prioritises **semantic correctness, interoperability, and logical reasoning**, LPG prioritises **traversal performance, analytics, and rapid development**. Enterprises sometimes use both: an RDF graph for data aggregation/reasoning and an LPG for downstream graph ML. [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## Related pages
- [[Knowledge Graph]]
- [[RDF]]
- [[GraphRAG]]
- [[Text-to-SPARQL]]

## Sources
- [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]
