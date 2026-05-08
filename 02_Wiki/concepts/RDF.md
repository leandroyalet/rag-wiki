---
type: concept
aliases: [Resource Description Framework, RDF graph, triple store, RDF triple]
tags: [rag, knowledge-graph, semantic-web, retrieval]
status: stub
created: 2026-04-23
updated: 2026-04-23
sources: ["[[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]", "[[berges2024commOnt]]", "[[chatzikyriakidis2025ragcoq]]"]
---

# RDF

> **TL;DR** W3C's standard for representing knowledge as subject–predicate–object triples — the foundation for SPARQL, OWL reasoning, and semantic knowledge graphs in RAG pipelines.

## Definition
The Resource Description Framework (RDF) is a W3C standard for representing and exchanging information on the web. RDF describes data as **triples** — statements of the form (subject, predicate, object) — stored in **triple-store** graph databases. Entities are identified by globally resolvable URIs, enabling data reuse across heterogeneous sources. [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## Context
In RAG, RDF graphs serve as structured knowledge sources alongside or instead of [[Vector Database|vector databases]]. Rather than returning unstructured text chunks, an RDF-backed RAG system issues SPARQL queries and returns structured results, preserving entity identity and relational structure. [[GraphRAG]] can be built on either RDF or [[Labeled Property Graph]] stores. [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## How it works

### Core stack (W3C standards)
| Standard | Role |
|----------|------|
| **RDF** | Triple data model (subject, predicate, object) |
| **RDFS** | Schema layer — class/property hierarchies |
| **OWL** | Ontology language — logical reasoning via category theory |
| **SPARQL** | Query language — pattern matching over triples |
| **SHACL** | Constraint language — validates data against a shape |
| **ShEx** | Alternative shape/validation language (see [[Shape Expressions]]) |

### RDF as an event knowledge base with formal reasoning
RAG-extracted RDF triples can be translated into formal proof-assistant specifications for higher-order temporal reasoning. [[chatzikyriakidis2025ragcoq]] demonstrates this on historical narratives (Thucydides): LLMs with RAG extract events as RDF subject–predicate–object triples, which an automated pipeline then converts into **Coq** proof assistant specifications. This enables causal verification, temporal arithmetic with BC dates, and formally-proven historical inference — capabilities beyond what SPARQL querying alone provides. RAG improves precision and metadata completeness of the extracted events compared to base LLM generation, though base generation achieves better coverage. [[chatzikyriakidis2025ragcoq]]

### OWL and SWRL in agentic settings
OWL-DL + SWRL rules are sufficient to reason about complex inter-agent communication protocols without prior negotiation. [[berges2024commOnt]] demonstrates this via the CommOnt ontology — communication acts are described as OWL-DL classes; SWRL rules derive protocol equivalence and specialisation relationships; Event Calculus formalises the intended semantics as social commitments. In agentic RAG pipelines, this approach shows how shared ontologies can enable agents to communicate and coordinate with formal semantic grounding rather than ad-hoc schema matching.

### Key properties
- **Self-describing**: data and data model coexist in the same graph.
- **Global identifiers (URIs)**: entities can be dereferenced and reused across datasets.
- **Federated queries**: a single SPARQL query can join multiple remote endpoints via `SERVICE` clauses.
- **Native reasoning**: OWL enables inference of new facts from class hierarchies and transitive properties.

## Strengths and weaknesses
| Strengths | Weaknesses |
|-----------|-----------|
| Self-describing, schema-validated | High cognitive load for newcomers |
| Vendor-portable (common serialisations: Turtle, N-Triples, JSON-LD) | N-ary (many-to-many) relationships require verbose intermediary nodes |
| Native reasoning via OWL | OWL implementation variants can be confusing |
| Flexible schema alignment across heterogeneous data | |

[[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## RDF vs LPG
RDF emphasises **semantic correctness, interoperability, and reasoning**. [[Labeled Property Graph]] emphasises **traversal speed, analytics, and developer friendliness**. Both can underpin a [[Knowledge Graph]]; the choice depends on whether logical inference and standards compliance matter more than graph-algorithm performance. [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]

## Related pages
- [[Knowledge Graph]]
- [[Labeled Property Graph]]
- [[Shape Expressions]]
- [[Text-to-SPARQL]]
- [[GraphRAG]]

## Sources
- [[01_Sources/web_clips/Cutting Through the Noise An Introduction to RDF & LPG Graphs]]
- [[berges2024commOnt]]
- [[chatzikyriakidis2025ragcoq]]
