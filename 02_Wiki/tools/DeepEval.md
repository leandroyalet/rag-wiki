---
type: tool
aliases: [DeepEval, Confident AI Eval]
tags:
  - rag
  - eval
  - benchmark
  - llm-eval
status: stub
created: 2026-04-18
updated: 2026-04-18
sources: []
homepage: https://www.confident-ai.com
repo: https://github.com/confident-ai/deepeval
docs: https://docs.confident-ai.com
year: 2023
---

# DeepEval

> **TL;DR** Open-source LLM evaluation framework by Confident AI with a pytest-like interface, covering RAG, agents, and general LLM quality via 14+ built-in metrics.

## What it measures
DeepEval evaluates LLM outputs across retrieval quality, generation faithfulness, safety, and agentic behaviour. It uses an LLM-as-judge approach (configurable judge model) and integrates with CI/CD via a pytest plugin so evaluations can run as unit tests.

## Metrics
| Metric                   | Description                                                                     | Range |
| ------------------------ | ------------------------------------------------------------------------------- | ----- |
| **G-Eval**               | General-purpose CoT rubric scoring — define custom criteria in natural language | 0–1   |
| **Faithfulness**         | Fraction of answer claims entailed by the retrieved context                     | 0–1   |
| **Answer Relevancy**     | Semantic alignment between the question and the generated answer                | 0–1   |
| **Contextual Precision** | Proportion of retrieved nodes that are relevant to the question                 | 0–1   |
| **Contextual Recall**    | Coverage of reference answer content by the retrieved context                   | 0–1   |
| **Contextual Relevancy** | Overall relevance of the retrieved context to the query                         | 0–1   |
| **Hallucination**        | Degree to which the answer introduces claims not grounded in context            | 0–1   |
| **Bias**                 | Detects demographic or ideological bias in outputs                              | 0–1   |
| **Toxicity**             | Flags harmful, offensive, or unsafe language                                    | 0–1   |
| **Summarization**        | Alignment and coverage of a summary relative to its source                      | 0–1   |
| **Tool Correctness**     | Whether the right tools were called with the right arguments (agents)           | 0–1   |
| **Task Completion**      | End-to-end success of an agentic task                                           | 0–1   |

> [!todo] Source needed — link to Confident AI technical reports or paper once ingested.

## Dataset / Test collection
DeepEval does not ship a fixed benchmark corpus. Evaluations are run on user-provided `LLMTestCase` objects (question, actual output, optional context and expected output). A `Synthesizer` class can generate synthetic datasets from a given document corpus, similar to [[RAGAS]]'s test-set generator.

## How to run
```bash
pip install deepeval

# optional: log results to Confident AI cloud dashboard
deepeval login
```

```python
from deepeval import evaluate
from deepeval.test_case import LLMTestCase
from deepeval.metrics import FaithfulnessMetric, AnswerRelevancyMetric, ContextualPrecisionMetric

test_case = LLMTestCase(
    input="What is RAG?",
    actual_output="RAG combines retrieval with generation.",
    expected_output="RAG retrieves relevant documents before generating an answer.",
    retrieval_context=["RAG stands for Retrieval-Augmented Generation..."],
)

evaluate(
    [test_case],
    metrics=[
        FaithfulnessMetric(threshold=0.7),
        AnswerRelevancyMetric(threshold=0.7),
        ContextualPrecisionMetric(threshold=0.7),
    ],
)
```

```bash
# run as pytest suite
deepeval test run test_rag.py
```

## Reported baselines
No canonical leaderboard; scores are system- and domain-specific. Confident AI's cloud platform aggregates anonymised benchmark distributions across users for informal comparison.

## Limitations / caveats
- LLM-as-judge dependency: results vary significantly with judge model choice; GPT-4o or Claude 3.5+ recommended for consistent scoring.
- `Contextual Recall` and `Summarization` require a reference (`expected_output`), reintroducing annotation cost.
- Agent metrics (Tool Correctness, Task Completion) require structured trace data from the agent framework.
- Cloud dashboard features (regression tracking, A/B testing) require a Confident AI account.
- No fixed held-out test set — makes cross-paper comparisons harder than dataset-centric benchmarks like [[BEIR]].

## Related tools / benchmarks
- [[RAGAS]] — similar reference-free RAG eval framework; DeepEval can wrap RAGAS metrics natively
- [[TruLens]] — overlapping RAG Triad metrics; different SDK and dashboard
- [[ARES]]
- [[BEIR]] — fixed-corpus retrieval benchmark (dataset, not a framework)

## Sources
> [!todo] Source needed — add primary citation once a DeepEval paper or technical report is ingested.
