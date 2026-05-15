---
title: "Chonkie: The Lightweight Ingestion Library for Fast, Efficient and Robust RAG Pipelines"
source: "https://docs.chonkie.ai/common/welcome"
author:
  - "Chonkie Inc."
published:
created: 2026-05-15
description: "Official documentation overview for Chonkie, a Python/JS library offering 10+ chunking strategies, embedding integrations, vector DB handshakes, and a self-hosted REST API for RAG ingestion pipelines."
tags:
  - clippings
---

# Chonkie: Lightweight RAG Ingestion Library

Chonkie is a streamlined ingestion library designed to simplify RAG pipeline development. Designed as an alternative to overly complex or feature-limited solutions.

> "We are all going to die one day, and we have no reason to waste time figuring out how to chunk documents."

## Core Philosophy

Chonkie emphasizes simplicity, speed, lightweight implementation, and flexibility.

**What is Chunking?**
Chunking breaks down text into smaller, manageable pieces for RAG applications. Ideal chunks must be:
- Reconstructable (combinable to recreate original text)
- Independent (standalone units addressing single ideas)
- Sufficient (long enough to be meaningful)

**Why Chunking Matters:**
1. Models have limited context windows
2. Processing entire documents is computationally expensive
3. Focused chunks improve semantic representation
4. Smaller chunks reduce model hallucination

## Key Features

1. **Comprehensive functionality** — Clean, CHONK, Embed, Refine and Store operations within a single library
2. **Minimal setup** — Installation and import lead directly to usability
3. **Performance** — Optimized for rapid processing via SIMD, caching, fast tokenizers, parallel processing
4. **Broad ecosystem support** — Compatible with various tokenizers, chunkers, embeddings, and vector databases
5. **Multi-platform availability** — Python, JavaScript/TypeScript, and REST API
6. **AI Agent Integration** — Skills module compatible with Claude Code, Cursor, Copilot, and 20+ AI agents

## Available Chunkers (10+)

| Chunker | Description |
|---------|-------------|
| **TokenChunker** | Fixed-size token windows (general-purpose) |
| **SentenceChunker** | Splits at sentence boundaries |
| **RecursiveChunker** | Hierarchical chunking using multiple delimiters |
| **FastChunker** | SIMD-accelerated, 100+ GB/s throughput (byte-based) |
| **TableChunker** | Handles markdown tables |
| **SemanticChunker** | Uses embeddings for topic coherence |
| **CodeChunker** | AST-aware code splitting (165+ languages) |
| **LateChunker** | Document-level embeddings for richer context |
| **NeuralChunker** | Fine-tuned BERT for semantic shift detection |
| **SlumberChunker** | LLM-powered agentic chunking |

## Performance Optimizations

- Pipelining for stronger heuristics
- Caching and pre-computation
- Smart token estimate-validate feedback loops
- Fast tokenizers (TikToken, AutoTikTokenizer)
- Ultra-fast static embeddings (Model2Vec)
- Parallel processing

## Features

**Embedding Providers:**
AutoEmbeddings, Model2Vec, SentenceTransformers, OpenAI, Azure OpenAI, Cohere, Jina, Gemini, Voyage AI, and custom models.

**Refineries:**
- **OverlapRefinery**: Adds contextual overlap between chunks
- **EmbeddingsRefinery**: Generates and attaches vector embeddings to chunks

**Database Integrations (Handshakes):**
ChromaDB, Qdrant, Weaviate, Turbopuffer, Pinecone, pgvector, MongoDB, Elasticsearch

**Data Processing:**
- Chefs (TableChef, TextChef, MarkdownChef) — prepare raw data from various file formats
- Porters — export to JSON and Hugging Face formats
- Visualizer — debugging tool for inspecting chunks

## Language Support

**Python**: Full feature set
- `pip install chonkie` — default
- `pip install "chonkie[semantic]"` — with semantic features
- `pip install "chonkie[all]"` — everything

**JavaScript/TypeScript**: Core chunking via `@chonkiejs/core`

## REST API Server

Self-hosted REST API enabling language-agnostic chunking without authentication or data leaving your infrastructure.

```bash
pip install "chonkie[api,semantic,code,openai]"
chonkie serve
```

API at `http://localhost:8000/docs`

**Key Endpoints:**
- `/v1/chunk/token`, `/v1/chunk/sentence`, `/v1/chunk/recursive`
- `/v1/chunk/semantic`, `/v1/chunk/code`
- `/v1/refine/overlap`, `/v1/refine/embeddings`
- `/v1/pipelines` — reusable workflow configs

## Docker Deployment

Pre-configured docker-compose with environment variable support, health checks, and production recommendations.

## Recent Updates (v1.5.4)

New Genie integrations:
- **GroqGenie**: Fast inference on Groq hardware
- **CerebrasGenie**: Ultra-fast Cerebras inference

Both support `generate()` and `generate_json()`.

## Breaking Changes (v1.3.0)

- Unified `Chunk` type replacing specialized types
- All chunkers return base `Chunk` class
- `SemanticSentence` merged into base `Sentence` type
- Optional `embedding` attribute added to `Chunk` and `Sentence`

## Open Source

MIT license. Privacy-first (local-only processing). Battle-tested in production.
