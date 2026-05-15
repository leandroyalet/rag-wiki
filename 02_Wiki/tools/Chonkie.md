---
type: tool
aliases: [chonkie, chonkie-ai]
tags: [rag, tool, chunking, ingestion, preprocessing]
status: stub
created: 2026-05-15
updated: 2026-05-15
sources: ["[[01_Sources/web_clips/chonkie-docs-welcome]]"]
---

# Chonkie

> **TL;DR** Open-source Python/JS ingestion library that provides 10+ chunking strategies (token, sentence, semantic, neural, code, LLM-powered, and more), embedding integrations, vector DB handshakes, and a self-hosted REST API — all from a single `pip install chonkie`.

## Context
RAG pipelines require document chunking before embedding and indexing. Existing solutions are either too complex (large framework lock-in) or too limited (a single fixed-size splitter). Chonkie occupies the middle ground: a focused, lightweight library dedicated to the chunking and ingestion step, with broad coverage of strategies and integrations. [[01_Sources/web_clips/chonkie-docs-welcome]]

## How it works
Chonkie models the ingestion pipeline as a sequence of modular components:

1. **Chefs** — format-specific loaders (TableChef, TextChef, MarkdownChef) that normalize raw files into text.
2. **Chunkers** — 10+ strategies (see below) that split the text into `Chunk` objects.
3. **Refineries** — post-processors applied after chunking (overlap, embedding attachment).
4. **Handshakes** — export connectors to vector databases.
5. **Porters** — export to JSON or Hugging Face datasets.

[[01_Sources/web_clips/chonkie-docs-welcome]]

## Chunkers

| Chunker | Strategy | Notes |
|---------|----------|-------|
| **TokenChunker** | Fixed-size token windows | General-purpose baseline |
| **SentenceChunker** | Sentence boundary splitting | Preserves grammatical units |
| **RecursiveChunker** | Hierarchical delimiter cascade | `\n\n` → `\n` → ` ` |
| **FastChunker** | SIMD byte-level splitting | 100+ GB/s throughput |
| **SemanticChunker** | Embedding cosine similarity | Splits on topic drift |
| **NeuralChunker** | Fine-tuned BERT | Detects semantic shift boundaries |
| **LateChunker** | Document-level embeddings + segment | See [[Late Chunking]] |
| **CodeChunker** | AST-aware | 165+ programming languages |
| **TableChunker** | Markdown table preservation | Structural integrity |
| **SlumberChunker** | LLM-powered agentic splitting | Highest quality, highest cost |

[[01_Sources/web_clips/chonkie-docs-welcome]]

## Refineries

- **OverlapRefinery** — appends N tokens of the previous chunk to the current one, ensuring boundary context is not lost. Corresponds to the "overlap" parameter in fixed-size chunkers.
- **EmbeddingsRefinery** — computes and attaches vector embeddings to each `Chunk` object so downstream code receives pre-embedded chunks.

[[01_Sources/web_clips/chonkie-docs-welcome]]

## Embedding support
Unified `AutoEmbeddings` interface covering: Model2Vec (ultra-fast static), SentenceTransformers, OpenAI, Azure OpenAI, Cohere, Jina, Gemini, Voyage AI, and custom adapters. [[01_Sources/web_clips/chonkie-docs-welcome]]

## Vector DB integrations
ChromaDB, [[Qdrant]], [[Weaviate]], [[Pinecone]], Turbopuffer, pgvector, MongoDB, Elasticsearch. [[01_Sources/web_clips/chonkie-docs-welcome]]

## REST API
A self-hosted API server (`chonkie serve`) exposes all chunkers and refineries over HTTP, enabling language-agnostic use without sending data to a third party. Supports reusable pipeline configs via `/v1/pipelines`. [[01_Sources/web_clips/chonkie-docs-welcome]]

## Installation
```bash
pip install chonkie                              # default
pip install "chonkie[semantic]"                 # + semantic chunker
pip install "chonkie[all]"                      # everything
pip install "chonkie[api,semantic,code,openai]" # + REST API server
```
JavaScript: `npm install @chonkiejs/core`

## Trade-offs
- ✅ Dedicated chunking library — no heavy framework dependency.
- ✅ Wide strategy coverage in one package — easy to benchmark multiple approaches.
- ✅ Self-hosted API enables polyglot stacks (Java, Go, etc.).
- ✅ MIT license, privacy-first (local processing by default).
- ❌ Python-first; JS package covers only core chunking.
- ❌ SlumberChunker (LLM-powered) inherits LLM cost and latency.

## Related pages
- [[Chunking]] — conceptual overview of all chunking strategies.
- [[Late Chunking]] — the LateChunker strategy in detail.
- [[Adaptive Chunking]] — per-document strategy selection.
- [[MoC]] — another approach to routing chunking strategies.
- [[Embeddings]] — embedding models used by SemanticChunker and EmbeddingsRefinery.

## Sources
- [[01_Sources/web_clips/chonkie-docs-welcome]]
