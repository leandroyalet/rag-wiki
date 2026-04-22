---
type: concept
aliases: [KG, Knowledge Base, RDF Graph]
tags: [rag, knowledge-graph, retrieval]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[emonet2024sparql]]"]
---

# Knowledge Graph

> **TL;DR** A graph-structured store of entities and typed relations, queryable with SPARQL, that acts as an external knowledge source for RAG systems.

## Definition
A knowledge graph represents facts as triples (subject → predicate → object) following the RDF data model. Large public examples include Wikidata, DBpedia, and domain-specific graphs such as UniProt (proteins), Bgee (gene expression), and OMA (orthology). [[emonet2024sparql]]

## Context
In the RAG pipeline, a knowledge graph can replace or complement a [[Vector Database]] as the retrieval layer. Instead of returning text chunks, the system issues a SPARQL query and returns structured results, which avoids chunking and preserves relational structure.

## How it works / How it's used
- **Query interface**: SPARQL (standard) or graph traversal APIs.
- **Schema**: described via OWL ontologies or [[Shape Expressions]] (ShEx), which enumerate valid predicates and target types for each class.
- **Federated queries**: a single SPARQL query can join multiple endpoints using `SERVICE` clauses, enabling cross-database reasoning. [[emonet2024sparql]]

## Variants
- **Open knowledge graphs**: Wikidata, DBpedia — broad general knowledge.
- **Domain KGs**: UniProt, Bgee, OMA — deep but narrow coverage.
- **Enterprise KGs**: internal product/customer graphs with tighter schema governance.

## Trade-offs
- ✅ Preserves entity identity and relational structure — no information lost to chunking.
- ✅ Federated queries span multiple authoritative sources natively.
- ❌ Requires SPARQL expertise (or a [[Text-to-SPARQL]] layer).
- ❌ Schema must be known in advance; open-world assumptions can cause surprising query results.

## State of the art (as of 2026-04)
RAG systems that query knowledge graphs via generated SPARQL achieve F1 ~0.91 on bioinformatics tasks when combining retrieval of example queries + schema-aware validation. [[emonet2024sparql]]

## Related pages
- [[Text-to-SPARQL]]
- [[GraphRAG]]
- [[Shape Expressions]]
- [[Vector Database]]

## Sources
- [[emonet2024sparql]]
