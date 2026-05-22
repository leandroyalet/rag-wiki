---
type: method
aliases: [Graph RAG, Microsoft GraphRAG]
tags: [rag, method, knowledge-graph, graph]
status: stub
created: 2026-04-18
updated: 2026-05-17
sources: ["[[01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences]]"]
introduced_by: Edge et al. (Microsoft Research)
year: 2024
---

# GraphRAG

> **TL;DR** Builds a knowledge graph and multi-level community summaries from the corpus at index time, then answers queries by graph traversal — enabling holistic, cross-document reasoning that naive vector search cannot do.

## Problem it solves
Baseline [[Dense Retrieval|vector RAG]] retrieves locally similar chunks but fails on two classes of questions:
1. **Cross-document synthesis** — answers requiring facts connected across many documents via shared entities.
2. **Holistic summarisation** — "What are the main themes of this corpus?" — where no single chunk suffices.

Three structural RAG weaknesses that GraphRAG directly addresses [[01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences]]:
- **Fragmented context** — [[Chunking]] breaks logical flow; GraphRAG retrieves connected subgraphs instead.
- **Over-retrieval** — vector similarity returns plausible-but-irrelevant chunks; graph traversal follows typed relationships.
- **No cross-fact reasoning** — vector search cannot infer that *Elon Musk → CEO of → Tesla*; a knowledge graph makes such edges explicit.

## Key idea
Replace chunk-level retrieval with a structured [[Knowledge Graph]] extracted from the corpus. Entities, relationships, and claims are pulled from every document, then clustered hierarchically (Leiden algorithm) into *communities*. Each community is summarised by an LLM. Queries can search locally (specific entities) or globally (corpus-wide themes via community summaries).

## Pipeline / Steps
**Indexing (offline):**
1. Segment corpus into TextUnits (fixed-size chunks).
2. LLM extracts entities, relationships, and co-variate claims from each TextUnit.
3. Leiden hierarchical community detection clusters entities at multiple levels.
4. LLM generates bottom-up community summaries at each level.

**Retrieval entry points ("pivots") and relevance expansion:**
GraphRAG's retrieval layer is flexible — it can use semantic search, keyword/text search, geospatial filters, or [[Hybrid Search]] to locate *pivot* nodes (relevant entry points in the graph). The retrieval method determines *where* reasoning begins; graph traversal ("relevance expansion") then uncovers connected nodes regardless of how they were originally found. [[01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences]]

**Query (online) — two primary modes:**
- **Local search** — embeds query, finds nearest entities, expands to graph neighbours and related reports, generates answer from the subgraph.
- **Global search** — maps query across all community summaries, reduces/aggregates responses, generates a holistic answer.
- **DRIFT search** — hybrid combining local expansion with community context.

## Reference implementations
- Microsoft `graphrag` Python package (MIT licence): `pip install graphrag`
- Integrations available for [[LangChain]] and [[LlamaIndex]].

## Graph database backends
The knowledge graph can be stored in any [[Labeled Property Graph]] or [[RDF]] store. Purpose-built options for GraphRAG workloads include [[FalkorDB]] (Redis-based, GraphBLAS engine, ultra-low latency) and Neo4j (mature LPG ecosystem). [[RDF]]-based stores (GraphDB, Apache Jena) are preferred when semantic reasoning is required.

## When to use / when not to
- ✅ Analytical / sensemaking questions over a large thematically rich corpus.
- ✅ Entities and relationships are first-class (legal docs, research literature, knowledge bases).
- ✅ Supply chain analysis — trace entity paths through dependency graphs. [[01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences]]
- ✅ Research / literature graphs — reason across paper-entity-concept connections. [[01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences]]
- ✅ Healthcare intelligence — patient-condition-treatment relationships. [[01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences]]
- ❌ Simple factual lookup — graph construction overhead not justified.
- ❌ Rapidly updating corpus — graph must be rebuilt on changes.
- ❌ Latency-sensitive pipelines — global search requires many LLM calls.

## Related / alternatives
- [[Knowledge Graph]] — underlying data structure.
- [[RAPTOR]] — similar goal (cross-document reasoning) via recursive summarisation, without explicit graph extraction.
- [[Multi-hop Retrieval]] — achieves cross-document reasoning at query time via iterative retrieval.
- [[Retrieval-Augmented Generation]] — GraphRAG is a specialised extension.

## Sources
- [[01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences]]

> [!todo] Source needed — Edge et al. "From Local to Global: A Graph RAG Approach to Query-Focused Summarization" (2024) not yet in 01_Sources/
