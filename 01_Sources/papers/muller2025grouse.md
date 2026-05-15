---
type: paper
citekey: muller2025grouse
title: "GroUSE: A Benchmark to Evaluate Evaluators in Grounded Question Answering"
authors: [Sacha Muller, António Loison, Bilel Omrani, Gautier Viaud]
year: 2025
venue: arXiv (submitted Sep 2024, v3 Jan 2025)
url: https://arxiv.org/abs/2409.06595
pdf: "[[2409.06595v3.pdf]]"
tags: [paper, rag, evaluation, llm-as-judge, benchmark]
status: summarized
added: 2026-05-15
added_by: Claude Code (/ingest)
---

# muller2025grouse — GroUSE: A Benchmark to Evaluate Evaluators in Grounded Question Answering

## Summary
Meta-evaluation benchmark for LLM-as-Judge systems applied to grounded question answering (the generation step of RAG). Identifies 7 generator failure modes, proposes 6 evaluation criteria, and introduces **GroUSE** — 144 hand-crafted unit tests across 16 test types. Shows that RAGAS and DeepEval fail on many edge cases despite high GPT-4 correlation; proposes a novel evaluation pipeline and shows that Llama-3 fine-tuned on GPT-4 reasoning traces outperforms open-source judges.

## Key claims
1. Correlation with GPT-4 is an **insufficient proxy** for judge quality — open-source judges that correlate well with GPT-4 globally can still fail specific edge cases in a way that GPT-4 would not.
2. RAGAS and DeepEval (with GPT-4) fail many GroUSE unit tests, especially on failure modes involving adversarial cases and citation accuracy.
3. Different implementations of the same metric (faithfulness in RAGAS vs. DeepEval) yield very different results on the same test cases, revealing high prompt sensitivity.
4. Fine-tuning Llama-3 on GPT-4's evaluation reasoning traces significantly boosts calibration, outperforming both correlation-based fine-tuned judges and general RAGAS/DeepEval implementations.
5. 16 unit test types covering all combinations of: answerable/adversarial references × complete/partial/missing/irrelevant answers × citation correctness.

## 7 generator failure modes (FM1–FM7)
| ID | Failure mode |
|----|-------------|
| FM1 | Irrelevant information included in the answer |
| FM2 | Failure to refrain from answering when question is unanswerable |
| FM3 | Relevant information missing from the answer |
| FM4 | Wrongly claims the question cannot be answered |
| FM5 | Correct abstention but unrelated additional information included |
| FM6 | Missing or incorrect citation for a reported fact |
| FM7 | Distorted or unsupported claim |

## 6 evaluation criteria
| Criterion | Measures | Scale |
|-----------|----------|-------|
| Answer Relevancy | Relevance of answer content to the question | 1–5 Likert |
| Completeness | All relevant info from documents present | 1–5 Likert |
| Faithfulness | All facts accurate and correctly cited | Binary |
| Usefulness | In adversarial cases, related info is useful | Binary |
| Positive Acceptance | Correctly responds when question is answerable | Binary |
| Negative Rejection | Correctly refrains when question is unanswerable | Binary |

## GroUSE benchmark
144 unit tests, 9 sets × 16 test types. Each set shares a question; references and answers vary to cover all 16 test types. Themes: history, science, zoology, cinematography, medicine. Available at https://github.com/illuin-tech/grouse

## Connections
- Extends [[LLM-as-Judge]] theory with calibration/discrimination evaluation.
- Directly critiques [[RAGAS]] and [[DeepEval]] implementations.
- Failure modes complement the [[RAG Failure Points]] taxonomy from [[barnett2024failures]].
