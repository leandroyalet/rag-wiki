---
type: method
aliases: [DenseX, Dense X Retrieval, proposition-based retrieval, proposition retrieval, Propositionizer, FACTOIDWIKI]
tags: [rag, retrieval, chunking, dense-retrieval]
status: stub
created: 2026-05-15
updated: 2026-05-15
sources: ["[[chen2024densex]]"]
introduced_by: Chen et al. (UW / Tencent AI Lab / UPenn / CMU)
year: 2024
---

# DenseX (Proposition-Based Retrieval)

> **TL;DR** Index a corpus at the proposition level — atomic, self-contained single-fact sentences — instead of passages or sentences; dense retrievers then achieve higher recall and downstream QA accuracy without any fine-tuning.

## Problem it solves
Dense retrieval granularity is usually decided by how the model was trained (typically 100-word passages), not by what produces the best retrieval. Passages contain multiple facts and often irrelevant context that dilutes the query-document signal. Sentences are finer but still fail when they contain coreferences that make them non-self-contained. [[chen2024densex]]

## Key idea
Decompose every document into **propositions** — atomic expressions where each encapsulates exactly one factoid and all coreferences are resolved inline, making each unit independently interpretable. Index these propositions; at retrieval time they provide higher signal-to-noise per token. [[chen2024densex]]

## Definition: proposition
A proposition satisfies three principles:
1. **Distinct meaning** — corresponds to exactly one factoid; all propositions together reconstruct the full semantics.
2. **Minimal** — cannot be further split.
3. **Self-contained** — all coreference resolved (e.g., "the tower" → "the Leaning Tower of Pisa"). [[chen2024densex]]

## Pipeline

### Propositionizer
A Flan-T5-Large model trained via 2-step distillation:
1. GPT-4 generates 42k passage→proposition list pairs from Wikipedia.
2. Flan-T5-Large fine-tuned on this seed set (AdamW, lr=1e-4, 3 epochs).
Achieves proposition F1 = 0.822. [[chen2024densex]]

### FACTOIDWIKI
English Wikipedia (Oct 2021) decomposed into:
- 41M passages (avg 58.5 words)
- 114M sentences (avg 21.0 words)
- 257M propositions (avg 11.2 words)
Index: ~768 GB (FAISS IndexFlatIP), split into 8 shards. [[chen2024densex]]

### Retrieval scoring
For a query, retrieve top-k propositions; map each back to its source passage; return top-k unique source passages (avoids scoring artifacts from passage splits). [[chen2024densex]]

## Reported results
Evaluated on NQ, TriviaQA, WebQ, SQuAD, EntityQuestions with SimCSE, Contriever, DPR, GTR:

| Retriever type | Recall@5 gain over passages |
|---|---|
| Unsupervised (SimCSE) | +12.0 avg across 5 datasets |
| Unsupervised (Contriever) | +9.3 avg |
| Supervised (DPR, GTR) | smaller; ~+1–2 on unseen datasets |

Largest gains on **low-frequency (long-tail) entity queries** — the entity appears in few Wikipedia passages, so passage-level index dilutes its signal. [[chen2024densex]]

**QA accuracy (LLaMA-2-7B, EM@500 tokens):** Proposition context improves EM by +2.7 to +4.1 over passage context depending on retriever, by packing more relevant information into the same token budget. [[chen2024densex]]

## When to use / when not to
- ✅ Open-domain QA over Wikipedia-style corpora with diverse fact types.
- ✅ Queries about long-tail entities where passage-level granularity is noisy.
- ✅ Fixed token budget RAG — propositions pack more relevant info per token.
- ❌ Multi-hop questions requiring implicit reasoning across multiple passages.
- ❌ Corpora where propositions are harder to extract (e.g., code, tables, highly structured text).
- ❌ When a Propositionizer model is not available for the domain or language (currently English-only).

## Relation to other chunking approaches
- Mentioned as "LLM-guided / DenseX" in [[Chunking]]'s taxonomy.
- [[zhou2026chunktaxonomy]] finds proposition-based chunking loses 15–27% vs. paragraph for in-corpus retrieval but gains with [[Late Chunking]] (+22–27%), suggesting the two approaches are complementary.
- [[MoC]] (Mixture-of-Chunkers) routes text to size-specialized models; DenseX proposes LLM decomposition into atomic facts — different decomposition objective.
- [[Adaptive Chunking]] selects strategy per document; DenseX commits to propositions globally.

## Related pages
- [[Chunking]] — parent concept.
- [[Dense Retrieval]] — DenseX improves dense retrieval by changing the index granularity.
- [[Late Chunking]] — complementary: embed-first, then segment; works well with proposition-level units.
- [[MoC]] — alternative LLM-guided chunking approach.

## Sources
- [[chen2024densex]]
