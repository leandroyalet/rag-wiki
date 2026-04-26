---
type: tool
aliases: [BeyondLLM framework]
tags: [rag, tool, framework, evaluation]
status: stub
created: 2026-04-23
updated: 2026-04-23
sources: ["[[01_Sources/web_clips/Evaluate RAG pipeline using HuggingFace Open Source Models]]"]
homepage: https://beyondllm.aiplanet.com
repo: https://github.com/aiplanethub/beyondllm
---

# BeyondLLM

> **TL;DR** Lightweight open-source Python framework by AI Planet for building and evaluating RAG pipelines with HuggingFace models in a few lines of code — includes built-in RAG Triad evaluation.

## What it is
BeyondLLM (AI Planet, open-source) is a high-level RAG framework designed to minimise boilerplate. It wraps data ingestion, [[Embeddings|embedding]], retrieval (including cross-rerank), LLM generation, and evaluation into a single `Generate` pipeline object. [[01_Sources/web_clips/Evaluate RAG pipeline using HuggingFace Open Source Models]]

## Core pipeline

```python
from beyondllm import source, retrieve, generator
from beyondllm.embeddings import HuggingFaceEmbeddings
from beyondllm.llms import HuggingFaceHubModel

data = source.fit("file.pdf", dtype="pdf", chunk_size=1024, chunk_overlap=0)
embed_model = HuggingFaceEmbeddings(model_name="BAAI/bge-small-en-v1.5")
retriever = retrieve.auto_retriever(data=data, embed_model=embed_model,
                                    type="cross-rerank", top_k=5)
llm = HuggingFaceHubModel(model="mistralai/Mistral-7B-Instruct-v0.2")

pipeline = generator.Generate(question="...", retriever=retriever, llm=llm)
print(pipeline.call())
print(pipeline.get_rag_triad_evals())
```

## Built-in evaluation metrics
Mirrors the RAG Triad from [[TruLens]] and [[RAGAS]]: [[Context Relevance]], [[Answer Relevance]], Groundedness, and Ground Truth (reference-based). [[01_Sources/web_clips/Evaluate RAG pipeline using HuggingFace Open Source Models]]

## When to use it
- ✅ Quick HuggingFace-native prototyping — no need to wire LangChain/LlamaIndex manually.
- ✅ Want built-in RAG Triad evaluation without a separate RAGAS/TruLens setup.
- ❌ Production pipelines — less mature ecosystem than [[LangChain]] or [[LlamaIndex]].
- ❌ Non-HuggingFace LLMs as the primary target — other frameworks offer broader provider support.

## Related pages
- [[LangChain]]
- [[LlamaIndex]]
- [[RAGAS]]
- [[TruLens]]
- [[Reranking]]
- [[Embeddings]]

## Sources
- [[01_Sources/web_clips/Evaluate RAG pipeline using HuggingFace Open Source Models]]
