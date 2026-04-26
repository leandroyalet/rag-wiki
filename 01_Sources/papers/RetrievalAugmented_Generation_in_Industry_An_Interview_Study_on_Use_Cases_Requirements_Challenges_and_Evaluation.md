---
title: "Retrieval-Augmented Generation in Industry: An Interview Study on Use Cases, Requirements, Challenges, and Evaluation"
authors: "Lorenz Brehme, Benedikt Dornauer, Thomas Ströhle, Maximilian Ehrhart, Ruth Breu"
citekey: brehme2025ragindustry
aliases: [brehme2025ragindustry]
year: 2025
venue: "KDIR 2025 (arXiv:2508.14066)"
url: "https://arxiv.org/abs/2508.14066"
tags: [paper, arxiv, rag, industry, evaluation]
status: summarized
added_by: Pablo
---

# RAG in Industry: Interview Study

## Summary
Semi-structured interview study with **13 industry practitioners** on real-world RAG adoption (accepted KDIR 2025).

**Use cases:** Current RAG deployments are predominantly **domain-specific QA** tasks; most systems remain in **prototype or early production** stages.

**System requirements (priority order):**
1. Data protection and privacy
2. Security
3. Output quality / accuracy
4. (Ethics, bias, scalability receive significantly less attention in practice)

**Key challenges:**
- **Data preprocessing** is the most consistently cited operational challenge — cleaning, formatting, and normalising source documents before indexing.
- Scalability and bias are underaddressed compared to academic literature.

**Evaluation:** Industry evaluation is **predominantly manual/human** rather than automated (RAGAS, DeepEval, etc.). Automated evaluation tools are known but not yet standard practice.

## Abstract
Semi-structured interview study with 13 industry practitioners to explore the current state of RAG adoption in real-world settings. Investigates how companies apply RAG in practice: (1) overview of industry use cases, (2) consolidated list of system requirements, (3) key challenges and lessons learned, (4) analysis of current industry evaluation methods.

# Retrieval-Augmented Generation in Industry: An Interview Study on Use Cases, Requirements, Challenges, and Evaluation

## Resumen
Retrieval-Augmented Generation (RAG) is a well-established and rapidly evolving field within AI that enhances the outputs of large language models by integrating relevant information retrieved from external knowledge sources. While industry adoption of RAG is now beginning, there is a significant lack of research on its practical application in industrial contexts. To address this gap, we conducted a semistructured interview study with 13 industry practitioners to explore the current state of RAG adoption in real-world settings. Our study investigates how companies apply RAG in practice, providing (1) an overview of industry use cases, (2) a consolidated list of system requirements, (3) key challenges and lessons learned from practical experiences, and (4) an analysis of current industry evaluation methods. Our main findings show that current RAG applications are mostly limited to domain-specific QA tasks, with systems still in prototype stages; industry requirements focus primarily on data protection, security, and quality, while issues such as ethics, bias, and scalability receive less attention; data preprocessing remains a key challenge, and system evaluation is predominantly conducted by humans rather than automated methods.
