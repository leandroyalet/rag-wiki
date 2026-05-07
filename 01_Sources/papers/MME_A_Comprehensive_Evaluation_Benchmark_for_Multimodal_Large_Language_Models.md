---
title: "MME: A Comprehensive Evaluation Benchmark for Multimodal Large Language Models"
authors: "Chaoyou Fu, Peixian Chen, Yunhang Shen, Yulei Qin, Mengdan Zhang, Xu Lin, Jinrui Yang, Xiawu Zheng, Ke Li, Xing Sun, Yunsheng Wu, Rongrong Ji, Caifeng Shan, Ran He"
citekey: fu2023mme
aliases: [fu2023mme]
year: 2023
venue: "ArXiv"
url: "https://arxiv.org/abs/2306.13394"
tags: [paper, arxiv, benchmark, multimodal, evaluation]
status: summarized
added_by: Pablo
---

# MME — Multimodal LLM Evaluation Benchmark

## Summary
The first comprehensive benchmark for Multimodal LLMs (MLLMs) covering **14 subtasks** across perception and cognition. All instruction-answer pairs are manually annotated to prevent data leakage.

**14 subtasks:**

| Category | Subtasks |
|----------|---------|
| **Perception — coarse** | Existence, Count, Position, Color |
| **Perception — fine-grained** | Movie Posters, Celebrities, Scenes, Landmarks, Artworks |
| **Perception — text** | OCR |
| **Cognition** | Commonsense Reasoning, Numerical Calculation, Text Translation, Code Reasoning |

**Scoring:** ACC (individual question accuracy) + ACC+ (both yes/no questions correct per image). Max: 2000 (perception) + 800 (cognition).

**Models evaluated:** 30 MLLMs including GPT-4V, LLaVA, Qwen-VL-Chat.

**Key findings — four critical MLLM failure modes:**
1. Failure to follow basic instructions despite concise prompts.
2. Inadequate perception — especially position recognition.
3. Broken reasoning chains in multi-step tasks.
4. **Object hallucination** — inventing image details that are absent.

**RAG relevance:** Object hallucination maps directly to the faithfulness problem in RAG. MME provides a structured way to measure grounding failures in multimodal pipelines. Relevant for visual RAG evaluation alongside [[IRPAPERS]].

# MME: A Comprehensive Evaluation Benchmark for Multimodal Large Language Models

## Resumen
Multimodal Large Language Model (MLLM) relies on the powerful LLM to perform multimodal tasks, showing amazing emergent abilities in recent studies, such as writing poems based on an image. However, it is difficult for these case studies to fully reflect the performance of MLLM, lacking a comprehensive evaluation. In this paper, we fill in this blank, presenting the first comprehensive MLLM Evaluation benchmark MME. It measures both perception and cognition abilities on a total of 14 subtasks. In order to avoid data leakage that may arise from direct use of public datasets for evaluation, the annotations of instruction-answer pairs are all manually designed. The concise instruction design allows us to fairly compare MLLMs, instead of struggling in prompt engineering. Besides, with such an instruction, we can also easily carry out quantitative statistics. A total of 30 advanced MLLMs are comprehensively evaluated on our MME, which not only suggests that existing MLLMs still have a large room for improvement, but also reveals the potential directions for the subsequent model optimization. The data are released at the project page https://github.com/BradyFU/Awesome-Multimodal-Large-Language-Models/tree/Evaluation.
