---
type: tool
aliases: [MLflow Tracking, mlflow]
tags: [rag, eval, tool, experiment-tracking, mlops]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: []
homepage: https://mlflow.org
repo: https://github.com/mlflow/mlflow
year: 2018
---

# MLflow

> **TL;DR** Open-source MLOps platform by Databricks for experiment tracking, model registry, and deployment — increasingly used for LLM/RAG evaluation logging via its `mlflow.evaluate()` API.

## What it is
MLflow is a platform for managing the ML lifecycle: tracking experiments (parameters, metrics, artifacts), packaging models, and serving them. Originally focused on traditional ML, it has expanded to support LLM evaluation workflows.

## Relevance to RAG
- **LLM evaluation**: `mlflow.evaluate()` can run RAG metrics and log results as MLflow runs, enabling comparison across pipeline versions.
- **Integrations**: [[TruLens]] can export evaluation traces to MLflow for centralised experiment management.
- **Prompt versioning**: MLflow supports prompt templates as versioned artifacts alongside model weights.

## Related pages
- [[TruLens]]
- [[RAGAS]]
- [[DeepEval]]

## Sources
> [!todo] Source needed — add MLflow LLM evaluation documentation.
