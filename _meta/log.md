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
