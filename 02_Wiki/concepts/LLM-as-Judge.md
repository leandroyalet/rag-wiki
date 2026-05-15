---
type: concept
aliases: [LLM judge, LLM evaluation, G-Eval, LLM-as-evaluator]
tags: [rag, evaluation, llm]
status: stub
created: 2026-04-26
updated: 2026-05-15
sources: ["[[chiang2023llmeval]]", "[[abeysinghe2024llmeval]]", "[[muller2025grouse]]"]
---

# LLM-as-Judge

> **TL;DR** Using a large language model (typically GPT-4 or similar) as an automatic evaluator that assigns quality scores to generated text — a scalable proxy for expensive human annotation.

## Definition
LLM-as-Judge is the practice of prompting a capable LLM to rate the quality of another model's output on dimensions such as coherence, faithfulness, relevance, or groundedness. Scores are compared against human ratings using rank correlation (Spearman/Pearson) to validate the approach. [[chiang2023llmeval]]

## Context
Human evaluation is the gold standard for NLG quality but is slow and expensive. Rule-based metrics (BLEU, ROUGE) correlate poorly with human judgement for open-ended generation. LLM-as-Judge emerged as a middle path: fast, cheap, and scalable, yet closer to human judgement than surface metrics. It is now the dominant approach in RAG evaluation frameworks such as [[RAGAS]], [[DeepEval]], [[TruLens]], and [[ARES]].

## How it works

### Common implementations
| Framework | What the LLM judges | Output format |
|-----------|--------------------|-|
| **G-Eval** (Liu et al. 2023) | Generates evaluation criteria via auto-CoT, then scores | Numeric only |
| **LLM Eval** (Chiang & Lee 2023) | Human-written criteria, free-form response allowed | Free-form + numeric |
| **RAGAS** | Faithfulness, Answer Relevance, Context Relevance | 0–1 score per metric |
| **ARES** | Context Relevance, Answer Faithfulness, Answer Relevance | Score + PPI calibration |

### Key design choices and their effects
[[chiang2023llmeval]] compared G-Eval and LLM Eval and found:

1. **Auto-CoT is not reliably helpful** — LLM-generated evaluation steps improve human alignment on some attributes (coherence, consistency) but *hurt* others (fluency) and are negligible on dialogue tasks.
2. **Numeric-only output is suboptimal** — forcing the model to output only a score degrades alignment with human ratings. Allowing free-form response changes the internal generation strategy beneficially, even if the model mostly still outputs numbers.
3. **Explain-then-rate consistently improves alignment** — asking the LLM to explain its reasoning before assigning a score is the single most reliable improvement. On Topical-Chat groundedness: correlation **0.725** (analyze-rate) vs. **0.311** (auto-CoT + score-only), a gain of +0.414. [[chiang2023llmeval]]

## Variants
- **Reference-free** — judge scores the output directly, no ground-truth answer needed (used in RAGAS Answer Relevance).
- **Reference-based** — judge compares output to a gold standard (Answer Correctness).
- **Pairwise** — judge ranks two outputs head-to-head (common in RLHF evaluation, Chatbot Arena).
- **Chain-of-thought scoring** — judge explains reasoning step-by-step before giving a final score; see G-Eval.
- **Calibrated / PPI** — small human annotation set used to statistically calibrate LLM scores; see [[ARES]].

## Factored evaluation
Rather than a single holistic score, **factored evaluation** rates output across multiple explicit dimensions — providing more actionable diagnosis. [[abeysinghe2024llmeval]] proposes five factors on 5-point Likert scales:

| Factor | What it measures |
|--------|-----------------|
| **Relevance** | Whether facts presented answer the question |
| **Informativeness** | Whether all required facts are included |
| **Correctness** | Accuracy of information |
| **Clarity** | Appropriate formatting and conciseness |
| **Hallucinations** | Presence of fabricated content |

Categorising questions by **Bloom's Taxonomy** (Remember → Evaluate) reveals that RAG systems often underperform on basic "Remember" questions despite theoretical retrieval strength there. [[abeysinghe2024llmeval]]

## Trade-offs
- ✅ Scalable: evaluates thousands of examples at low cost.
- ✅ Flexible: applicable to any generation task with an appropriate prompt.
- ✅ Explain-then-rate achieves near-human correlation on well-defined attributes. [[chiang2023llmeval]]
- ✅ Factored evaluation surfaces *which* dimension is failing, not just that quality is low. [[abeysinghe2024llmeval]]
- ❌ **Positional bias** — judges tend to prefer the first option in pairwise comparisons.
- ❌ **Self-enhancement bias** — models rate their own outputs higher.
- ❌ **Verbosity bias** — longer outputs are often rated higher regardless of quality.
- ❌ **Score inflation** — LLM evaluators consistently rate outputs higher than human annotators, especially on correctness. [[abeysinghe2024llmeval]]
- ❌ **Low inter-annotator agreement** even among human raters (Krippendorff's α: 0.12–0.52; only "Clarity" reaches moderate agreement). [[abeysinghe2024llmeval]]
- ❌ Calibration varies across tasks: strong on coherence/faithfulness, weaker on fluency/groundedness. [[chiang2023llmeval]]

## Calibration vs. correlation

[[muller2025grouse]] introduces [[GroUSE]], a meta-evaluation benchmark of 144 unit tests that reveals a critical gap: **global correlation with GPT-4 is an insufficient proxy for judge quality**. A judge can correlate well with GPT-4 scores on aggregate while still failing to detect specific failure modes (irrelevant info, missing citations, wrong abstentions). Key findings:
- RAGAS and DeepEval (with GPT-4) fail multiple GroUSE unit tests, especially on adversarial cases and citation accuracy.
- Open-source judges that match GPT-4 correlation scores still fail GroUSE edge cases.
- Fine-tuning Llama-3 on GPT-4's **reasoning traces** (not just scores) significantly improves both calibration and correlation. [[muller2025grouse]]

The implication: judge selection should include unit-test evaluation on targeted failure modes, not just aggregate correlation metrics.

## State of the art (as of 2026-05)
Best practice from [[chiang2023llmeval]]: use **explain-then-rate** (ask the model to analyse the output, then assign a score) rather than score-only or auto-CoT prompts. This consistently pushes correlation with human ratings to SoTA on SummEval and Topical-Chat benchmarks.

## Related pages
- [[RAGAS]]
- [[DeepEval]]
- [[TruLens]]
- [[ARES]]
- [[GroUSE]]
- [[Answer Relevance]]
- [[Faithfulness]]
- [[Hallucination in RAG]]

## Sources
- [[chiang2023llmeval]]
- [[abeysinghe2024llmeval]]
- [[muller2025grouse]]
