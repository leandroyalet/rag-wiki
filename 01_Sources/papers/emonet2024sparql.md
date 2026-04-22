---
type: paper
citekey: emonet2024sparql
title: "LLM-based SPARQL Query Generation from Natural Language over Federated Knowledge Graphs"
authors: [Vincent Emonet, Jerven Bolleman, Severine Duvaud, Tarcisio Mendes de Farias, Ana Claudia Sima]
year: 2024
venue: arXiv (cs.DB / cs.AI / cs.IR)
url: https://arxiv.org/abs/2410.06062
pdf: "[[2410.06062v4.pdf]]"
tags: [paper, rag, knowledge-graph, sparql, structured-generation]
status: summarized
added: 2026-04-18
added_by: Claude Code (/ingest)
---

# LLM-based SPARQL Query Generation from Natural Language over Federated Knowledge Graphs

> **TL;DR** A RAG pipeline that translates natural-language questions into federated SPARQL queries by retrieving example Q/A pairs and ShEx schemas, then validating and correcting the generated query against the endpoint.

## Why we read it
Extends RAG to structured output (SPARQL) over graph databases — a domain that challenges both retrieval (schema-aware context) and generation (syntactic correctness).

## Problem
Bioinformatics knowledge graphs (UniProt, Bgee, OMA) are queried via SPARQL. Non-expert users cannot write federated SPARQL manually, and naive LLM generation hallucinates property names and federation syntax.

## Contribution
- RAG pipeline that indexes example question/SPARQL pairs and [[Shape Expressions]] (ShEx) schemas in [[Qdrant]] using [[BGE]] embeddings.
- A query validation module that parses generated SPARQL, checks predicates against ShEx, and loops corrections back to the LLM.
- Online demo at chat.expasy.org; Python package `sparql-llm` on PyPI; [[LangChain]]-compatible.

## Method
1. **Indexing**: crawl each SPARQL endpoint for example Q/query pairs, ShEx schemas, and OWL class labels → embed with `BAAI/bge-large-en-v1.5` via *fastembed* → store in [[Qdrant]] with cosine similarity.
2. **Retrieval**: top-20 similar example questions + top-15 closest class labels retrieved per query.
3. **Prompt construction**: retrieved context injected into a structured prompt alongside the user question.
4. **Generation**: LLM (GPT-4o, GPT-4o-mini, Mixtral 8×22B, or Llama3.1 8B) generates a SPARQL query.
5. **Validation & correction**: custom validator parses the query, checks each predicate against precomputed ShEx, produces human-readable errors, feeds them back to the LLM for one correction pass.

See [[Text-to-SPARQL]] for the general method category.

## Results
GPT-4o + RAG + validation: **34/39 successes, F1 = 0.91**.
Llama3.1 8B baseline (no RAG): F1 = 0.0 — validation loop rescues smaller models significantly.
[[RAG]] alone (no validation) sits between the two extremes, confirming validation is load-bearing.

## Critique / Limitations
- Test suite is small (13 questions, 3 runs each = 39 trials); hard to generalize.
- Hallucinates entity identifiers (e.g., disease codes) — entity indexing is future work.
- Federation patterns are complex; success rate drops for queries spanning ≥3 endpoints.

## Connections to other sources
- Applies [[Retrieval-Augmented Generation]] to structured-query generation, extending the scope of [[lewis2020rag]].
- Uses [[Qdrant]] + [[BGE]] as the retrieval backend.

## Relevant quotes
> "The system leverages metadata including query examples and schema information, with validation steps to minimize hallucinations."

> "The 20 most similar questions and 15 closest class labels are retrieved from the vector database."
