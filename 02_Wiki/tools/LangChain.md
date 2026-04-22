---
type: tool
aliases: [LangChain framework, LCEL]
tags: [rag, tool, framework, orchestration, agents]
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: []
---

# LangChain

> **TL;DR** The most widely adopted open-source LLM framework — provides a composable expression language (LCEL) for chains and agents, with 500+ integrations and a large community ecosystem.

## What it is
LangChain (MIT licence, maintained by LangChain Inc.) is a Python and JavaScript framework for building LLM-powered applications. Its central abstractions are **Runnables** — composable units wired together with the **LangChain Expression Language (LCEL)** using the pipe operator (`|`).

Agents in LangChain are built on top of **LangGraph** — a lower-level graph-based orchestration framework for durable, stateful, and streaming agent loops.

### Core abstractions
| Abstraction | Role |
|-------------|------|
| **Runnable / LCEL** | Composable pipeline unit; supports `invoke`, `stream`, `batch`, async |
| **Chain** | Linear sequence of Runnables (legacy API) |
| **PromptTemplate** | Parameterised prompt construction |
| **Retriever** | Interface over any document store |
| **Document Loader** | Ingest from PDFs, URLs, databases, APIs |
| **Text Splitter** | [[Chunking]] strategies (recursive, semantic, etc.) |
| **Agent + Tools** | LLM-driven loops with tool calling; built on LangGraph |
| **Memory** | Conversation state management |

### Typical RAG pipeline (LCEL)
```python
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain_community.vectorstores import Qdrant
from langchain_core.runnables import RunnablePassthrough
from langchain_core.prompts import ChatPromptTemplate

retriever = Qdrant(...).as_retriever(search_kwargs={"k": 5})
prompt = ChatPromptTemplate.from_template("Context: {context}\n\nQuestion: {question}")
llm = ChatOpenAI(model="gpt-4o")

chain = (
    {"context": retriever, "question": RunnablePassthrough()}
    | prompt
    | llm
)
chain.invoke("What is RAG?")
```

## Key integrations
**LLMs**: OpenAI, Anthropic, Google, Mistral, Cohere, Ollama, AWS Bedrock, HuggingFace, and 100+ more.
**Vector stores**: [[Qdrant]], [[Pinecone]], [[Weaviate]], [[FAISS]], Chroma, pgvector, and 50+ more.
**Document loaders**: PDFs, Word, HTML, YouTube, Notion, SQL, APIs via [[Docling]], Unstructured, etc.
**Evaluation**: LangSmith (observability platform by LangChain Inc.).

## When to use it
- ✅ Largest ecosystem — most tutorials, community answers, and third-party integrations target LangChain.
- ✅ Rapid prototyping — minimal boilerplate for common RAG patterns.
- ✅ Agents with complex tool-calling or multi-step reasoning via LangGraph.
- ❌ Production type-safety — connections are not validated at build time (vs. [[Haystack]]).
- ❌ YAML-configurable pipelines — [[Haystack]] has native serialisation; LangChain requires LangChain Hub.
- ❌ Data-indexing heavy workflows — [[LlamaIndex]] has richer index and ingestion abstractions.

## Related pages
- [[LlamaIndex]]
- [[Haystack]]
- [[Retrieval-Augmented Generation]]
- [[Chunking]]
- [[Vector Database]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/; information from docs.langchain.com
