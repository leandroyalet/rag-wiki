---
type: paper
citekey: barnett2024failures
title: "Seven Failure Points When Engineering a Retrieval Augmented Generation System"
authors: [Scott Barnett, Stefanus Kurniawan, Srikanth Thudumu, Zach Brannelly, Mohamed Abdelrazek]
year: 2024
venue: arXiv (cs.SE / cs.AI)
url: https://arxiv.org/abs/2401.05856
pdf: "[[2401.05856v1.pdf]]"
tags: [paper, rag, failure-analysis, engineering, evaluation]
status: summarized
added: 2026-04-19
added_by: Claude Code (/ingest)
---

# Seven Failure Points When Engineering a Retrieval Augmented Generation System

> **TL;DR** Experience report identifying seven recurring failure modes in production RAG systems across research, education, and biomedical domains, with the key finding that RAG validation is only feasible at runtime — robustness must be grown, not designed upfront.

## Why we read it
Practical engineering taxonomy that maps directly to our debugging and evaluation work; every failure point is a test case to add.

## Problem
RAG systems fail in the wild in ways not predicted by offline benchmarks. Understanding *where* in the pipeline failures occur is a prerequisite for fixing them.

## Contribution
- A taxonomy of **seven failure points** (FP1–FP7) derived from three deployed case studies.
- Empirical validation on BioASQ (4,017 PDFs, 1,000 questions) using GPT-4 + OpenAI evals.
- Actionable mitigations for each failure point.

## Method
Three case studies: **Cognitive Reviewer** (literature review PDFs), **AI Tutor** (video transcriptions + HTML + PDF), **BioASQ** (biomedical QA). BioASQ used as the empirical study. Whisper used for audio transcription.

## The Seven Failure Points

| ID | Name | Description |
|----|------|-------------|
| FP1 | Missing content | Question cannot be answered from available documents; system responds anyway |
| FP2 | Missed top-ranked docs | Answer exists but didn't rank high enough to be retrieved |
| FP3 | Consolidation limits | Many retrieved docs exceed context window; reduction loses the answer |
| FP4 | Extraction failure | Answer is in context but LLM fails to extract it |
| FP5 | Wrong format | LLM ignores structural instructions (tables, lists) |
| FP6 | Incorrect specificity | Answer too vague or too specific for the user's need |
| FP7 | Incomplete answer | Response omits available relevant information |

## Key findings
- Larger context (8K vs 4K tokens) improves FP4 (extraction failure) in the AI Tutor domain.
- Semantic caching mitigates FP1 cost (reduces redundant generation for common questions).
- Adding metadata (filename, chunk number) to embeddings improves FP2 and FP4.
- Open-source embedding models perform comparably to closed-source on short biomedical text.
- RAG offers pragmatic advantages over fine-tuning: incremental knowledge updates and access control.

## Critique / Limitations
- BioASQ evaluators were non-experts; GPT-4 evals were noted to be more pessimistic than human raters.
- Failure taxonomy is qualitative; no quantitative breakdown of failure frequency per FP.
- Single-domain empirical study (biomedical) limits generalizability.

## Connections to other sources
- Directly informs [[RAG Failure Points]] taxonomy page.
- FP2 motivates [[Reranking]] and [[Hybrid Search]].
- FP3 motivates [[Chunking]] strategy research and [[RAPTOR]].
- FP4 connects to [[Hallucination in RAG]] (extraction failure ≠ generation hallucination).
