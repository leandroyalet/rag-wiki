---
type: paper
citekey: chen2024densex
title: "Dense X Retrieval: What Retrieval Granularity Should We Use?"
authors: [Tong Chen, Hongwei Wang, Sihao Chen, Wenhao Yu, Kaixin Ma, Xinran Zhao, Hongming Zhang, Dong Yu]
year: 2024
venue: EMNLP 2024
url: https://arxiv.org/abs/2312.06648
pdf: "[[2312.06648v3.pdf]]"
tags: [paper, rag, retrieval, chunking, dense-retrieval]
status: summarized
added: 2026-05-15
added_by: Claude Code (/ingest)
---

# chen2024densex — Dense X Retrieval: What Retrieval Granularity Should We Use?

## Summary
Systematic study of how the granularity of a retrieval corpus (passage, sentence, proposition) impacts both passage retrieval recall and downstream QA accuracy. Proposes **proposition** — an atomic, self-contained, single-fact text unit — as a superior retrieval unit for dense retrieval. Introduces FACTOIDWIKI and the Propositionizer.

## Key claims
- Retrieval granularity is an overlooked yet impactful design choice. Indexing by propositions vs. passages improves average Recall@5 by +12.0 (SimCSE) and +9.3 (Contriever) across 5 QA datasets.
- Proposition retrieval improves unsupervised retriever cross-task generalization, especially for long-tailed entity queries (where entity frequency is low in the training corpus).
- With a fixed token budget, proposition-level context in prompts achieves higher QA EM scores than passage-level context (e.g., +4.1 EM@500 for SimCSE with LLaMA-2-7B).
- Supervised retrievers trained on passage-level data show smaller gains — they already overfit to passage granularity.
- Proposition-based retrieval struggles with multi-hop questions requiring reasoning over multiple passages.

## Three principles of a proposition
1. **Distinct meaning**: each encapsulates exactly one factoid.
2. **Minimal**: cannot be further split.
3. **Self-contained**: includes all necessary coreference context so it is interpretable alone.

## FACTOIDWIKI
English Wikipedia dump (Oct 2021) segmented into: 41M passages (avg 58.5 words), 114M sentences (avg 21.0 words), 257M propositions (avg 11.2 words).

## Propositionizer
Flan-T5-Large model fine-tuned via 2-step distillation: GPT-4 generates 42k seed passage→proposition pairs; Flan-T5-Large is fine-tuned on this seed set. Achieves F1 = 0.822 on a dev set of GPT-4-generated propositions.

## Experimental setup
Five OD-QA datasets: NQ, TriviaQA, WebQ, SQuAD, EntityQuestions. Four dense retrievers: SimCSE (unsupervised), Contriever (unsupervised), DPR (supervised), GTR (supervised). QA reader: Fusion-in-Decoder (T5-large) and LLaMA-2-7B.

## Connections
- Related to [[zhou2026chunktaxonomy]] which evaluates proposition-based chunking in a broader context (finds it underperforms for in-corpus retrieval but gains with Late Chunking).
- The Propositionizer is the key "LLM-guided" chunker described in [[Chunking]] taxonomy.
- FACTOIDWIKI used for index → [[FAISS]] or pyserini.
