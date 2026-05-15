---
type: benchmark
aliases: [GroUSE, Grounded QA Unitary Scoring of Evaluators]
tags: [rag, evaluation, benchmark, llm-as-judge, meta-evaluation]
status: stub
created: 2026-05-15
updated: 2026-05-15
sources: ["[[muller2025grouse]]"]
introduced_by: Muller et al. (Illuin Technology)
year: 2025
---

# GroUSE

> **TL;DR** A meta-evaluation benchmark of 144 hand-crafted unit tests that measures whether an LLM judge correctly detects all 7 grounded-QA failure modes — revealing that RAGAS and DeepEval fail many edge cases despite high GPT-4 correlation.

## Context
Automated evaluation of RAG systems (e.g., [[RAGAS]], [[DeepEval]]) relies on [[LLM-as-Judge]]. A common validation approach is to measure correlation with GPT-4 judgements on held-out samples. GroUSE challenges whether correlation is a sufficient proxy: a judge can correlate well globally while still failing specific failure modes that matter in production. [[muller2025grouse]]

## How it works
GroUSE tests a judge on 144 units structured as **9 sets × 16 test types**:
- Each set shares the same question but varies the references and answer to cover 16 defined scenarios.
- An additional set of 16 tests is provided as a "training set" for prompt engineering.
- A test passes if the judge assigns scores within an expected acceptable range for every applicable metric.

The 16 test types cover combinations of: answerable vs. adversarial references × correct/incorrect/incomplete/irrelevant answers × citation presence/absence. [[muller2025grouse]]

## The 7 generator failure modes
| ID | Failure mode |
|----|-------------|
| **FM1** | Irrelevant information included in the answer (even when question is answerable) |
| **FM2** | Failure to refrain from answering when question is unanswerable |
| **FM3** | Relevant information missing from the answer |
| **FM4** | Wrongly claims the question cannot be answered |
| **FM5** | Correct abstention but includes unrelated additional information |
| **FM6** | Missing or incorrect citation for a reported fact |
| **FM7** | Distorted or unsupported claim |

[[muller2025grouse]]

## The 6 evaluation criteria
| Criterion | Measures | Scale | Failure modes |
|-----------|----------|-------|--------------|
| **Answer Relevancy** | Relevance of content to the question | 1–5 Likert | FM1 |
| **Completeness** | All relevant info from documents present | 1–5 Likert | FM3 |
| **Faithfulness** | All facts accurate and correctly cited | Binary | FM6, FM7 |
| **Usefulness** | In adversarial cases, related info is useful | Binary | FM5 |
| **Positive Acceptance** | Correctly responds when answerable | Binary | FM4 |
| **Negative Rejection** | Correctly refrains when unanswerable | Binary | FM2 |

[[muller2025grouse]]

## Key findings
- **RAGAS and DeepEval (with GPT-4 judge) fail multiple unit test types**, particularly on adversarial cases, citation accuracy (FM6), and edge-case relevancy — despite their overall good performance in aggregate correlation studies. [[muller2025grouse]]
- **Same metric, different prompts → very different results**: RAGAS and DeepEval implement faithfulness similarly in principle but yield significantly different GroUSE scores, revealing high prompt sensitivity. [[muller2025grouse]]
- **Closed-source judges (GPT-4) outperform open-source judges** on GroUSE even when those open-source models show strong GPT-4 correlation scores, confirming that global correlation understates calibration failures. [[muller2025grouse]]
- **Fine-tuning Llama-3 on GPT-4 reasoning traces** significantly improves both calibration on GroUSE and correlation with GPT-4 — the best open-source approach identified. [[muller2025grouse]]

## Design choices / limitations
- Tests are manually curated from Wikipedia excerpts across diverse domains (history, science, zoology, cinematography, medicine) — 144 items is small; targeted at edge-case discrimination, not statistical benchmarking.
- Focused on the **generation step only** (grounded QA), not retrieval quality.
- Does not evaluate multi-document reasoning or multi-turn dialogues.

## Datasets
Wikipedia excerpts. Code and data: https://github.com/illuin-tech/grouse

## Related pages
- [[LLM-as-Judge]] — GroUSE evaluates judges.
- [[RAGAS]] — one of the frameworks evaluated (found to miss edge cases).
- [[DeepEval]] — one of the frameworks evaluated (found to miss edge cases).
- [[RAG Failure Points]] — complementary taxonomy of RAG pipeline failures (barnett2024failures).
- [[Faithfulness]] — one of the six criteria evaluated.
- [[Answer Relevance]] — one of the six criteria evaluated.

## Sources
- [[muller2025grouse]]
