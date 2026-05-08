---
type: benchmark
aliases: [Massive Text Embedding Benchmark]
tags: [benchmark, embedding, retrieval, eval]
status: stub
created: 2026-04-18
updated: 2026-05-08
sources: ["[[01_Sources/web_clips/embedding-models-for-rag]]", "[[muennighoff2022mteb]]"]
homepage: https://huggingface.co/spaces/mteb/leaderboard
repo: https://github.com/embeddings-benchmark/mteb
docs: https://huggingface.co/spaces/mteb/leaderboard
year: 2022
---

# MTEB

> **TL;DR** The standard leaderboard for text embedding models — 8 task types, 181 datasets, evaluated on NDCG@10 for retrieval — the first stop when choosing an embedding model for RAG.

## What it measures
MTEB (Massive Text Embedding Benchmark) evaluates text embeddings across the full range of downstream uses, not just retrieval. For RAG, the **Retrieval** tab is most relevant: it measures how well embeddings find the correct passage for a query, scored with NDCG@10.

The original paper benchmarked **33 models** across **58 datasets** in **112 languages** and found that no single text embedding method dominates across all tasks — a result that motivates domain-specific model selection rather than relying on the overall leaderboard score. [[muennighoff2022mteb]]

The benchmark exposes trade-offs between model size, language coverage, and task-specific performance — a model topping the overall leaderboard may underperform a smaller model on your specific domain. [[01_Sources/web_clips/embedding-models-for-rag]]

## Tasks and datasets
| Task type | # Datasets | What it evaluates |
|-----------|-----------|-------------------|
| **Retrieval** | ~15 | Query → relevant passage (NDCG@10) — most relevant for RAG |
| Classification | ~12 | Text → category label |
| Clustering | ~11 | Group texts by topic |
| Pair classification | ~3 | Binary semantic equivalence |
| Reranking | ~4 | Order candidate passages by relevance |
| STS (Semantic Textual Similarity) | ~10 | Cosine similarity correlates with human judgement |
| Summarisation | ~1 | Summary ↔ source similarity |
| Bitext mining | ~117 | Parallel sentence alignment across languages |

[[01_Sources/web_clips/embedding-models-for-rag]]

## Key retrieval datasets (English)
| Dataset | Domain | Description |
|---------|--------|-------------|
| **ArguAna** | Debate | Argument ↔ counterargument pairs from an online debate portal |
| **CQADupstack** | Q&A | Community questions from 12 StackExchange subforums |
| **DBPedia** | Open | Heterogeneous entity-bearing queries (NE, keywords, NL) |
| **FEVER** | Fact-check | Real-world misinformation fact verification |
| **FiQA-2018** | Finance | Opinion-based QA from StackExchange Investment posts 2009–2017 |
| **HotpotQA** | Multi-hop | Multi-paragraph reasoning questions, Wikipedia answers |
| **MSMARCO** | Web | Bing search queries and passage answers |
| **NFCorpus** | Medical | NutritionFacts queries + PubMed annotated documents |
| **NQ** | Web | Google search queries with Wikipedia answer spans |
| **QuoraRetrieval** | Q&A | Duplicate question pairs |
| **SCIDOCS** | Science | Scientific papers and citation-based relevance |
| **SciFact** | Science | Fact-checking claims against scientific literature |
| **Touché-2020** | Debate | Conversational argument retrieval |
| **TREC-COVID** | Medical | Biomedical queries on the COVID-19 pandemic |

[[01_Sources/web_clips/embedding-models-for-rag]]

Domain-specific datasets (medical, financial, legal) reward specialists over general models. For financial corpora, weight FiQA-2018; for biomedical, weight NFCorpus and TREC-COVID. [[01_Sources/web_clips/embedding-models-for-rag]]

## Metrics
| Metric | Description |
|--------|-------------|
| **NDCG@10** | Primary retrieval metric — quality of top-10 ranking |
| MRR@10 | Mean reciprocal rank at 10 |
| Recall@k | Coverage of relevant docs in top-k |
| Average (all tasks) | Headline leaderboard score |

## How to use the leaderboard
1. Filter to the **Retrieval** tab for RAG use cases.
2. Filter by language and domain relevant to your corpus.
3. Start with a small model — bigger is not always better on specific domains. [[01_Sources/web_clips/embedding-models-for-rag]]
4. Compare NDCG@10 on the dataset closest to your domain (e.g., FiQA for financial, NFCorpus for medical).

## Limitations / caveats
- Static datasets; models can be over-optimised for MTEB benchmarks.
- General leaderboard score hides domain-specific variation.
- Does not evaluate [[Reranking]] quality or end-to-end RAG pipeline performance.
- No visual or multimodal retrieval — see [[IRPAPERS]] for that.
- The STS task measures cosine similarity between bi-encoder embeddings — [[herbold2023stscore]] shows that direct similarity *prediction* from a fine-tuned cross-encoder is more robust for evaluation purposes than cosine distance, suggesting STS MTEB scores may slightly overestimate real-world embedding quality for similarity judgement tasks.

## Related benchmarks
- [[BEIR]] — MTEB's Retrieval tab is largely a superset of BEIR datasets.
- [[IRPAPERS]] — extends to visual/image-based retrieval on scientific papers.

## Sources
- [[muennighoff2022mteb]]
- [[01_Sources/web_clips/embedding-models-for-rag]]
