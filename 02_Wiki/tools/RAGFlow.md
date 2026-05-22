---
type: tool
aliases: [RAG Flow, InfiniFlow RAGFlow]
tags: [rag, tool, framework, document-processing, agent]
status: stub
created: 2026-05-17
updated: 2026-05-17
sources: ["[[01_Sources/web_clips/infiniflow-ragflow-infinity]]"]
homepage: https://ragflow.io
repo: https://github.com/infiniflow/ragflow
docs: https://ragflow.io/docs
---

# RAGFlow

> **TL;DR** Open-source RAG engine by InfiniFlow combining deep document understanding (template-based DeepDoc chunking), hybrid search, traceable citations, and visual agent orchestration — designed for enterprise RAG at any scale.

## What it is
RAGFlow is a full-stack, open-source RAG platform that acts as a context layer for LLM agents. It distinguishes itself from framework-level tools (like [[LangChain]] or [[LlamaIndex]]) by owning the entire pipeline: ingestion, parsing, chunking, retrieval, and agent orchestration — in a single deployable service. [[01_Sources/web_clips/infiniflow-ragflow-infinity]]

## Deep document understanding (DeepDoc)
RAGFlow's proprietary parsing layer goes beyond converting files to text:
- **Template-based chunking**: multiple layout templates (general, résumé, paper, book, Q&A, etc.) that match document type to optimal segmentation.
- **Document visualisation**: chunks are displayed in a UI for human verification and correction before indexing — "explainable" chunking.
- **Supported formats**: DOCX, PPTX, XLSX, plain text, images, scanned documents, structured data, web pages.
- **Parser backends**: integrates [[Docling]] and MinerU for advanced PDF / layout parsing.
- **Unlimited tokens**: handles arbitrarily long documents by processing in segments.

## Retrieval
- **Hybrid search**: vector search + [[BM25]] + custom scoring, fused by configurable reranking strategies (RRF, weighted sum, [[ColBERT]]).
- **Traceable citations**: every generated claim is linked back to its source chunk, reducing [[Hallucination in RAG|hallucination]] risk with a quick-reference visualisation.
- **Multiple recall strategies**: configurable retrieval modes for different query types.

## Agent orchestration
- Visual workflow builder for composing agentic pipelines.
- Memory support for multi-turn agents.
- **MCP (Model Context Protocol)** integration: RAGFlow agents can consume and expose tools over MCP.
- Web search, HTTP connectors, code execution, sub-agent delegation.

## Data connectors
Confluence, S3, Notion, Discord, Google Drive; cross-language querying.

## Infrastructure stack (self-hosted)
| Component | Role |
|-----------|------|
| [[Infinity]] or Elasticsearch | Vector / hybrid search backend |
| MinIO | Object storage (raw files) |
| Redis | Cache |
| MySQL | Metadata persistence |

Docker Compose deployment; minimum requirements: 4 CPU cores, 16 GB RAM, 50 GB disk.

Cloud option: [cloud.ragflow.io](https://cloud.ragflow.io)

## Quick start
```bash
git clone https://github.com/infiniflow/ragflow.git
cd ragflow/docker
docker compose -f docker-compose.yml up -d
```
Access the UI at `http://localhost` (default port 80).

## Supported LLMs / embeddings
DeepSeek, GPT-4/5, Gemini, and 20+ configurable providers via an API-key settings panel.

## When to use / when not to
- ✅ Enterprise RAG over diverse document types (PDFs, slide decks, scanned docs).
- ✅ Need traceable, auditable citations for compliance or regulated domains.
- ✅ Building agentic workflows that mix RAG retrieval with tool use and MCP.
- ✅ Want a complete service (UI + API) rather than assembling components.
- ❌ Minimal footprint required — full stack (Docker + multiple services) is heavy.
- ❌ Already committed to LangChain / LlamaIndex ecosystem and need component-level control.

## Related / alternatives
- [[LangChain]], [[LlamaIndex]], [[Haystack]] — framework-level (assemble your own pipeline).
- [[Docling]] — document parser used by RAGFlow as a backend.
- [[Infinity]] — AI-native database used as RAGFlow's search backend (same vendor).
- [[Chunking]] — RAGFlow's DeepDoc is a specialised template-based chunking approach.
- [[Hybrid Search]] — core retrieval mechanism.

## Sources
- [[01_Sources/web_clips/infiniflow-ragflow-infinity]]
