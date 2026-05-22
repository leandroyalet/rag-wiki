---
type: tool
aliases: [deepset Haystack, Haystack AI]
tags: [rag, tool, framework, orchestration, agents]
status: stub
created: 2026-04-20
updated: 2026-04-20
sources: []
---

# Haystack

> **TL;DR** Open-source AI orchestration framework by deepset built around composable, serializable pipelines of typed components — designed for production RAG, agentic loops, and multi-modal applications with full transparency into every processing step.

## What it is
Haystack is a Python framework (Apache 2.0 license) maintained by **deepset GmbH** for building LLM-powered applications. Its central abstraction is the **pipeline**: a directed multigraph of components where data flows only through explicit connections, enabling branching, loops, and async execution.

Unlike sequential chain frameworks, Haystack validates connection types at pipeline construction time — catching errors before a single query runs.

### Core building blocks

| Abstraction | Role |
|-------------|------|
| **Component** | Atomic processing unit (retriever, embedder, generator, router, …). Each declares typed `@input` / `@output` slots. |
| **Pipeline** | Directed multigraph of connected components. Serializable to/from YAML via each component's `to_dict` / `from_dict`. |
| **Document Store** | Persistence layer for documents + vectors. Paired with a matching Retriever component. |
| **Agent / Tool** | Components that invoke external tools or loop until a stopping condition (ReAct, function-calling). |

## RAG pipeline pattern
A typical indexing + query pipeline:

```python
from haystack import Pipeline
from haystack.components.embedders import SentenceTransformersDocumentEmbedder
from haystack.components.writers import DocumentWriter
from haystack_integrations.document_stores.qdrant import QdrantDocumentStore

# Indexing
store = QdrantDocumentStore(url="http://localhost:6333", index="docs")
indexing = Pipeline()
indexing.add_component("embedder", SentenceTransformersDocumentEmbedder())
indexing.add_component("writer", DocumentWriter(document_store=store))
indexing.connect("embedder.documents", "writer.documents")

# Query
from haystack.components.retrievers import EmbeddingRetriever
from haystack.components.generators import OpenAIGenerator
from haystack.components.builders import PromptBuilder

query_pipeline = Pipeline()
query_pipeline.add_component("embedder", ...)
query_pipeline.add_component("retriever", EmbeddingRetriever(document_store=store))
query_pipeline.add_component("prompt", PromptBuilder(template="..."))
query_pipeline.add_component("llm", OpenAIGenerator())
query_pipeline.connect("embedder.embedding", "retriever.query_embedding")
query_pipeline.connect("retriever.documents", "prompt.documents")
query_pipeline.connect("prompt.prompt", "llm.prompt")
```

Pipelines serialize to YAML, enabling version control and editing outside Python.

## Key design decisions vs. alternatives
| | Haystack | [[LangChain]] | [[LlamaIndex]] |
|---|---|---|---|
| Core abstraction | Typed component graph | Chain / LCEL | Index / query engine |
| Serialization | YAML (native) | Partial (LangChain Hub) | JSON/YAML (partial) |
| Type validation | Build-time | Runtime | Runtime |
| Primary focus | Production RAG + agents | Broad LLM chains | Data indexing + retrieval |
| Loop / branching | First-class | Via LangGraph | Limited |
| Eval integration | RAGAS, DeepEval, Arize | LangSmith | LlamaEval |

## Integrations (110 total)

**LLM providers**: OpenAI, Anthropic, Google AI, Mistral, Cohere, Hugging Face, Ollama, AWS Bedrock, Azure, vLLM, IBM Watsonx, and 15+ more.

**Embedding models**: FastEmbed, Jina AI, Voyage AI, mixedbread ai, INSTRUCTOR.

**Document stores / vector DBs**: [[Qdrant]], [[Pinecone]], [[Weaviate]], [[FAISS]], Chroma, Elasticsearch, OpenSearch, pgvector, [[Milvus]], MongoDB, Neo4j, AstraDB, LanceDB, and more.

**Ingestion**: [[Docling]], Azure Document Intelligence, Unstructured, PaddleOCR, Firecrawl, Notion Extractor.

**Evaluation / monitoring**: [[RAGAS]], [[DeepEval]], langfuse, MLflow, Arize Phoenix, Weights & Biases.

## When to use it
- ✅ Production deployment required — typed pipelines catch integration errors at build time.
- ✅ Need branching / loops (self-correcting RAG, ReAct agents) as first-class pipeline constructs.
- ✅ YAML pipeline serialization for CI/CD or non-engineer editing.
- ✅ Broad document-store choice without framework lock-in.
- ❌ Rapid prototyping where LangChain's larger community and notebook examples are more valuable.
- ❌ Heavy indexing / data-transformation focus — LlamaIndex's index abstractions may be more ergonomic.

## Related pages
- [[LangChain]]
- [[LlamaIndex]]
- [[Retrieval-Augmented Generation]]
- [[Qdrant]]
- [[Weaviate]]
- [[Docling]]
- [[RAGAS]]
- [[DeepEval]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/ yet; information from haystack.deepset.ai and docs.haystack.deepset.ai
