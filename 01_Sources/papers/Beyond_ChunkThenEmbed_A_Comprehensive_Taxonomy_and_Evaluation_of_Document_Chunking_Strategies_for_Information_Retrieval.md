---
title: "Beyond Chunk-Then-Embed: A Comprehensive Taxonomy and Evaluation of Document Chunking Strategies for Information Retrieval"
authors: "Yongjie Zhou, Shuai Wang, Bevan Koopman, Guido Zuccon"
citekey: zhou2026chunktaxonomy
aliases: [zhou2026chunktaxonomy]
year: 2026
venue: "ArXiv"
url: "https://arxiv.org/abs/2602.16974"
tags: [paper, arxiv, chunking, information-retrieval]
status: summarized
added_by: Pablo
---

# Beyond Chunk-Then-Embed: A Comprehensive Taxonomy and Evaluation of Document Chunking Strategies for Information Retrieval

## Summary
Systematic reproduction and unified taxonomy of chunking strategies along two dimensions.

**Taxonomy dimensions:**
1. **Segmentation method** — fixed-size, sentence, paragraph (structure-based); semantic similarity split; DenseX (proposition-based via LLM); LumberChunker (LLM topic-shift detection).
2. **Embedding timing** — *pre-embedding chunking* (segment first, embed each chunk independently) vs. *contextualized chunking / Late Chunking* (embed full document with long-context model, then segment token-level embeddings).

**Key methods:**
- **DenseX** — LLM decomposes text into atomic propositions; each proposition is a chunk.
- **LumberChunker** — LLM inserts breakpoints between paragraphs where it detects a topic shift.
- **Late Chunking** — embed entire document first (long-context model), then segment at the embedding level to preserve full context.

**Key results:**
| Task | Best segmentation | Best embedding timing |
|------|------------------|-----------------------|
| In-corpus retrieval | Structure-based (paragraph/fixed-size) | Pre-embedding; Late Chunking adds +22–27% for LLM-guided |
| In-document (needle-in-haystack) | LumberChunker (+10–30% over paragraph) | Pre-embedding (Late Chunking degrades) |

- Proposition-based (DenseX): 15–27% effectiveness *loss* vs. paragraph for in-corpus.
- Chunk size: moderate correlation with in-document effectiveness, weak with in-corpus — method matters beyond size.

## Abstract
Document chunking is a critical preprocessing step in dense retrieval systems, yet the design space of chunking strategies remains poorly understood. Recent research has proposed several concurrent approaches, including LLM-guided methods (e.g., DenseX and LumberChunker) and contextualized strategies (e.g., Late Chunking), which generate embeddings before segmentation to preserve contextual information. However, these methods emerged independently and were evaluated on benchmarks with minimal overlap, making direct comparisons difficult. This paper reproduces prior studies in document chunking and presents a systematic framework that unifies existing strategies along two key dimensions: (1) segmentation methods, including structure-based methods (fixed-size, sentence-based, and paragraph-based) as well as semantically-informed and LLM-guided methods; and (2) embedding paradigms, which determine the timing of chunking relative to embedding (pre-embedding chunking vs. contextualized chunking). Our reproduction evaluates these approaches in two distinct retrieval settings: in-document retrieval (needle-in-a-haystack) and in-corpus retrieval (the standard IR task). Optimal chunking strategies are task-dependent: simple structure-based methods outperform LLM-guided alternatives for in-corpus retrieval, while LumberChunker performs best for in-document retrieval. Contextualized chunking improves in-corpus effectiveness but degrades in-document retrieval. Chunk size correlates moderately with in-document but weakly with in-corpus effectiveness.
