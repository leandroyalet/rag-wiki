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

## 2026-05-07 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 57 pages indexed across 5 sections — Concepts (20), Methods (12), Models (4), Benchmarks (5), Tools (16); MME added to benchmarks

## 2026-05-07 — Claude Code (/ingest)
- **operation**: ingest (4 papers)
- **source**: `MME_...md` (fu2023mme), `Semantic_Web_Technology_for_Agent_Communication_Protocols.md` (berges2024commOnt), `Semantic_integration_process_...md` (elasri2013semantic), `Semantic_Jira_...md` (heyn2013semantic)
- **files touched**:
  - `01_Sources/papers/MME_...md` (summarized — citekey fu2023mme, 14 subtasks, 4 failure modes)
  - `01_Sources/papers/Semantic_Web_Technology_...md` (summarized — citekey berges2024commOnt, OWL-DL/SWRL/CommOnt)
  - `01_Sources/papers/Semantic_integration_process_...md` (summarized — citekey elasri2013semantic, limited relevance noted)
  - `01_Sources/papers/Semantic_Jira_...md` (summarized — citekey heyn2013semantic, early enterprise semantic retrieval)
  - `02_Wiki/benchmarks/MME.md` (new — 14-subtask table, ACC/ACC+ scoring, 4 failure modes, RAG relevance)
  - `02_Wiki/concepts/RDF.md` (updated — OWL/SWRL agentic reasoning section from berges2024commOnt)
- **notes**: MME is a genuine multimodal eval benchmark relevant to visual RAG and hallucination measurement; berges2024commOnt extends the OWL/SWRL row in RDF.md with an agentic use case; the two 2013 papers (elasri, heyn) predate modern RAG and contribute no new wiki pages; all 4 papers now summarized — 01_Sources/papers inbox is fully cleared

## 2026-05-07 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 56 pages indexed across 5 sections — Concepts (20), Methods (12), Models (4), Benchmarks (4), Tools (16); no new pages since 2026-04-26

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

## 2026-05-08 — Claude Code (/ingest)
- **operation**: ingest — pypi.org/project/unstructured/ (Unstructured document processing library)
- **source**: https://pypi.org/project/unstructured/, https://docs.unstructured.io, https://github.com/Unstructured-IO/unstructured
- **files touched**:
  - `02_Wiki/tools/Unstructured.md` (new — typed element model, partitioning strategies, chunking, 20+ connectors, LangChain/LlamaIndex integration)
- **notes**: Unstructured is the most widely-adopted open-source ingestion layer for RAG; key differentiator is typed semantic element objects (Title, NarrativeText, Table) enabling structure-aware chunking; heavy system deps (libreoffice, poppler, tesseract); Apache-2.0; 14.7k stars

## 2026-05-08 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 60 pages indexed across 5 sections — Concepts (20), Methods (12), Models (4), Benchmarks (5), Tools (19); Unstructured added to Document parsing & ingestion

## 2026-05-08 — Claude Code (/ingest)
- **operation**: ingest — kreuzberg.dev (Kreuzberg document extraction library)
- **source**: https://kreuzberg.dev, https://github.com/Goldziher/kreuzberg, https://pypi.org/project/kreuzberg/
- **files touched**:
  - `02_Wiki/tools/Kreuzberg.md` (new — Rust-core extraction, 91+ formats, code intelligence, TOON wire format, ELv2 license)
- **notes**: Kreuzberg is a document parsing/ingestion tool comparable to Docling and MarkItDown but with a Rust core, 10+ language bindings, code intelligence via tree-sitter, and a token-efficient TOON output format; ELv2 license is a key constraint vs MIT alternatives

## 2026-05-08 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 59 pages indexed across 5 sections — Concepts (20), Methods (12), Models (4), Benchmarks (5), Tools (18); Kreuzberg added to Document parsing & ingestion

## 2026-05-08 — Claude Code (/ingest)
- **operation**: ingest — python.useinstructor.com (Instructor library)
- **source**: https://python.useinstructor.com (homepage + /concepts/patching/ + /concepts/retrying/)
- **files touched**:
  - `02_Wiki/tools/Instructor.md` (new — structured output library, Pydantic-based, 15+ providers, retry-with-feedback)
- **notes**: Instructor is a structured-output extraction layer for LLM pipelines — not a RAG framework itself but relevant as the generation output contract layer; 3M+ monthly downloads, 11k stars

## 2026-05-08 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 58 pages indexed across 5 sections — Concepts (20), Methods (12), Models (4), Benchmarks (5), Tools (17); Instructor added to Frameworks & orchestration

## 2026-05-08 — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: https://sbert.net/index.html + https://sbert.net/docs/sparse_encoder/usage/usage.html
- **clip saved**: `01_Sources/web_clips/sbert-net-sentence-transformers-library.md`
- **files touched**:
  - `02_Wiki/concepts/Sparse Retrieval.md` (updated — SPLADE section expanded: vocabulary-sized vectors, >99% sparsity, learned token expansion, code example, sbert SparseEncoder class)
  - `02_Wiki/models/Sentence-BERT.md` (updated — 3-class library architecture table: SentenceTransformer / CrossEncoder / SparseEncoder; 10k+ models, HF maintenance)
  - `02_Wiki/methods/Hybrid Search.md` (updated — SPLADE as learned sparse signal section added)
- **notes**: Main novel content is SPLADE / SparseEncoder as a third model type in sentence-transformers alongside dense and reranker; bridges BM25 and dense by adding learned term expansion while staying inverted-index compatible

## 2026-05-08 — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: https://huggingface.co/blog/multimodal-sentence-transformers
- **clip saved**: `01_Sources/web_clips/aarsen-2026-multimodal-sentence-transformers.md`
- **files touched**:
  - `02_Wiki/concepts/Multimodal Embeddings.md` (new — shared embedding space, modality gap, model table, retrieve+rerank pipeline)
  - `02_Wiki/models/BGE.md` (updated — BGE-VL multimodal variant table added)
  - `02_Wiki/models/Sentence-BERT.md` (updated — sentence-transformers v5.4 multimodal extension note)
  - `02_Wiki/methods/Reranking.md` (updated — multimodal reranking section with CrossEncoder API example)
  - `_meta/index.md` (updated — Multimodal Embeddings added, Concepts 21→22)
- **notes**: Key new concept is the modality gap (cross-modal cosine scores are lower than within-modal but ordering preserved); Sentence Transformers v5.4 unifies text, image, audio, video under one API; BGE-VL adds 6 multimodal variants to the BGE family

## 2026-05-08 — Claude Code (/ingest)
- **operation**: ingest (7 remaining papers — batch 2)
- **source**: 2507.07548 (ullrich2025requirements), 2507.18910 (oche2025ragsurvey), 2512.24601 (zhang2025rlm), 2601.03270 (kumar2026sts), 2601.05264 (wampler2025ragstack duplicate), 2602.17687 (shorten2026irpapers), Semantic_Annotation_pdf (nithya2014semantic)
- **files touched**:
  - `01_Sources/papers/ullrich2025requirements.md` (new — out of scope, no wiki pages)
  - `01_Sources/papers/zhang2025rlm.md` (new — Recursive LMs, alternative to RAG/CAG for long-context)
  - `01_Sources/papers/kumar2026sts.md` (new — STS survey, 6 research streams)
  - `01_Sources/papers/nithya2014semantic.md` (new — out of scope, 2014 Linked Data paper)
  - `01_Sources/papers/oche2025ragsurvey.md` (already existed — verified complete)
  - `01_Sources/papers/shorten2026irpapers.md` (already existed — verified complete)
  - `02_Wiki/concepts/Embeddings.md` (updated — STS state-of-art table from kumar2026sts, 6 research streams)
  - `02_Wiki/concepts/Cache-Augmented Generation.md` (updated — RLM as alternative long-context approach, zhang2025rlm)
- **notes**: 2601.05264 PDF is a duplicate of existing Engineering_the_RAG_Stack_...md (wampler2025ragstack) — same authors, title, arXiv ID; no new note created. ullrich2025requirements and nithya2014semantic are off-topic. All 15 unprocessed PDFs now have literature notes. 01_Sources/papers inbox fully cleared.

## 2026-05-08 — Claude Code (/ingest)
- **operation**: ingest (8 papers — batch 1 of remaining PDFs)
- **source**: 2210.07316 (muennighoff2022mteb), 2309.12697 (herbold2023stscore), 2401.05856 (barnett2024failures), 2410.06062 (emonet2024sparql), 2410.08801 (simon2024rageval), 2505.08261 (agrawal2025cag), 2505.18906 (chakraborty2025fedrag), 2506.07042 (chatzikyriakidis2025ragcoq)
- **files touched**:
  - `01_Sources/papers/muennighoff2022mteb.md` (new)
  - `01_Sources/papers/herbold2023stscore.md` (new)
  - `01_Sources/papers/simon2024rageval.md` (new)
  - `01_Sources/papers/chakraborty2025fedrag.md` (new)
  - `01_Sources/papers/chatzikyriakidis2025ragcoq.md` (new)
  - `01_Sources/papers/barnett2024failures.md` (already existed — verified complete)
  - `01_Sources/papers/emonet2024sparql.md` (already existed — verified complete)
  - `01_Sources/papers/agrawal2025cag.md` (already existed — verified complete)
  - `02_Wiki/benchmarks/MTEB.md` (updated — muennighoff2022mteb citation, 33 models/58 datasets/112 lang finding, STSScore caveat)
  - `02_Wiki/concepts/RAG Failure Points.md` (updated — simon2024rageval evaluation blueprint section)
  - `02_Wiki/concepts/RDF.md` (updated — chatzikyriakidis2025ragcoq RDF→Coq proof-assistant section)
  - `02_Wiki/concepts/Federated RAG.md` (new stub — FL+RAG architecture, 3 open challenges)
  - `_meta/index.md` (updated — Federated RAG added, Concepts count 20→21)
- **notes**: barnett2024failures/emonet2024sparql/agrawal2025cag literature notes already existed from prior sessions; herbold2023stscore (STSScore) added as evaluation caveat to MTEB; chatzikyriakidis2025ragcoq adds a formal-reasoning application of RDF (RDF→Coq); Federated RAG is a genuine emerging subfield warranting its own stub

## 2026-05-07 — Claude Code (/lint-wiki)
- **operation**: lint-wiki
- **files touched**: `_meta/lint-2026-05-07.md` (new)
- **notes**: 22 issues total — 4 broken links (RRF ×2, RAG Triad ×2, MLflow ×1, karpukhin reading-list ×1), 0 orphans, 0 missing frontmatter, 0 empty stubs, 0 duplicates, 3 wanted pages (RRF, RAG Triad, MLflow), 1 pre-existing contradiction (C1), 17 uncited tool/concept pages

## 2026-05-08 — Claude Code (fix broken wikilinks)
- **operation**: fix broken wikilinks (from lint-2026-05-07 report)
- **files touched**:
  - `02_Wiki/methods/Reciprocal Rank Fusion.md` (new stub — RRF algorithm, k≈60 constant, use in Hybrid Search / RAG-Fusion)
  - `02_Wiki/concepts/RAG Triad.md` (new stub — three-metric framework: Context Relevance, Groundedness, Answer Relevance)
  - `02_Wiki/tools/MLflow.md` (new stub — MLOps platform, LLM eval via mlflow.evaluate(), TruLens integration)
  - `_meta/index.md` (updated — Concepts 22→23, Methods 12→13, Tools 19→20)
- **notes**: resolves 4 broken wikilinks and 3 wanted-page issues from lint report; 17 uncited tool pages remain (acceptable — no academic sources)

## 2026-05-08 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 65 pages indexed — Concepts (23), Methods (13), Models (4), Benchmarks (5), Tools (20); TL;DRs refreshed from source files (KILT, E5, Federated RAG updated); Tools subcategorised as Vector stores (4), Graph databases (1), Frameworks (5), Document parsing (4), Evaluation (6)

## 2026-05-08 — Claude Code (/lint-wiki)
- **operation**: lint-wiki
- **files touched**: `_meta/lint-2026-05-08.md` (new)
- **notes**: 42 issues total — 11 broken links (1 format mismatch in BM25.md, 1 fully missing berges2024commOnt, 9 citekey-mismatch lit notes with long filenames), 5 orphan pages (BeyondLLM/Federated RAG/Instructor/Unstructured/VERA), 0 missing frontmatter, 0 empty stubs, 0 duplicates, 2 wanted items (berges lit note + unread clip), 1 pre-existing contradiction (C1 open), 23 uncited pages (16 tool pages acceptable, 7 concept/method pages flagged)

## 2026-05-15 — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: https://docs.chonkie.ai/common/welcome
- **clip saved**: `01_Sources/web_clips/chonkie-docs-welcome.md`
- **files created**: `02_Wiki/tools/Chonkie.md`
- **files updated**: `02_Wiki/concepts/Chunking.md` (added Implementations section, NeuralChunker/SlumberChunker/CodeChunker variants, Chonkie backlink), `02_Wiki/methods/Late Chunking.md` (added Implementations section + Chonkie backlink)

## 2026-05-15 — Claude Code (/ingest papers)
- **operation**: ingest
- **sources**:
  - `01_Sources/papers/2312.06648v3.pdf` → citekey `chen2024densex` (Dense X Retrieval, EMNLP 2024)
  - `01_Sources/papers/2409.06595v3.pdf` → citekey `muller2025grouse` (GroUSE benchmark, arXiv 2025)
- **lit notes created**: `01_Sources/papers/chen2024densex.md`, `01_Sources/papers/muller2025grouse.md`
- **wiki pages created**: `02_Wiki/methods/DenseX.md`, `02_Wiki/benchmarks/GroUSE.md`
- **wiki pages updated**:
  - `02_Wiki/concepts/Chunking.md` — enriched DenseX entry, added chen2024densex citation
  - `02_Wiki/concepts/Dense Retrieval.md` — added Retrieval Granularity section citing chen2024densex
  - `02_Wiki/concepts/LLM-as-Judge.md` — added Calibration vs. Correlation section, GroUSE backlink
  - `02_Wiki/concepts/RAG Failure Points.md` — added GroUSE's 7 generator failure modes table
  - `02_Wiki/tools/RAGAS.md` — added GroUSE edge-case limitation
  - `02_Wiki/tools/DeepEval.md` — added GroUSE edge-case limitation, first source entry
- **notes**: 2 previously untracked PDFs ingested; all claims cited; no hallucinated sources

## 2026-05-15 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 68 pages indexed — Concepts (23), Methods (14), Models (4), Benchmarks (6), Tools (21); added DenseX to Methods, GroUSE to Benchmarks, Chonkie to Tools (Document parsing & ingestion)

## 2026-05-16 — Claude Code (/ingest articles)
- **operation**: ingest
- **sources**:
  - `01_Sources/web_clips/Building the Entire RAG Ecosystem and Optimizing Every Component.md` (Fareed Khan)
  - `01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar.md`
  - `01_Sources/web_clips/RAG, LLM Wiki, or Gbrain? How Your Agent Remembers Changes Everything  by Yanli Liu  in AI Advances.md`
  - `01_Sources/web_clips/Understanding Retrieval in RAG Systems Why Chunk Size Matters  by Sarah Lea  in Towards AI.md`
- **wiki pages updated**:
  - `02_Wiki/concepts/Retrieval-Augmented Generation.md` — added Iterative/Adaptive/Real-Time/Hierarchical RAG variants (Pavankumar); added chunking/re-derivation/passivity failure patterns and LLM Wiki vs GBrain comparison (Liu)
  - `02_Wiki/concepts/RAG Failure Points.md` — added Pattern-level limitations section (Liu): chunking problem, re-derivation problem, passivity problem
  - `02_Wiki/concepts/Chunking.md` — added Empirical chunk size guidance section (Sarah Lea): 80/220/500 char breakpoints, similarity score interpretation, uncertainty detection via score gap
  - `02_Wiki/methods/RAG-Fusion.md` — added source from Fareed Khan article; retained k=60 RRF default
  - `02_Wiki/concepts/Query Expansion.md` — added Step-back prompting and Sub-question decomposition citations (Fareed Khan); added MultiQueryRetriever note
  - `02_Wiki/concepts/Multi-hop Retrieval.md` — added "Iterative RAG" alias; added Pavankumar source
- **notes**: 4 previously uncited web clips processed; all new claims cited; no pages created (all content merged into existing pages)

## 2026-05-16 — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: https://milvus.io/ (homepage redirected; content retrieved from https://raw.githubusercontent.com/milvus-io/milvus/master/README.md)
- **clip saved**: `01_Sources/web_clips/milvus-vector-database.md`
- **files touched**:
  - `02_Wiki/tools/Milvus.md` — CREATED: full tool page (deployment options, index types, GPU/sparse support, ecosystem integrations)
  - `02_Wiki/concepts/Vector Database.md` — added Milvus row to variants table; added [[Milvus]] to related pages
  - `02_Wiki/tools/LlamaIndex.md` — upgraded bare "Milvus" text to [[Milvus]] wikilink
  - `02_Wiki/tools/Haystack.md` — upgraded bare "Milvus" text to [[Milvus]] wikilink
  - `_meta/index.md` — added [[Milvus]] under Infrastructure & Tools → Vector stores (count: 21 → 22)

## 2026-05-17 — Claude Code (/ingest web-clips)
- **operation**: ingest
- **sources processed**: 2 (zero-backlink web clips)
  - `01_Sources/web_clips/RAG vs GraphRAG Shared Goal & Key Differences.md` (Memgraph blog)
  - `01_Sources/web_clips/Retrieval Augmented Generation (RAG) limitations.md` (Simeon Emanuilov)
- **wiki pages updated**:
  - `02_Wiki/methods/GraphRAG.md` — added source; extended "Problem it solves" with fragmented context/over-retrieval/no-reasoning breakdown; added pivot/relevance-expansion retrieval mechanics; added supply chain / research / healthcare use cases to when-to-use
  - `02_Wiki/concepts/RAG Failure Points.md` — added Emanuilov phase-based taxonomy table (polysemy, context order sensitivity, latency); added source
- **notes**: 2 clips already well-integrated (BeyondLLM clip via BeyondLLM.md; mouschoutzi clip via Context Relevance.md) — skipped; 0-backlink clips fully processed

## 2026-05-17 — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: https://infiniflow.org/ (homepage redirected; content retrieved from ragflow.io, raw GitHub READMEs for RAGFlow and Infinity)
- **clip saved**: `01_Sources/web_clips/infiniflow-ragflow-infinity.md`
- **files touched**:
  - `02_Wiki/tools/RAGFlow.md` — CREATED: full tool page (DeepDoc template-based chunking, hybrid search, traceable citations, agent orchestration, MCP, infrastructure stack, when-to-use)
  - `02_Wiki/tools/Infinity.md` — CREATED: full tool page (dense/sparse/tensor/full-text hybrid search, 0.1ms latency benchmarks, deployment modes, single-binary architecture)
  - `02_Wiki/concepts/Vector Database.md` — added Infinity row to variants table; added [[Infinity]] to related pages
  - `02_Wiki/tools/Docling.md` — added RAGFlow integration note and [[RAGFlow]] to related pages
  - `_meta/index.md` — added [[Infinity]] under Vector stores, [[RAGFlow]] under Frameworks & orchestration (count: 22 → 24)

## 2026-05-22 — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: https://en.wikipedia.org/wiki/Precision_and_recall
- **clip saved**: `01_Sources/web_clips/wikipedia-precision-recall.md`
- **files touched**:
  - `02_Wiki/concepts/Precision and Recall.md` — CREATED: full concept page (formulas, confusion matrix, precision-recall trade-off, Fβ, retrieval variants Precision@k/Recall@k/F1@k/HitRate@k/MAP/NDCG, RAG application table)
  - `02_Wiki/concepts/Context Relevance.md` — upgraded inline mention of Precision@k/Recall@k/F1@k to [[Precision and Recall]] wikilink; added to related pages
  - `_meta/index.md` — added [[Precision and Recall]] under Concepts (count: 23 → 24)

## 2026-05-22 — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: https://en.wikipedia.org/wiki/Discounted_cumulative_gain
- **clip saved**: `01_Sources/web_clips/wikipedia-dcg-ndcg.md`
- **files touched**:
  - `02_Wiki/concepts/NDCG.md` — CREATED: full concept page (CG/DCG/IDCG/nDCG formulas, both industry and linear variants, graded relevance, properties, limitations, comparison table vs Precision@k/Recall@k)
  - `02_Wiki/benchmarks/BEIR.md` — upgraded bare "NDCG@10" to [[NDCG]]@10 wikilink
  - `02_Wiki/benchmarks/MTEB.md` — upgraded bare "NDCG@10" to [[NDCG]]@10 wikilink
  - `02_Wiki/concepts/Precision and Recall.md` — upgraded NDCG@k table entry to [[NDCG]] wikilink; added [[NDCG]] to related pages
  - `_meta/index.md` — added [[NDCG]] under Concepts (count: 24 → 25)

## 2026-05-22 — Claude Code (/update-index)
- **operation**: update-index
- **files touched**: `_meta/index.md`
- **notes**: 73 pages indexed — Concepts (25), Methods & Techniques (14), Models (4), Benchmarks & Evaluation (6), Infrastructure & Tools (24); added NDCG and Precision and Recall to Concepts; added Infinity, Milvus, RAGFlow to Tools

## 2026-05-22 — Claude Code (/lint-wiki)
- **operation**: lint-wiki
- **files touched**: `_meta/lint-2026-05-22.md`
- **notes**: 29 issues across 73 pages — 2 broken links, 1 malformed frontmatter, 5 orphans, 1 duplicate candidate pair, 20 uncited pages; 0 missing frontmatter fields, 0 empty stubs, 0 new contradictions

## 2026-06-18 — Claude Code (/ingest)
- **operation**: ingest
- **source**: 2605.15184v1.pdf → `01_Sources/papers/sen2026grep.md` (Sen et al. 2026, "Is Grep All You Need? How Agent Harnesses Reshape Agentic Search")
- **files touched**:
  - `01_Sources/papers/sen2026grep.md` — CREATED: literature note (summarized)
  - `02_Wiki/concepts/Agentic Search.md` — CREATED: concept page
  - `02_Wiki/concepts/Agent Harness.md` — CREATED: concept page (custom vs provider-native CLI; inline vs file-based tool calling)
  - `02_Wiki/concepts/Context Rot.md` — CREATED: concept page
  - `02_Wiki/benchmarks/LongMemEval.md` — CREATED: benchmark page (LongMemEval-S, 6 categories, GPT-4o grader)
  - `02_Wiki/methods/ReAct.md` — CREATED: method page
  - `02_Wiki/concepts/Dense Retrieval.md` — UPDATED: added "In agentic search" section + related/sources
  - `02_Wiki/concepts/Sparse Retrieval.md` — UPDATED: added "Grep as agentic lexical search" section + related/sources
  - `02_Wiki/methods/Hybrid Search.md` — UPDATED: added "Hybrid routing in agents" section + related/sources
  - `02_Wiki/benchmarks/BEIR.md` — UPDATED: added static-pipeline caveat (agent-scaffolding variance) + related/sources
- **notes**: key claim — in agentic long-memory QA, grep > vector on average and inline grep beats inline vector for every harness–model pair, but harness + tool-calling mode (inline vs file-based) shift or invert the result. Uncited canonical refs (ReAct/Yao 2023, Lost-in-the-Middle/Liu 2024, BM25/Robertson 2009) marked with [!todo] Source needed. Chronos (authors' prior temporal-memory harness, arXiv:2603.16862) mentioned inline rather than given its own page.

## 2026-06-18 — Claude Code (/lint-wiki)
- **operation**: lint-wiki
- **files touched**: `_meta/lint-2026-06-18.md`
- **notes**: 43 issues across 78 pages — 15 distinct broken-link targets (87 occurrences; 10 are unresolved source citekeys whose papers exist under descriptive filenames, 4 intra-wiki formatting errors, 1 malformed alias), 6 orphans, 0 missing frontmatter, 0 empty stubs, 1 duplicate/alias-collision candidate (BM25), 2 wanted pages (SPLADE, Chronos), 0 new contradictions (C1 standing), 19 uncited pages. Root cause of most broken links: literature notes not named by citekey per CLAUDE.md §3.
