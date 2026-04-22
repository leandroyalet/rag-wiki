---
type: paper
citekey: lewis2020rag
title: "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks"
authors: [Patrick Lewis, Ethan Perez, Aleksandra Piktus, Fabio Petroni, Vladimir Karpukhin, Naman Goyal, Heinrich Küttler, Mike Lewis, Wen-tau Yih, Tim Rocktäschel, Sebastian Riedel, Douwe Kiela]
year: 2020
venue: NeurIPS
url: https://arxiv.org/abs/2005.11401
pdf: "[[lewis2020rag.pdf]]"
tags: [paper, rag, foundational, retrieval, generation]
status: summarized
added: 2026-04-18
added_by: bootstrap
---

# Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks

> **TL;DR** Introduces the name and architecture of RAG: combines a dense retriever (DPR) with a seq2seq generator (BART), trained end-to-end, marginalizing over retrieved documents. Beats purely parametric models on open-domain QA and fact verification.

## Why we read it
It's the foundational paper of the field. Any conversation about RAG starts or ends here.

## Problem
Parametric LLMs store knowledge in weights, making them expensive to update, hard to audit, and prone to hallucinating specific facts. Can we separate knowledge (non-parametric, indexable memory) from reasoning (parametric memory, the generator)?

## Contribution
- Defines the RAG architecture with two variants: **RAG-Sequence** (one document conditions the whole answer) and **RAG-Token** (a different document per generated token).
- Jointly trains retriever + generator, with the retriever differentiable through the top-k.
- SOTA results (as of 2020) on several QA benchmarks and FEVER.
- Shows that RAG reduces hallucinations and produces more specific answers than plain BART.

## Method
- **Retriever**: DPR ([[karpukhin2020dpr]]), two BERT encoders — one for query, one for documents.
- **Generator**: BART-large.
- **Corpus**: Wikipedia snapshot (~21M 100-token chunks).
- **Training**: document embeddings are frozen; the query encoder + generator are updated by backprop over the marginal log-likelihood.
- See [[Dense Retrieval]] and [[Chunking]] for components.

## Results
- Open-domain QA (NaturalQuestions, TriviaQA, WebQuestions): beats T5 and REALM.
- FEVER fact verification: comparable to supervised SOTA without task-specific architecture.
- Jeopardy question generation: humans prefer RAG answers over BART's 42% of the time (vs. 17% the other way).

## Critique / Limitations
- The corpus is static: updating it requires re-indexing, though not retraining.
- RAG-Token is more flexible but more expensive at inference.
- No explicit mechanism for handling contradictions across retrieved documents.
- Evaluation doesn't capture the case where the correct document *isn't* in the corpus (behavior under absent evidence).

## Connections to other sources
- Extends [[karpukhin2020dpr]] (DPR) by adding the generative stage.
- Conceptual predecessor of almost everything that came after: [[HyDE]], [[RAPTOR]], [[GraphRAG]], [[RAG-Fusion]].

## Relevant quotes
> "We combine parametric and non-parametric memory in a unified model..." (sec. 1)

## Annotations
<!-- PDF highlights would go here if imported via Zotero Integration. -->
