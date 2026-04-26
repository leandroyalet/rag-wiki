---
type: meta
tags: [log]
updated: 2026-04-18
---

# Vault log (append-only)

Every significant operation gets recorded here. **Never edit past entries**, only append to the end.

Format:
```
## YYYY-MM-DD HH:MM — {author or agent}
- **operation**: description
- **files touched**: list
- **notes**: optional
```

---

## 2026-04-18 00:00 — bootstrap
- **operation**: vault initialization
- **files touched**: full structure, `CLAUDE.md`, `_meta/index.md`, `_meta/CONTRIBUTING.md`, templates
- **notes**: vault ready to receive the first ingestion session

## 2026-04-18 — Claude Code
- **operation**: benchmark template creation + RAGAS page completion
- **files touched**: `_templates/benchmark.md` (new), `02_Wiki/benchmarks/RAGAS.md` (updated)
- **notes**: added `homepage`, `repo`, `docs` fields to benchmark frontmatter; filled RAGAS metrics table, how-to-run snippet, limitations, and related benchmarks; marked uncited claims with `[!todo]`

## 2026-04-18 — Claude Code
- **operation**: renamed web_clips to snake_case
- **files touched**: `01_Sources/web_clips/` (3 files renamed)
- **notes**: `iwai_2026_rag_architectures_roadmap.md`, `mouschoutzi_retrieval_quality_precision_recall_f1.md`, `embedding_models_for_rag.md`

## 2026-04-18 — Claude Code
- **operation**: new benchmark page — DeepEval
- **files touched**: `02_Wiki/benchmarks/DeepEval.md` (new)
- **notes**: 12-metric table covering RAG + agent metrics; pytest usage example; cross-linked to RAGAS, ARES, TruLens, BEIR

## 2026-04-18 — Claude Code (/ingest)
- **operation**: ingest
- **source**: `01_Sources/papers/2410.06062v4.pdf` (citekey: emonet2024sparql)
- **files touched**:
  - `01_Sources/papers/emonet2024sparql.md` (new — literature note)
  - `02_Wiki/methods/Text-to-SPARQL.md` (new)
  - `02_Wiki/concepts/Knowledge Graph.md` (new)
  - `02_Wiki/concepts/Shape Expressions.md` (new)
  - `02_Wiki/concepts/Retrieval-Augmented Generation.md` (updated — added structured-output RAG variant, second source)
  - `02_Wiki/tools/Qdrant.md` (updated — filled stub)
  - `02_Wiki/models/BGE.md` (updated — filled stub)
- **notes**: paper applies RAG to federated SPARQL generation over bioinformatics KGs (UniProt, Bgee, OMA); key novelty is ShEx-based validation loop; PDF unreadable without poppler — metadata fetched from arxiv.org

## 2026-04-18 — Claude Code (/fill concepts)
- **operation**: fill incomplete concept stubs
- **files touched**:
  - `02_Wiki/concepts/Chunking.md` (filled)
  - `02_Wiki/concepts/Embeddings.md` (filled)
  - `02_Wiki/concepts/Dense Retrieval.md` (filled)
  - `02_Wiki/concepts/Sparse Retrieval.md` (filled)
  - `02_Wiki/concepts/Vector Database.md` (filled)
  - `02_Wiki/concepts/Query Expansion.md` (filled)
  - `02_Wiki/concepts/Multi-hop Retrieval.md` (filled)
  - `02_Wiki/concepts/Faithfulness.md` (filled)
  - `02_Wiki/concepts/Context Relevance.md` (filled)
  - `02_Wiki/concepts/Hallucination in RAG.md` (filled)
- **notes**: sourced from iwai-2026-rag-architectures-roadmap, embedding-models-for-rag, mouschoutzi-retrieval-quality-precision-recall-f1, lewis2020rag, emonet2024sparql; Faithfulness has a `[!todo]` pending RAGAS paper ingestion

## 2026-04-19 — Claude Code
- **operation**: new tool page — Docling
- **files touched**: `02_Wiki/tools/Docling.md` (new)
- **notes**: IBM Research OSS document parser; MIT license; metadata from docling-project.github.io; no paper in 01_Sources/ yet

## 2026-04-19 — Claude Code (/ingest)
- **operation**: ingest (all 4 unread papers)
- **source**: `2401.05856v1.pdf` (barnett2024failures), `2505.08261v1.pdf` (agrawal2025cag), `2506.07042v1.pdf` (chatzikyriakidis2025raggedevents), `2602.17687v1.pdf` (shorten2026irpapers)
- **files touched**:
  - `01_Sources/papers/barnett2024failures.md` (new)
  - `01_Sources/papers/agrawal2025cag.md` (new)
  - `01_Sources/papers/chatzikyriakidis2025raggedevents.md` (new)
  - `01_Sources/papers/shorten2026irpapers.md` (new)
  - `02_Wiki/concepts/RAG Failure Points.md` (new)
  - `02_Wiki/concepts/Cache-Augmented Generation.md` (new)
  - `02_Wiki/benchmarks/IRPAPERS.md` (new)
  - `02_Wiki/concepts/Hallucination in RAG.md` (updated — inverse calibration + failure point taxonomy)
  - `02_Wiki/concepts/Retrieval-Augmented Generation.md` (updated — CAG alternative, inverse calibration, failure points link)
  - `02_Wiki/models/ColBERT.md` (updated — filled stub + ColModernVBERT/ColPali multimodal extensions)
- **notes**: all PDFs read via arxiv HTML; key novel findings: (1) barnett FP1-FP7 taxonomy, (2) ACC-CAG outperforms dense RAG on HotpotQA, (3) inverse calibration principle — strong models degrade with RAG, (4) IRPAPERS: 22 text-only + 18 image-only successes confirming modality complementarity

## 2026-04-20 — Claude Code
- **operation**: new tool page — Haystack
- **files touched**: `02_Wiki/tools/Haystack.md` (new)
- **notes**: deepset GmbH OSS framework; 110 integrations; metadata from haystack.deepset.ai; no paper in 01_Sources/ yet; includes comparison table vs LangChain and LlamaIndex

## 2026-04-21 — Claude Code (/ingest)
- **operation**: ingest
- **source**: `2507.18910v1.pdf` (oche2025ragsurvey)
- **files touched**:
  - `01_Sources/papers/oche2025ragsurvey.md` (new)
  - `02_Wiki/methods/Fusion-in-Decoder.md` (new)
  - `02_Wiki/benchmarks/KILT.md` (new)
  - `02_Wiki/benchmarks/BEIR.md` (updated — filled stub)
  - `02_Wiki/concepts/Retrieval-Augmented Generation.md` (updated — historical milestones table, RAG-Seq/Token/FiD variants)
  - `02_Wiki/concepts/Dense Retrieval.md` (updated — contrastive training detail)
- **notes**: systematic review 2017–2025; key additions: FiD architecture, KILT benchmark, RETRO scaling result, historical timeline; BEIR stub filled opportunistically

## 2026-04-21 — Claude Code (/lint-wiki)
- **operation**: lint-wiki
- **files touched**: `_meta/lint-2026-04-21.md` (new), `_meta/contradictions.md` (C1 added), `02_Wiki/concepts/RAG Failure Points.md` (backslash fix), `02_Wiki/concepts/Retrieval-Augmented Generation.md` (Haystack/TruLens linked)
- **notes**: 45 issues total — 5 real broken links, 1 orphan (resolved), 12 empty stubs, 7 wanted pages, 1 contradiction recorded; code-block false positive excluded from count

## 2026-04-21 — Claude Code
- **operation**: create TruLens tool page (lint priority 1)
- **files touched**: `02_Wiki/tools/TruLens.md` (new)
- **notes**: RAG Triad, feedback functions, comparison table vs RAGAS/DeepEval, runtime instrumentation focus; resolves broken [[TruLens]] links in RAGAS.md and DeepEval.md

## 2026-04-21 — Claude Code
- **operation**: reclassify RAGAS and DeepEval from benchmarks to tools
- **files touched**:
  - `02_Wiki/benchmarks/RAGAS.md` → `02_Wiki/tools/RAGAS.md` (moved + type: benchmark → tool)
  - `02_Wiki/benchmarks/DeepEval.md` → `02_Wiki/tools/DeepEval.md` (moved + type: benchmark → tool)
  - `02_Wiki/tools/RAGAS.md` (updated — "Related benchmarks" → "Related tools / benchmarks", clarified BEIR distinction)
  - `02_Wiki/tools/DeepEval.md` (updated — same section rename and clarification)
- **notes**: RAGAS and DeepEval are eval frameworks, not fixed-corpus benchmarks; BEIR/MTEB/IRPAPERS remain in benchmarks/

## 2026-04-21 — Claude Code (/ingest)
- **operation**: ingest Es2023ragas + gao2023hyde (lint priority 3) + priorities 4–6
- **source**: arXiv:2309.15217 (Es2023ragas), arXiv:2212.10496 (gao2023hyde)
- **files touched**:
  - `01_Sources/papers/Es2023ragas.md` (new)
  - `01_Sources/papers/gao2023hyde.md` (new)
  - `02_Wiki/tools/RAGAS.md` (updated — metric formulas + accuracy table + [[Es2023ragas]] citations)
  - `02_Wiki/methods/HyDE.md` (updated — empirical results section + [[gao2023hyde]] citations)
  - `02_Wiki/tools/ARES.md` (new — priority 4)
  - `02_Wiki/concepts/Answer Relevance.md` (new — priority 5)
  - `02_Wiki/concepts/BM25.md` (new — priority 6)
  - `02_Wiki/concepts/Sparse Retrieval.md` (BM25 → [[BM25]])
  - `02_Wiki/tools/Weaviate.md` (BM25 → [[BM25]])
  - `02_Wiki/methods/Hybrid Search.md` (BM25 → [[BM25]])
  - `02_Wiki/benchmarks/BEIR.md` (BM25 → [[BM25]])
  - `02_Wiki/benchmarks/IRPAPERS.md` (BM25 → [[BM25]])
  - `02_Wiki/concepts/Vector Database.md` (BM25 → [[BM25]])
  - `02_Wiki/tools/Pinecone.md` (BM25 → [[BM25]])
  - `02_Wiki/concepts/Embeddings.md` (BM25 → [[BM25]])
  - `02_Wiki/concepts/Dense Retrieval.md` (BM25 → [[BM25]])
- **notes**: resolved 5 broken links (Es2023ragas, gao2023hyde), created 3 new pages (ARES, Answer Relevance, BM25), wikilinked BM25 across 9 files

## 2026-04-23 — Claude Code (/ingest)
- **operation**: ingest — 00_Inbox/FalkorDB.md
- **source**: `00_Inbox/FalkorDB.md` + falkordb.com / github.com/falkordb/falkordb
- **files touched**:
  - `02_Wiki/tools/FalkorDB.md` (new)
  - `02_Wiki/methods/GraphRAG.md` (updated — graph backend options section)
  - `02_Wiki/concepts/Labeled Property Graph.md` (updated — FalkorDB added as example)
- **notes**: SSPLv1 licence (not fully open-source); GraphBLAS sparse-matrix engine is the key architectural differentiator; Redis module architecture means in-memory only by default; performance claims vs Neo4j not independently verified

## 2026-04-23 — Claude Code (/ingest)
- **operation**: ingest (all 3 web clips)
- **source**: `Cutting Through the Noise An Introduction to RDF & LPG Graphs.md`, `Evaluate RAG pipeline using HuggingFace Open Source Models.md`, `embedding-models-for-rag.md`
- **files touched**:
  - `02_Wiki/concepts/RDF.md` (new)
  - `02_Wiki/concepts/Labeled Property Graph.md` (new)
  - `02_Wiki/tools/BeyondLLM.md` (new)
  - `02_Wiki/concepts/Knowledge Graph.md` (updated — RDF/LPG variants section, new sources, alias cleanup)
  - `02_Wiki/concepts/Embeddings.md` (updated — fine-tuning guidance, MTEB caveat)
  - `02_Wiki/benchmarks/MTEB.md` (updated — full retrieval dataset table with descriptions)
- **notes**: Clip 1 introduced RDF vs LPG distinction; clip 2 introduced BeyondLLM (HF-native RAG framework with RAG Triad eval); clip 3 already partially sourced Embeddings.md — added fine-tuning section from remaining content

## 2026-04-22 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 46 pages indexed across 5 sections — Concepts (17), Methods (8), Models (4), Benchmarks (4), Tools (13); tools sub-grouped into vector stores / frameworks / parsing / evaluation

## 2026-04-26 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 56 pages indexed across 5 sections — Concepts (20), Methods (12), Models (4), Benchmarks (4), Tools (16); tools sub-grouped into vector stores / graph databases / frameworks / parsing / evaluation

## 2026-04-26 — Claude Code (/ingest)
- **operation**: ingest (2 web clips)
- **source**: `Contextual Retrieval in AI Systems.md` (Anthropic), `How to Select the 5 Most Relevant Documents for AI Search  by Eivind Kjosbakken  in Towards AI.md`
- **files touched**:
  - `02_Wiki/methods/Contextual Retrieval.md` (new — full page with pipeline, results table, cost, comparison vs HyDE)
  - `02_Wiki/methods/Reranking.md` (updated — Cohere 67% reduction result, recall/precision framing, LLM verification, Qwen Reranker)
  - `02_Wiki/methods/Hybrid Search.md` (updated — Contextual BM25, context bloat/poisoning concepts, sources filled)
  - `02_Wiki/concepts/Chunking.md` (updated — contextual enrichment section, Contextual Retrieval link)
- **notes**: Contextual Retrieval is the key new method — 49% failure reduction (embeddings+BM25) and 67% with reranking; $1.02/M tokens with prompt caching; outperforms HyDE and summary-based indexing; clip 2 adds recall/precision framing for retrieval improvement techniques and introduces LLM verification and context bloat/poisoning concepts

## 2026-04-26 — Claude Code (/ingest) [batch 2]
- **operation**: ingest (5 papers)
- **source**: `Ragas_...md` (duplicate of Es2023ragas), `RetrievalAugmented_Generation_in_Industry_...md` (brehme2025ragindustry), `The_Challenges_of_Evaluating_LLM_Applications_...md` (abeysinghe2024llmeval), `VERA_...md` (ding2024vera), `UniEval_...md` (li2025unieval — out of scope)
- **files touched**:
  - `01_Sources/papers/Ragas_...md` (marked summarized — duplicate of Es2023ragas)
  - `01_Sources/papers/RetrievalAugmented_Generation_in_Industry_...md` (summarized — citekey brehme2025ragindustry)
  - `01_Sources/papers/The_Challenges_of_Evaluating_LLM_Applications_...md` (summarized — citekey abeysinghe2024llmeval)
  - `01_Sources/papers/VERA_...md` (summarized — citekey ding2024vera, 4-metric table + cross-encoder mechanism)
  - `01_Sources/papers/UniEval_...md` (summarized — marked out of scope, no wiki pages)
  - `02_Wiki/tools/VERA.md` (new — cross-encoder composite ranking, Bootstrap confidence bounds)
  - `02_Wiki/concepts/LLM-as-Judge.md` (updated — factored evaluation 5 factors, inflation/agreement findings from abeysinghe2024llmeval)
  - `02_Wiki/concepts/Retrieval-Augmented Generation.md` (updated — industry adoption section from brehme2025ragindustry)
  - `02_Wiki/concepts/RAG Failure Points.md` (updated — data preprocessing as pre-FP1 industry challenge)
- **notes**: RAGAS file was a duplicate (arXiv:2309.15217 = Es2023ragas); UniEval is multimodal, not RAG-relevant; brehme2025ragindustry confirms data preprocessing as top operational pain point; ding2024vera cross-encoder composite score differentiates it from RAGAS/DeepEval

## 2026-04-26 — Claude Code (/ingest) [batch 1]
- **operation**: ingest (5 papers)
- **source**: `A_Closer_Look_into_Automatic_Evaluation_Using_Large_Language_Models.md` (chiang2023llmeval), `Adaptive_Chunking_...md` (moura2026adaptive), `Beyond_ChunkThenEmbed_...md` (zhou2026chunktaxonomy), `Engineering_the_RAG_Stack_...md` (wampler2025ragstack), `MoC_...md` (zhao2025moc)
- **files touched**:
  - `01_Sources/papers/A_Closer_Look_...md` (summarized — added citekey chiang2023llmeval, findings)
  - `01_Sources/papers/Adaptive_Chunking_...md` (summarized — added citekey moura2026adaptive, 5-metric table)
  - `01_Sources/papers/Beyond_ChunkThenEmbed_...md` (summarized — added citekey zhou2026chunktaxonomy, taxonomy + results)
  - `01_Sources/papers/Engineering_the_RAG_Stack_...md` (summarized — added citekey wampler2025ragstack, 5-dim taxonomy)
  - `01_Sources/papers/MoC_...md` (summarized — added citekey zhao2025moc, BC/CS formulas)
  - `02_Wiki/concepts/LLM-as-Judge.md` (new)
  - `02_Wiki/methods/Adaptive Chunking.md` (new)
  - `02_Wiki/methods/Late Chunking.md` (new)
  - `02_Wiki/methods/MoC.md` (new)
  - `02_Wiki/concepts/Chunking.md` (updated — taxonomy section, 6 new variants, quality metrics)
  - `02_Wiki/concepts/Retrieval-Augmented Generation.md` (updated — 5-dim taxonomy table, LLM-as-Judge link, wampler2025ragstack citation)
- **notes**: all papers summarized from abstracts + arXiv HTML; chiang2023llmeval key finding: explain-then-rate correlation 0.725 vs 0.311 for auto-CoT+score-only; zhou2026chunktaxonomy: structure-based wins in-corpus, LumberChunker wins in-document; moura2026adaptive: adaptive selection → 72% vs 62-64% correctness

## 2026-04-21 — Claude Code
- **operation**: fill 12 empty stubs (lint priority 2)
- **files touched**:
  - `02_Wiki/methods/GraphRAG.md` (filled)
  - `02_Wiki/methods/RAG-Fusion.md` (filled)
  - `02_Wiki/methods/RAPTOR.md` (filled)
  - `02_Wiki/methods/Reranking.md` (filled)
  - `02_Wiki/models/E5.md` (filled)
  - `02_Wiki/models/Sentence-BERT.md` (filled)
  - `02_Wiki/benchmarks/MTEB.md` (filled)
  - `02_Wiki/tools/FAISS.md` (filled)
  - `02_Wiki/tools/LangChain.md` (filled)
  - `02_Wiki/tools/LlamaIndex.md` (filled)
  - `02_Wiki/tools/Pinecone.md` (filled)
  - `02_Wiki/tools/Weaviate.md` (filled)
- **notes**: HyDE.md already had body content so counted as resolved; all 12 stubs now have full content; sources remain [!todo] for tool/model pages with no corresponding 01_Sources/ papers
