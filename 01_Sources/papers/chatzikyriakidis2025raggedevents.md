---
type: paper
citekey: chatzikyriakidis2025raggedevents
title: "Reasoning with RAGged events: RAG-Enhanced Event Knowledge Base Construction and reasoning with proof-assistants"
authors: [Stergios Chatzikyriakidis]
year: 2025
venue: arXiv (cs.CL / cs.AI)
url: https://arxiv.org/abs/2506.07042
pdf: "[[2506.07042v1.pdf]]"
tags: [paper, rag, knowledge-graph, formal-reasoning, event-extraction]
status: summarized
added: 2026-04-19
added_by: Claude Code (/ingest)
---

# Reasoning with RAGged events: RAG-Enhanced Event Knowledge Base Construction and reasoning with proof-assistants

> **TL;DR** Extracts historical events from Thucydides using LLMs + RAG, converts results to RDF then Coq proof specifications, and finds an "inverse calibration principle": stronger models (GPT-4o, Claude) perform *worse* with RAG augmentation, while weaker models (Llama 3.2) benefit significantly.

## Why we read it
The **inverse calibration principle** is a counter-intuitive RAG finding that challenges the default assumption that retrieval augmentation always helps.

## Problem
Historical text requires structured event extraction (agents, locations, times, outcomes) and reasoning that exceeds plain LLM generation. The paper asks whether RAG and knowledge-graph augmentation reliably improve extraction quality.

## Contribution
- A two-phase pipeline: LLM event extraction → RDF graph → automated Coq proof translation.
- Empirical comparison of base / knowledge-enhanced / RAG strategies across GPT-4o, Claude-3.5 Sonnet, Llama 3.2.
- Discovery of the **inverse calibration principle**.

## Method
- RAG: FAISS vector store with HuggingFace embeddings; knowledge sources: DBpedia ontology (768 classes, 3,000+ properties), LACRIMALit ontology for Ancient Greek locations, Wikidata, ConceptNet.
- Corpus: Thucydides' *History of the Peloponnesian War*, first 9 chapters.
- Temperature = 0 for deterministic outputs across all models.

## Key finding: inverse calibration principle

| Model | Strategy | Events extracted | Quality |
|-------|----------|-----------------|---------|
| GPT-4o | Base | 36 | Excellent |
| GPT-4o | RAG | 20–26 | Hallucinations introduced |
| Claude-3.5 | Base | 39 | Excellent |
| Claude-3.5 | RAG | 10–19 | Many hallucinations |
| Llama 3.2 | Base | 10 | Poor formatting |
| Llama 3.2 | RAG (simple) | 37–38 | Good |
| Llama 3.2 | RAG (complex) | 0–6 | Complete failure |

Strong models degrade with RAG; weak models improve — up to a complexity ceiling.

## Critique / Limitations
- Single-domain (classical Greek history); generalizability unclear.
- Evaluation corpus is small (9 chapters).
- Coq deployment requires formal logic expertise; not accessible to domain historians.

## Connections to other sources
- Challenges the blanket assumption in [[Retrieval-Augmented Generation]] that augmentation always helps.
- Uses [[FAISS]] and [[Knowledge Graph]] (DBpedia, Wikidata) as retrieval backend.
- Inverse calibration principle extends [[Hallucination in RAG]] taxonomy (RAG can *introduce* hallucinations for strong models).
