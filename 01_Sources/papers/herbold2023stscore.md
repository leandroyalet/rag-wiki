---
type: paper
citekey: herbold2023stscore
title: "Semantic similarity prediction is better than other semantic similarity measures"
authors: [Steffen Herbold]
year: 2023
venue: TMLR (Transactions on Machine Learning Research)
url: https://arxiv.org/abs/2309.12697
pdf: "[[2309.12697v2.pdf]]"
tags: [paper, embeddings, evaluation, semantic-similarity]
status: summarized
added: 2026-05-08
added_by: Claude Code
---

> **Summary** Proposes STSScore — a model fine-tuned directly on STS-B (GLUE) for predicting semantic similarity scores — and shows it outperforms overlap-based (BLEU) and embedding-based (BERTScore, S-BERT cosine similarity) measures on robustness criteria. Key claim: direct similarity *prediction* from a fine-tuned cross-encoder is more reliable than cosine distance between bi-encoder embeddings. Relevant to [[02_Wiki/concepts/Embeddings]] and [[02_Wiki/benchmarks/MTEB]] (STS task). No new wiki pages created — content added as a note on embedding evaluation limitations.
