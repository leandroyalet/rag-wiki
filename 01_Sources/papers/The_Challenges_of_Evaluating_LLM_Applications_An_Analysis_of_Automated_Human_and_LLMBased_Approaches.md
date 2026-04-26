---
title: "The Challenges of Evaluating LLM Applications: An Analysis of Automated, Human, and LLM-Based Approaches"
authors: "Bhashithe Abeysinghe, Ruhan Circi"
citekey: abeysinghe2024llmeval
aliases: [abeysinghe2024llmeval]
year: 2024
venue: "ArXiv"
url: "https://arxiv.org/abs/2406.03339"
tags: [paper, arxiv, evaluation, llm-as-judge]
status: summarized
added_by: Pablo
---

# LLM Evaluation Challenges

## Summary
Introduces a **factored evaluation mechanism** for LLM chatbot applications and compares automated, human, and LLM-based evaluation approaches on an educational RAG chatbot (EdTalk).

**Factored evaluation — 5 dimensions (5-point Likert):**
| Factor | What it measures |
|--------|-----------------|
| **Relevance** | Whether presented facts answer the question |
| **Informativeness** | Whether all required facts are included |
| **Correctness** | Accuracy of information |
| **Clarity** | Appropriate formatting and conciseness |
| **Hallucinations** | Presence of fabricated content |

Questions also categorised by **Bloom's Taxonomy** (Remember → Evaluate), revealing that RAG systems underperform on basic "Remember" questions despite theoretical strength there.

**Key findings:**
- **Low inter-annotator agreement** — Krippendorff's α: 0.12–0.52; only "Clarity" shows moderate agreement.
- **LLM evaluators inflate scores** — tend to rate outputs higher than human annotators, especially on correctness.
- **Minimal correlation** across automated (BLEURT), human, and LLM evaluation approaches.
- **No single best method** — each approach has trade-offs between cost, repeatability, and reliability.
- Human evaluation remains the gold standard for critical applications where direct retrieval is not the sole goal.
- Factor-based evaluation provides more actionable diagnostic insights than holistic single-score approaches.

## Abstract
Discusses the issue of evaluating chatbot responses with LLM-based evaluations and how they correlate with human evaluations. Introduces a comprehensive factored evaluation mechanism used in conjunction with both human and LLM-based evaluations. Results show that factor-based evaluation produces better insights on which aspects need improvement, and strengthens the argument to use human evaluation in critical spaces where main functionality is not direct retrieval.

# The Challenges of Evaluating LLM Applications: An Analysis of Automated, Human, and LLM-Based Approaches

## Resumen
Chatbots have been an interesting application of natural language generation since its inception. With novel transformer based Generative AI methods, building chatbots have become trivial. Chatbots which are targeted at specific domains for example medicine and psychology are implemented rapidly. This however, should not distract from the need to evaluate the chatbot responses. Especially because the natural language generation community does not entirely agree upon how to effectively evaluate such applications. With this work we discuss the issue further with the increasingly popular LLM based evaluations and how they correlate with human evaluations. Additionally, we introduce a comprehensive factored evaluation mechanism that can be utilized in conjunction with both human and LLM-based evaluations. We present the results of an experimental evaluation conducted using this scheme in one of our chatbot implementations which consumed educational reports, and subsequently compare automated, traditional human evaluation, factored human evaluation, and factored LLM evaluation. Results show that factor based evaluation produces better insights on which aspects need to be improved in LLM applications and further strengthens the argument to use human evaluation in critical spaces where main functionality is not direct retrieval.
