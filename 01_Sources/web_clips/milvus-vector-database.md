---
title: "Milvus: High-Performance Vector Database Built for Scale"
source: "https://milvus.io/"
content_retrieved_from: "https://raw.githubusercontent.com/milvus-io/milvus/master/README.md"
author:
  - "Zilliz / Milvus community"
published:
created: 2026-05-16
description: "Official overview of Milvus, an open-source, distributed, Kubernetes-native vector database for AI-scale similarity search and RAG pipelines."
tags:
  - clippings
---

# Milvus: Vector Database Built for Scale

## What is Milvus?

Milvus is a high-performance vector database built for scale, designed to power AI applications by efficiently organising and searching unstructured data like text, images, and multi-modal information.

## Core Architecture & Technology

**Languages & Implementation:**
- Written in Go and C++
- Hardware acceleration for CPU/GPU optimisation
- Fully-distributed, Kubernetes-native architecture enabling horizontal scaling

**Deployment Options:**
- Distributed cluster deployment
- Standalone mode for single-machine use
- Milvus Lite (Python library via `pip install pymilvus[milvus-lite]`)
- Zilliz Cloud (fully managed service with Serverless, Dedicated, and BYOC options)

## Key Features

**Vector Indexing & Search:**
- Supports multiple index types: HNSW, IVF, FLAT, SCANN, DiskANN
- Quantisation-based variations and memory-mapped indexing
- GPU indexing support (NVIDIA CAGRA)
- Metadata filtering and range search capabilities

**Advanced Capabilities:**
- Multi-tenancy at database, collection, partition, and partition-key levels
- Hot/cold storage for cost optimisation
- Sparse vector support for full-text search (BM25, SPLADE, BGE-M3)
- Real-time streaming updates

**Security & Access Control:**
- Mandatory user authentication
- TLS encryption for network communications
- Role-Based Access Control (RBAC)

## Performance & Scale

Milvus handles "tens of thousands of search queries on billions of vectors" with separation of compute and storage layers enabling independent scaling of query and data nodes.

## Primary Use Cases

- Text and image search
- Retrieval-Augmented Generation (RAG)
- Recommendation systems
- Semantic and hybrid search
- Question answering systems
- Multi-modal retrieval

## Ecosystem & Integration

Milvus integrates with:
- **Development frameworks:** LangChain, LlamaIndex, OpenAI, HuggingFace
- **Data connectors:** Spark, Kafka, Fivetran, Airbyte
- **Tools:** Attu (GUI administration), Birdwatcher (debugging), Prometheus/Grafana (monitoring)
- **Data sync:** Milvus CDC for synchronisation

## Governance & Licensing

- Under LF AI & Data Foundation stewardship
- Distributed under Apache 2.0 licence
- Zilliz serves as major contributor
- 432+ project contributors

## Getting Started

```python
from pymilvus import MilvusClient
client = MilvusClient("milvus_demo.db")  # Local (Milvus Lite)
# or
client = MilvusClient(uri="<endpoint>", token="<credentials>")  # Zilliz Cloud / cluster
```
