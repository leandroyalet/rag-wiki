---
type: tool
aliases: [Retrieval Augmented Generation Assessment]
tags:
  - rag
  - eval
  - benchmark
status: stub
created: 2026-04-18
updated: 2026-04-21
sources: ["[[Es2023ragas]]"]
homepage: https://ragas.io
repo: https://github.com/explodinggradients/ragas
docs: https://docs.ragas.io
year: 2023
---

# RAGAS

> **TL;DR** Reference-free evaluation framework that scores RAG pipelines across faithfulness, answer relevance, and context quality — no ground-truth labels required.

## What it measures
RAGAS evaluates the full RAG pipeline end-to-end, decomposing quality into independent axes so teams can diagnose retrieval vs. generation failures separately. It is designed to work without human-annotated labels by using an LLM judge.

## Metrics
| Metric | Description | Range |
|---|---|---|
| **Faithfulness** | `F = |V|/|S|` — LLM decomposes answer into atomic statements S; verifies each against context; score = supported / total [[Es2023ragas]] | 0–1 |
| **Answer Relevance** | `AR = (1/n)Σ sim(q,qᵢ)` — LLM generates n reverse-questions from the answer; cosine similarity to original query is averaged [[Es2023ragas]] | 0–1 |
| **Context Relevance** | LLM extracts sentences "crucial to answering the question"; score = extracted / total context sentences [[Es2023ragas]] | 0–1 |
| **Context Recall** | Fraction of ground-truth answer content covered by the retrieved context (requires reference answer) | 0–1 |
| **Context Entities Recall** | Entity-level recall between retrieved context and reference answer | 0–1 |
| **Answer Correctness** | Combined factual and semantic similarity between generated and reference answer (requires reference) | 0–1 |
| **Answer Similarity** | Semantic similarity (embedding cosine) between generated and reference answer | 0–1 |

Accuracy vs human annotators (pairwise, Table 1 [[Es2023ragas]]): Faithfulness **0.95**, Answer Relevance **0.78**, Context Relevance **0.70** — consistently outperforms GPT Score and GPT Ranking baselines.

## Dataset / Test collection
RAGAS ships with `ragas.testset.generate` — a synthetic test-set generator that takes a corpus and uses an LLM to produce `(question, context, ground_truth)` triples. It can also accept any externally prepared dataset in Hugging Face `datasets` format.

## How to run
```bash
pip install ragas

python - <<'EOF'
from datasets import Dataset
from ragas import evaluate
from ragas.metrics import faithfulness, answer_relevancy, context_precision

data = Dataset.from_dict({
    "question": ["What is RAG?"],
    "answer": ["RAG combines retrieval with generation."],
    "contexts": [["RAG stands for Retrieval-Augmented Generation..."]],
    "ground_truth": ["RAG is a method that retrieves relevant documents before generating an answer."],
})

result = evaluate(data, metrics=[faithfulness, answer_relevancy, context_precision])
print(result)
EOF
```

## Reported baselines
Scores depend heavily on the LLM judge. GPT-4-class judges give more stable results. RAGAS works with closed-model APIs (no logprob access required) [[Es2023ragas]].

## Limitations / caveats
- LLM-as-judge: scores depend on the judge model; GPT-4-class models give more stable results than smaller judges.
- Faithfulness and Answer Relevance are reference-free but can still be gamed by verbose, hedge-heavy answers.
- Context Recall and Answer Correctness require a reference answer, reintroducing annotation cost.
- Synthetic test-set generation may not reflect real user query distributions.

## Related tools / benchmarks
- [[DeepEval]] — similar LLM-as-judge eval framework; can wrap RAGAS metrics natively
- [[TruLens]] — overlapping RAG Triad metrics (Context Relevance, Groundedness, Answer Relevance)
- [[ARES]]
- [[BEIR]] — fixed-corpus retrieval benchmark (dataset, not a framework)

## Sources
- [[Es2023ragas]] — *RAGAS: Automated Evaluation of Retrieval Augmented Generation* (Es et al., 2023)
