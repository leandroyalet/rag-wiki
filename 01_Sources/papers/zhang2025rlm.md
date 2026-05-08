---
type: paper
citekey: zhang2025rlm
title: "Recursive Language Models"
authors: [Alex L. Zhang, Tim Kraska, Omar Khattab]
year: 2025
venue: arXiv
url: https://arxiv.org/abs/2512.24601
pdf: "[[2512.24601v2.pdf]]"
tags: [paper, long-context, inference, language-models]
status: summarized
added: 2026-05-08
added_by: Claude Code
---

> **Summary** Recursive Language Models (RLMs) let an LLM handle arbitrarily long prompts by programmatically decomposing, examining, and recursively calling itself over prompt snippets — processing inputs up to 100× beyond native context windows. Post-trained RLM-Qwen3-8B shows 28.3% average improvement over its base and approaches GPT-5 quality on long-context benchmarks, at comparable inference cost to standard long-context methods. Conceptually an **alternative to RAG and CAG** for the long-document problem: instead of retrieving relevant chunks (RAG) or compressing a knowledge snapshot (CAG), RLMs recurse internally over the full input. No external index required; limitation is that all content must be available at inference time. Note added in [[02_Wiki/concepts/Cache-Augmented Generation]] under alternatives.
