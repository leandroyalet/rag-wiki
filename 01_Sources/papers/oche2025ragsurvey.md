---
type: paper
citekey: oche2025ragsurvey
title: "A Systematic Review of Key Retrieval-Augmented Generation (RAG) Systems: Progress, Gaps, and Future Directions"
authors: [Agada Joseph Oche, Ademola Glory Folashade, Tirthankar Ghosal, Arpan Biswas]
year: 2025
venue: arXiv (cs.CL)
url: https://arxiv.org/abs/2507.18910
pdf: "[[2507.18910v1.pdf]]"
tags: [paper, rag, survey, retrieval, generation]
status: summarized
added: 2026-04-21
added_by: Claude Code (/ingest)
---

# A Systematic Review of Key RAG Systems: Progress, Gaps, and Future Directions

> **TL;DR** Systematic review tracing RAG from 2017 pre-RAG pipelines to 2025 enterprise deployments; covers architectures (RAG-Seq/Token, FiD, RETRO), retrieval strategies (DPR, hybrid, re-ranking), fusion methods, and identifies persistent gaps in hallucination, privacy, and scalability.

## Why we read it
Authoritative survey providing a chronological taxonomy of RAG milestones — useful for orienting new team members and locating where each paper fits in the evolution.

## Problem
RAG research is fragmented across QA, dialogue, fact-checking, and enterprise domains. A systematic review is needed to map progress, identify gaps, and highlight future directions.

## Contribution
- Chronological taxonomy of RAG development (2017–2025) with milestone systems.
- Classification of retrieval strategies (dense, hybrid, re-ranking), generation strategies (early/late fusion), and fusion methods.
- Identification of persistent gaps: retrieval quality in specialized domains, latency, privacy, hallucination persistence, and knowledge freshness.

## Chronological milestones

| Period | Key event |
|--------|-----------|
| 2017–2019 | DrQA, R³, ORQA — pipeline-based retrieve-and-read |
| 2020 | Lewis RAG formalization (DPR + BART); Guu REALM |
| 2021 | FiD (Izacard); KILT benchmark; dialogue & fact-checking extensions |
| 2022 | RETRO — 7.5B params + retrieval ≈ GPT-3 175B |
| 2023 | RAG meets LLMs (GPT-4-class generators) |
| 2024 | Continued architectural refinements |
| 2025 | Enterprise deployment focus; proprietary data, security, scalability |

## Key findings
- Retrieval-augmented models (hundreds of M params) outperform closed-book LLMs (11B+ params) on knowledge tasks. [[oche2025ragsurvey]]
- RAG substantially reduces hallucination vs. parametric-only generation. [[oche2025ragsurvey]]
- Two-stage retrieval (dense + re-rank) substantially improves precision over single-stage. [[oche2025ragsurvey]]
- Single unified RAG pipeline performs competitively across QA, dialogue, fact-checking, entity linking (KILT). [[oche2025ragsurvey]]

## Critique / Limitations
- Review is high-level; does not conduct original experiments.
- Coverage thins out after 2023 — recent (2024–2025) systems described briefly.
- Enterprise case studies (PGA Tour, Bayer, Rocket Companies) cited without quantitative results.

## Connections to other sources
- Extends [[lewis2020rag]] with historical context and subsequent milestones.
- Introduces [[Fusion-in-Decoder]] and [[RETRO]] as key architectural milestones.
- [[KILT]] benchmark covers 11 unified knowledge-intensive tasks.
