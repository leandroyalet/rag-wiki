---
title: "A Closer Look into Automatic Evaluation Using Large Language Models"
authors: "Cheng-Han Chiang, Hung-yi Lee"
citekey: chiang2023llmeval
aliases: [chiang2023llmeval]
year: 2023
venue: "ArXiv"
url: "https://arxiv.org/abs/2310.05657"
tags: [paper, arxiv, evaluation, llm-as-judge]
status: summarized
added_by: Pablo
---

# A Closer Look into Automatic Evaluation Using Large Language Models

## Summary
Compares two LLM-as-judge frameworks — **LLM Eval** (Chiang & Lee) and **G-Eval** (Liu et al. 2023, GPT-4-based) — and analyses what design choices drive alignment with human ratings.

**Key findings:**
1. **Auto-CoT is not reliably helpful** — G-Eval's LLM-generated evaluation steps improve human correlation on SummEval for some attributes (coherence, consistency, relevance) but significantly *hurt* fluency; effects on Topical-Chat are mostly negligible or negative.
2. **Numeric-only output is suboptimal** — restricting the model to output only a score ("(score only):") degrades alignment vs. allowing free-form text. ChatGPT still mostly outputs numbers when allowed to respond freely, but the internal generation strategy changes.
3. **Explain-then-rate consistently helps** — asking the LLM to explain its reasoning before assigning a score *always* improves human correlation, pushing SoTA on both benchmark datasets. On Topical-Chat groundedness: correlation 0.725 (analyze-rate) vs. 0.311 (auto-CoT + score-only) — a gain of +0.414.

**Datasets:** SummEval (100 source docs × 16 summaries, 4 attributes) and Topical-Chat (360 dialogue–response pairs, 4 attributes).

## Abstract
Using large language models (LLMs) to evaluate text quality has recently gained popularity. Some prior works explore the idea of using LLMs for evaluation, while they differ in some details of the evaluation process. In this paper, we analyze LLM evaluation (Chiang and Lee, 2023) and G-Eval (Liu et al., 2023), and we discuss how those details in the evaluation process change how well the ratings given by LLMs correlate with human ratings. We find that the auto Chain-of-Thought (CoT) used in G-Eval does not always make G-Eval more aligned with human ratings. We also show that forcing the LLM to output only a numeric rating, as in G-Eval, is suboptimal. Last, we reveal that asking the LLM to explain its own ratings consistently improves the correlation between the ChatGPT and human ratings and pushes state-of-the-art (SoTA) correlations on two meta-evaluation datasets.
