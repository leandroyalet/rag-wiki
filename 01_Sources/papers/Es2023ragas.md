---
type: paper
citekey: Es2023ragas
title: "RAGAS: Automated Evaluation of Retrieval Augmented Generation"
authors: [Shahul Es, Jithin James, Luis Espinosa-Anke, Steven Schockaert]
year: 2023
venue: arXiv
url: https://arxiv.org/abs/2309.15217
pdf: ""
tags: [paper, rag, evaluation, reference-free]
status: summarized
added: 2026-04-21
added_by: Claude Code
---

# Es2023ragas — Literature Note

## Summary
RAGAS is a reference-free evaluation framework for RAG pipelines. It decomposes quality into three independent axes — retrieval quality, faithfulness, and answer relevance — and measures each using an LLM judge, requiring no human-annotated ground truth.

## Key contributions
- **Reference-free**: no ground-truth answers needed for Faithfulness and Answer Relevance.
- **Three core metrics** each targeting a different failure mode (retrieval, grounding, generation).
- Achieves 0.95 accuracy vs human annotators on Faithfulness, outperforming GPT Score (0.72).
- API-compatible: works with closed models that don't expose token probabilities.
- Ships with integrations for LlamaIndex and LangChain.

## Metrics — mechanics

### Faithfulness (F = |V| / |S|)
1. LLM decomposes the answer into atomic statements S.
2. Each statement is verified against the retrieved context (can it be inferred?).
3. Score = supported statements |V| / total statements |S|.

### Answer Relevance (AR = (1/n) Σ sim(q, qᵢ))
1. LLM generates n reverse-questions from the answer.
2. Each generated question is embedded (text-embedding-ada-002).
3. Cosine similarity against the original query is averaged.

### Context Relevance (CR = extracted / total)
1. LLM extracts sentences from the context that are "crucial to answering the question".
2. Score = extracted sentences / total context sentences.
- Noted as "the hardest quality dimension to evaluate," especially with long contexts.

## Experiments
| Metric | RAGAS | GPT Score | GPT Ranking |
|--------|-------|-----------|-------------|
| Faithfulness | **0.95** | 0.72 | 0.54 |
| Answer Relevance | **0.78** | 0.52 | 0.40 |
| Context Relevance | **0.70** | 0.63 | 0.52 |
(Accuracy vs pairwise human annotations — Table 1)

## Limitations
- LLM judge quality varies: GPT-4-class judges yield more stable scores.
- Context Recall and Answer Correctness (extended metrics) require a reference answer.
- Synthetic test-set generation may not match real user distributions.

## Related wiki pages
- [[RAGAS]] (tool page)
- [[Faithfulness]]
- [[Answer Relevance]]
- [[Context Relevance]]
