---
type: concept
aliases: [Federated Retrieval-Augmented Generation, FedRAG, privacy-preserving RAG]
tags: [rag, federated-learning, privacy, distributed]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: ["[[chakraborty2025fedrag]]"]
---

# Federated RAG

> **TL;DR** An architecture that combines Federated Learning (distributed model training, raw data never leaves the client) with RAG (grounding LLM responses in external knowledge) — enabling knowledge-intensive LLM applications in privacy-sensitive domains like healthcare and finance.

## Definition
Federated RAG (FedRAG) merges two paradigms:
- **Federated Learning (FL)**: multiple clients collaboratively train or fine-tune a model while keeping their raw data local — only model updates (gradients or weights) are shared with a central server.
- **[[Retrieval-Augmented Generation]]**: at inference time, the LLM queries an external knowledge store to ground its responses in retrieved evidence.

The combination lets organisations benefit from shared model knowledge and RAG-style accuracy without pooling sensitive documents into a central index. [[chakraborty2025fedrag]]

## Context
Healthcare, finance, and legal domains frequently hold data under strict privacy regulations (HIPAA, GDPR) that prohibit centralising patient records, transaction logs, or case files. Naive RAG requires a central vector index over all documents — incompatible with these constraints. FedRAG distributes both the training and the retrieval, keeping documents at the originating institution. [[chakraborty2025fedrag]]

## Architectural patterns (from the 2020–2025 literature)
A systematic mapping study ([[chakraborty2025fedrag]]) covering federated RAG literature from 2020–2025 identifies recurring design patterns:
- **Federated indexing**: each client builds a local vector index; queries are broadcast and results merged centrally.
- **Federated fine-tuning + central RAG**: FL updates a shared retriever or generator; inference uses a central index.
- **Fully distributed**: both index and inference are distributed; no central server holds model or data.

## Open challenges
Three major unsolved problems identified by [[chakraborty2025fedrag]]:
1. **Privacy-preserving retrieval** — preventing membership inference attacks on query patterns and retrieved documents.
2. **Cross-client heterogeneity** — clients have different data distributions, document formats, and index sizes; retrieval quality degrades without normalisation.
3. **Evaluation limitations** — no standard federated RAG benchmark exists; most papers evaluate on simulated splits of centralised datasets.

## Related pages
- [[Retrieval-Augmented Generation]]
- [[Vector Database]]
- [[Dense Retrieval]]
- [[Hallucination in RAG]]

## Sources
- [[chakraborty2025fedrag]]
