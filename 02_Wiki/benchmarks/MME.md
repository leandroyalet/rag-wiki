---
type: benchmark
aliases: [MME benchmark, Multimodal LLM Evaluation]
tags: [benchmark, multimodal, evaluation, vision-language]
status: stub
created: 2026-05-07
updated: 2026-05-07
sources: ["[[fu2023mme]]"]
homepage: https://github.com/BradyFU/Awesome-Multimodal-Large-Language-Models/tree/Evaluation
year: 2023
---

# MME

> **TL;DR** The first comprehensive evaluation benchmark for Multimodal LLMs — 14 subtasks across perception and cognition, manually annotated to prevent data leakage, with a binary yes/no instruction format that enables clean quantitative comparison.

## What it measures
MME (Multimodal Large Language Model Evaluation) assesses both **perception** and **cognition** abilities of MLLMs using a unified binary instruction format ("Is there a cat in this image? Please answer yes or no."). Manual annotation prevents contamination from training data in public datasets. [[fu2023mme]]

## Subtasks

| Category | Subtask |
|----------|---------|
| **Perception — coarse-grained** | Existence, Count, Position, Color |
| **Perception — fine-grained** | Movie Posters, Celebrities, Scenes, Landmarks, Artworks |
| **Perception — text** | OCR |
| **Cognition** | Commonsense Reasoning, Numerical Calculation, Text Translation, Code Reasoning |

[[fu2023mme]]

## Scoring
- **ACC** — accuracy over individual yes/no questions.
- **ACC+** — stricter: both questions for an image must be correct. Prevents models gaming single-question accuracy.
- Max score: **2000** (perception) + **800** (cognition) = 2800 total. Each subtask caps at 200 points.

[[fu2023mme]]

## Models evaluated
30 MLLMs including GPT-4V, LLaVA, Qwen-VL-Chat, and others. [[fu2023mme]]

## Key findings — four critical MLLM failure modes
1. **Instruction non-compliance** — models fail to follow concise binary instructions despite the straightforward format.
2. **Weak spatial perception** — position recognition is consistently the hardest perception subtask.
3. **Broken reasoning chains** — multi-step cognitive tasks show reasoning degradation mid-chain.
4. **Object hallucination** — models invent visual details absent from the image; directly analogous to [[Faithfulness]] failures in text RAG. [[fu2023mme]]

## Relevance to RAG
- **Multimodal RAG evaluation**: MME provides a structured way to benchmark the perception and reasoning capabilities that multimodal RAG pipelines depend on. A retriever returning images is only as useful as the generator's ability to faithfully ground its answer in the retrieved visual content.
- **Object hallucination ↔ Faithfulness**: the hallucination problem in MLLMs mirrors the faithfulness failure mode in text RAG (FP4 in [[RAG Failure Points]]). MME's ACC+ metric penalises inconsistency similarly to how [[RAGAS]] Faithfulness penalises unsupported claims.
- Compare with [[IRPAPERS]] — which tests IR-focused multimodal retrieval — and [[MTEB]] — which benchmarks text embedding models.

## Related pages
- [[IRPAPERS]]
- [[MTEB]]
- [[Faithfulness]]
- [[Hallucination in RAG]]
- [[RAG Failure Points]]

## Sources
- [[fu2023mme]]
