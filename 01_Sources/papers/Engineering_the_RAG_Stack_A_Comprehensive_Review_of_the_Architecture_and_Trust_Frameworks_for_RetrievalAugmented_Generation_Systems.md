---
title: "Engineering the RAG Stack: A Comprehensive Review of the Architecture and Trust Frameworks for Retrieval-Augmented Generation Systems"
authors: "Dean Wampler, Dave Nielson, Alireza Seddighi"
citekey: wampler2025ragstack
aliases: [wampler2025ragstack]
year: 2025
venue: "ArXiv"
url: "https://arxiv.org/abs/2601.05264"
tags: [paper, arxiv, rag, survey, trust]
status: summarized
added_by: Pablo
---

# Engineering the RAG Stack: A Comprehensive Review of the Architecture and Trust Frameworks for Retrieval-Augmented Generation Systems

## Summary
Systematic literature review (2018–2025) consolidating RAG architectures into a unified taxonomy plus a trust and alignment framework for production deployment.

**Five-dimensional taxonomy:**
| Dimension | Options |
|-----------|---------|
| Retrieval strategy | Single-pass · Iterative · Multi-hop |
| Fusion mechanism | Early (FiD) · Late (RAG-Sequence) · Marginal (RAG-Fusion) |
| Knowledge modality | Text-only · Structured data · Multi-modal |
| Trust calibration | Abstention · Citation grounding · Uncertainty quantification |
| Pipeline adaptivity | Static rule-based · Agentic/self-adaptive |

**Trust and alignment framework:**
- Vulnerability points: corpus manipulation, data poisoning, retrieval failures.
- Mitigations: citation grounding, source filtering, uncertainty quantification, red teaming.
- Hallucination detection: multi-method (LLM judges + entailment checking).
- Regulatory: governance for explainability and accountability.

**Key quantitative findings:**
- Chunk attribution accuracy: 86% (Galileo AI) — 1.36× over GPT-3.5-Turbo baseline.
- Context adherence: 74% accuracy (1.65× improvement); Completeness: 80% (1.61×).
- Microsoft GraphRAG: 20,000+ GitHub stars within months of July 2024 release.

**Deployment recommendations:**
- Hybrid sparse-dense retrieval for balanced performance.
- Two-stage retrieval (bi-encoder + cross-encoder reranking) for precision.
- Semantic windowing beats fixed-size chunking for context preservation.
- Human-in-the-loop validation for mission-critical applications.

## Abstract
This article provides a comprehensive systematic literature review of academic studies, industrial applications, and real-world deployments from 2018 to 2025, providing a practical guide and detailed overview of modern Retrieval-Augmented Generation (RAG) architectures. RAG offers a modular approach for integrating external knowledge without increasing the capacity of the model as LLM systems expand. Research and engineering practices have been fragmented as a result of the increasing diversity of RAG methodologies, which encompasses a variety of fusion mechanisms, retrieval strategies, and orchestration approaches. We provide quantitative assessment frameworks, analyze the implications for trust and alignment, and systematically consolidate existing RAG techniques into a unified taxonomy. This document is a practical framework for the deployment of resilient, secure, and domain-adaptable RAG systems, synthesizing insights from academic literature, industry reports, and technical implementation guides. It also functions as a technical reference.
