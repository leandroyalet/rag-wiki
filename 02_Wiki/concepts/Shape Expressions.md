---
type: concept
aliases: [ShEx, Shape Expressions Language]
tags: [knowledge-graph, schema, sparql, rag]
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: ["[[emonet2024sparql]]"]
---

# Shape Expressions

> **TL;DR** A schema language for RDF/SPARQL graphs that enumerates valid predicates and target types per class — used in RAG pipelines to validate generated SPARQL and prevent hallucinated property names.

## Definition
Shape Expressions (ShEx) is a language for describing and validating the structure of RDF graphs. A ShEx schema for a class specifies which predicates are available, which are mandatory, and what types or value sets they expect. It reflects the *actual* data in the endpoint rather than an idealized ontology. [[emonet2024sparql]]

## Context
In a [[Text-to-SPARQL]] pipeline, ShEx schemas serve two roles:
1. **Retrieval context**: the top-k most relevant class shapes are injected into the LLM prompt so it generates queries using real predicates.
2. **Validation oracle**: after generation, the validator parses the SPARQL, extracts used predicates, and checks them against the ShEx — returning human-readable error messages if a predicate doesn't exist. [[emonet2024sparql]]

## How it works / How it's used
- ShEx is preferred over OWL for RAG context because it captures what data actually looks like (closed-world perspective on the content), not just what is logically permitted. [[emonet2024sparql]]
- Schemas can be auto-generated from a running SPARQL endpoint using VoID descriptions or endpoint introspection.
- Each class shape includes: available predicates, cardinality constraints, and target type IRIs.

## Variants
- **SHACL** (Shapes Constraint Language) — W3C standard alternative; similar purpose, different syntax and tooling.
- **OWL** — more expressive for reasoning but harder to use as concise context for generation.

## Trade-offs
- ✅ Ground-truth source of valid predicates: eliminates hallucinated property names.
- ✅ Auto-extractable from live endpoints via VoID.
- ❌ Can be verbose; large schemas compete with example context for prompt space.
- ❌ Does not capture entity-level constraints (e.g., valid disease identifiers). [[emonet2024sparql]]

## Related pages
- [[Knowledge Graph]]
- [[Text-to-SPARQL]]
- [[Hallucination in RAG]]

## Sources
- [[emonet2024sparql]]
