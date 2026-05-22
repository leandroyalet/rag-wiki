---
title: "InfiniFlow: RAGFlow and Infinity — Open-Source RAG Engine and AI-Native Database"
source: "https://infiniflow.org/"
author:
  - "InfiniFlow"
published:
created: 2026-05-17
description: "InfiniFlow builds two open-source AI infrastructure products: RAGFlow (RAG engine with deep document understanding and agent orchestration) and Infinity (AI-native hybrid-search database with sub-millisecond latency)."
tags:
  - clippings
---

# InfiniFlow: RAGFlow and Infinity

InfiniFlow develops AI infrastructure for LLM applications, centred on two open-source products.

---

## RAGFlow

**What it is:** A leading open-source RAG engine (context layer for AI agents) for enterprises of any scale.

**Deep document understanding (DeepDoc):**
- Template-based, explainable chunking with multiple layout templates
- Supports Word, slides, Excel, text, images, scanned documents, structured data, and web pages
- Document visualisation with human-in-the-loop verification before processing
- Unlimited tokens of data
- Integrates MinerU and Docling as parsing backends

**Retrieval:**
- Hybrid search: vector + BM25 + custom scoring
- Fused reranking (RRF, weighted sum, ColBERT)
- Traceable citations to reduce hallucinations

**Agent orchestration:**
- Visual workflow builder for agentic pipelines
- Memory support
- MCP (Model Context Protocol) integration
- Web search, external HTTP sources, code execution, sub-agents

**Integrations:**
- Data connectors: Confluence, S3, Notion, Discord, Google Drive
- LLM/embedding models: DeepSeek, GPT-4/5, Gemini, and configurable providers
- Cross-language querying

**Infrastructure stack (self-hosted):**
- Elasticsearch or Infinity (vector/search backend)
- MinIO (object storage), Redis (cache), MySQL (metadata)
- Docker Compose deployment; minimum 4 CPU cores, 16 GB RAM, 50 GB disk

**Cloud:** cloud.ragflow.io

---

## Infinity

**What it is:** An AI-native database for LLM applications — single-binary, no external dependencies.

**Search modes:**
- Dense embedding search
- Sparse embedding search
- Tensor search
- Full-text search (BM25)
- Hybrid combinations of the above
- Metadata filtering

**Reranking:** RRF, weighted sum, ColBERT.

**Performance benchmarks:**
- Vector search: 0.1 ms query latency, 15K+ QPS on million-scale datasets
- Full-text search: 1 ms latency, 12K+ QPS on 33M documents

**Deployment:**
- Docker (Linux x86_64, macOS, Windows 10+ with WSL2)
- Binary server + client
- Python module (embedded in-process)

**Language bindings:** Python SDK (primary), HTTP API.

**Requirements:** x86_64 CPU with AVX2, Python 3.11+.
