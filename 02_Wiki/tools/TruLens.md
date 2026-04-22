---
type: tool
aliases: [TruEra TruLens, truera/trulens]
tags: [rag, eval, tool, monitoring, llm-eval]
status: stub
created: 2026-04-21
updated: 2026-04-21
sources: []
homepage: https://www.trulens.org
repo: https://github.com/truera/trulens
docs: https://www.trulens.org/docs/
year: 2023
---

# TruLens

> **TL;DR** Open-source LLM evaluation and runtime monitoring framework by TrueRA, built around the **RAG Triad** (Context Relevance, Groundedness, Answer Relevance) — instruments your pipeline to log every step and score it with configurable feedback functions.

## What it is
TruLens is a Python framework (maintained by TrueRA, GitHub: `truera/trulens`) for evaluating and monitoring LLM applications. Its defining contribution is the **RAG Triad** — a three-metric framework designed to systematically detect hallucinations across every stage of the RAG pipeline.

Unlike [[RAGAS]] (which runs evaluations as a post-hoc batch) and [[DeepEval]] (which wraps evals in pytest), TruLens emphasises **instrumentation**: it wraps your existing pipeline (LangChain, LlamaIndex, etc.) and logs every retrieval call, LLM call, and response at runtime, then applies feedback functions continuously.

## The RAG Triad

The three metrics work together to verify hallucination-free output end-to-end:

| Metric | Stage | Question answered |
|--------|-------|------------------|
| **Context Relevance** | Retrieval | Are the retrieved chunks pertinent to the query? |
| **Groundedness** | Generation | Is every claim in the response supported by the context? |
| **Answer Relevance** | Output | Does the response actually address the user's question? |

**Groundedness** is the generation-side complement to [[Faithfulness]] (RAGAS terminology). TruLens computes it by decomposing the response into individual claims and searching for supporting evidence in the retrieved context — catching "exaggerating or expanding to a correct-sounding answer."

All three passing → "hallucination-free up to the limit of the knowledge base."

## Feedback functions
Feedback functions are the evaluation primitives in TruLens — programmatic methods that wrap a provider model and score one aspect of an application run. They span a quality/scalability spectrum:

| Tier | Examples | Trade-off |
|------|----------|-----------|
| Ground truth / expert | Manual annotation | High meaning, low scale |
| Human feedback | Binary up/down ratings | Moderate scale, high variance |
| Traditional NLP | BLEU, ROUGE | High scale, syntactically limited |
| Medium LMs | BERT-based NLI | Cost-effective, nuanced |
| Large LMs | GPT-4o, Claude | High meaning, expensive at scale |

Built-in feedback functions cover: groundedness (NLI decomposition), sentiment, language matching, and content moderation. Custom functions can be defined for domain-specific criteria.

**Supported providers**: OpenAI, Anthropic, Google (Vertex / Gemini), AWS Bedrock, HuggingFace, LiteLLM, Snowflake Cortex.

## How to run

```python
from trulens.apps.langchain import TruChain
from trulens.core import TruSession
from trulens.providers.openai import OpenAI

session = TruSession()
provider = OpenAI()

# Define feedback functions
from trulens.core.feedback import Feedback
import numpy as np

f_context_relevance = (
    Feedback(provider.context_relevance, name="Context Relevance")
    .on_input()
    .on(context)
    .aggregate(np.mean)
)
f_groundedness = Feedback(provider.groundedness_measure_with_cot_reasons, name="Groundedness")
f_answer_relevance = Feedback(provider.relevance, name="Answer Relevance").on_input_output()

# Wrap your chain
tru_chain = TruChain(
    my_rag_chain,
    app_name="RAG App",
    feedbacks=[f_context_relevance, f_groundedness, f_answer_relevance],
)

# Run and log
with tru_chain as recording:
    my_rag_chain.invoke("What is RAG?")

# Launch dashboard
session.run_dashboard()
```

## Logging backends
- **PostgreSQL** — persistent storage for production deployments.
- **Snowflake** — native Cortex integration; log and evaluate inside the data warehouse.
- In-memory SQLite (default) for local development.

## Framework integrations
[[LangChain]], LangGraph, [[LlamaIndex]] (workflows + agents), NeMo Guardrails, [[MLflow]].

## When to use it
- ✅ Runtime instrumentation needed — TruLens wraps the live pipeline, not a post-hoc test suite.
- ✅ RAG Triad provides a principled, minimal evaluation starting point.
- ✅ Snowflake-native stack — Cortex integration is unique to TruLens.
- ✅ Dashboard needed for ongoing monitoring and A/B comparison of pipeline versions.
- ❌ More than 3 metrics needed immediately — [[DeepEval]] has 14+ built-in metrics.
- ❌ pytest-based CI/CD evaluation workflow — prefer [[DeepEval]].
- ❌ Reference-free batch evaluation without instrumentation — [[RAGAS]] is simpler.

## Comparison with similar tools

| | TruLens | [[RAGAS]] | [[DeepEval]] |
|---|---|---|---|
| Primary mode | Runtime instrumentation | Batch eval | pytest-based eval |
| Core metrics | RAG Triad (3) | 7 metrics | 14+ metrics |
| Custom metrics | Feedback functions | Custom metrics | G-Eval (rubric-based) |
| Dashboard | ✅ Built-in | ❌ | ✅ (Confident AI cloud) |
| Logging backend | PostgreSQL, Snowflake | — | Confident AI cloud |
| CI/CD integration | Manual | Manual | Native pytest plugin |

## Related pages
- [[RAGAS]]
- [[DeepEval]]
- [[Faithfulness]] — RAGAS term for TruLens's Groundedness
- [[Context Relevance]]
- [[Hallucination in RAG]]
- [[Retrieval-Augmented Generation]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/ yet; information from trulens.org
