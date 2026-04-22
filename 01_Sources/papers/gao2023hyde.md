---
type: paper
citekey: gao2023hyde
title: "Precise Zero-Shot Dense Retrieval without Relevance Labels"
authors: [Luyu Gao, Xueguang Ma, Jimmy Lin, Jamie Callan]
year: 2022
venue: arXiv
url: https://arxiv.org/abs/2212.10496
pdf: ""
tags: [paper, rag, retrieval, zero-shot, query-expansion]
status: summarized
added: 2026-04-21
added_by: Claude Code
---

# gao2023hyde — Literature Note

## Summary
HyDE (Hypothetical Document Embeddings) eliminates the query–document embedding gap by generating a *hypothetical* answer document via an instruction-following LLM, then encoding that document with an unsupervised dense encoder. Retrieval accuracy rivals supervised fine-tuned models with zero labelled training data.

## Key contributions
- Bridges the query–document gap without any relevance labels.
- Combining InstructGPT (generation) + Contriever (unsupervised encoder) is sufficient for competitive retrieval.
- Shown to work multilingually (Swahili, Korean, Japanese) — the LLM generates in-language hypotheticals.
- Competitive with or surpassing fine-tuned DPR on BEIR and TREC benchmarks.

## Pipeline
1. Query `q` → InstructGPT → hypothetical document `d_hyp` (may contain factual errors, that's fine).
2. `d_hyp` → Contriever encoder → embedding `e_hyp`.
3. `e_hyp` used for nearest-neighbour search over corpus.
4. Retrieved **real** documents fed to the final LLM answer generator.

## Evaluation
- **BEIR**: significant NDCG@10 improvements over BM25 and unsupervised Contriever across 16 diverse datasets including SCIFACT, TREC-COVID, NFCorpus.
- **TREC**: TREC-COVID, TREC-NEWS, TREC-ROBUST04 — gains over both BM25 and supervised baselines.
- **Ablations**: GPT-3.5-class models outperform smaller instruction followers; weaker LLMs degrade hypothesis quality and hurt retrieval.

## Limitations
- Requires an instruction-following LLM → adds latency and cost per query.
- If the LLM generates out-of-distribution hypotheticals, retrieval can be harmed.
- Dense encoder must be a general contrastive model (Contriever); task-specific fine-tuned encoders may not generalise as well to hypothetical documents.

## Related wiki pages
- [[HyDE]] (method page)
- [[Dense Retrieval]]
- [[Query Expansion]]
- [[BEIR]]
