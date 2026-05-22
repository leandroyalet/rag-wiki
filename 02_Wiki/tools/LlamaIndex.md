---
type: tool
aliases: [LlamaIndex framework, GPT Index]
tags: [rag, tool, framework, orchestration, indexing]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: []
---

# LlamaIndex

> **TL;DR** Python/TypeScript framework purpose-built for LLM-powered data retrieval — excels at data connectors, flexible index types, and composable query engines over private documents and databases.

## What it is
LlamaIndex (MIT licence, maintained by LlamaIndex Inc.) is an open-source framework for building retrieval-augmented applications over private data. Originally called GPT Index, it was renamed to reflect its broader scope. While [[LangChain]] is general-purpose, LlamaIndex is designed primarily around the **data ingestion and retrieval** workflow.

### Core abstractions
| Abstraction | Role |
|-------------|------|
| **Document / Node** | Unit of ingested content (Document = full file, Node = chunk with metadata and relationships) |
| **Data Connector** (Reader) | Ingest from 100+ sources: PDFs, Notion, SQL, Google Drive, APIs, web |
| **Index** | Organised store of Nodes; multiple types for different query patterns |
| **Retriever** | Fetch relevant Nodes from an Index given a query |
| **Query Engine** | Orchestrates retrieval + synthesis into a final answer |
| **Chat Engine** | Multi-turn conversation wrapper over a Query Engine |
| **Node Postprocessor** | Filter, rerank, or transform retrieved Nodes (e.g., [[Reranking]]) |
| **Agent** | LLM loop with tool access; supports OpenAI function calling, ReAct |

### Index types
| Type | Description |
|------|-------------|
| `VectorStoreIndex` | Embeds Nodes, stores in [[Vector Database]], retrieves by ANN |
| `SummaryIndex` | Stores Nodes in sequence; iterates all for synthesis |
| `KnowledgeGraphIndex` | Builds a triplet graph over Nodes; graph traversal retrieval |
| `DocumentSummaryIndex` | Pre-builds per-document summaries; faster high-level retrieval |
| `PropertyGraphIndex` | Richer property graph with custom node/edge types |

### Typical RAG pipeline
```python
from llama_index.core import VectorStoreIndex, SimpleDirectoryReader

documents = SimpleDirectoryReader("data/").load_data()
index = VectorStoreIndex.from_documents(documents)
query_engine = index.as_query_engine(similarity_top_k=5)
response = query_engine.query("What is RAG?")
```

## Key integrations
**LLMs**: OpenAI, Anthropic, Google, Mistral, Ollama, HuggingFace, Cohere, and 50+.
**Vector stores**: [[Qdrant]], [[Pinecone]], [[Weaviate]], [[FAISS]], Chroma, pgvector, [[Milvus]], and 30+.
**Data loaders**: 150+ connectors via LlamaHub (Notion, Confluence, GitHub, Slack, databases, APIs).
**Evaluation**: `llama-index-evaluation` module; integrations with [[RAGAS]] and [[TruLens]].

## When to use it
- ✅ Data-ingestion heavy workflows — LlamaHub connectors and index abstractions are the richest available.
- ✅ Complex retrieval patterns — multiple index types and composable query engines.
- ✅ Agentic RAG — first-class `ReActAgent` and `OpenAIAgent` with tool calling.
- ❌ General LLM chaining beyond retrieval — [[LangChain]] has a broader chain/LCEL ecosystem.
- ❌ Type-validated production pipelines — [[Haystack]]'s typed component graph catches errors earlier.

## Related pages
- [[LangChain]]
- [[Haystack]]
- [[Retrieval-Augmented Generation]]
- [[Chunking]]
- [[Vector Database]]
- [[Reranking]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/; information from developers.llamaindex.ai
