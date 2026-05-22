---
type: tool
aliases: [docling-project, IBM Docling]
tags: [rag, tool, document-processing, ingestion, parsing]
status: stub
created: 2026-04-19
updated: 2026-04-19
sources: []
---

# Docling

> **TL;DR** IBM Research's open-source document parser that converts PDFs, DOCX, PPTX, HTML, and other formats into clean Markdown or structured JSON — the ingestion layer before chunking in a RAG pipeline.

## What it is
Docling is a document understanding library (MIT license) maintained by IBM Research Zurich under the LF AI & Data Foundation. It goes beyond simple text extraction: it detects layout, reading order, table structure, code blocks, and mathematical formulas before producing structured output.

**Input formats**: PDF, DOCX, PPTX, XLSX, HTML, images (PNG/TIFF/JPEG), LaTeX, plain text, audio (WAV/MP3 via ASR), and domain-specific XML schemas (USPTO patents, JATS articles, XBRL financial reports).

**Output formats**: Markdown, HTML, JSON (DoclingDocument), WebVTT, DocTags.

## Where it fits in the RAG pipeline
Docling sits at **Phase 1 (Offline/Ingestion)** — before [[Chunking]] and [[Embeddings]]:

```
Raw files → Docling (parse + structure) → Chunks → Embeddings → Vector Database
```

Its structured JSON output preserves document hierarchy (headings, tables, figures), enabling structure-aware [[Chunking]] strategies that respect semantic boundaries rather than cutting on fixed token counts.

## Key features
- **Advanced PDF understanding**: layout analysis, reading order detection — handles multi-column, scanned, and figure-heavy PDFs.
- **Table extraction**: reconstructs table structure as proper rows/columns, not flat text.
- **OCR**: handles scanned documents via integrated OCR.
- **Visual Language Model support**: GraniteDocling VLM for complex visual layouts.
- **MCP server**: exposes Docling as a tool for agentic pipelines.
- **Local execution**: processes sensitive documents without sending data to external APIs.

## Integrations
Plug-and-play connectors for [[LangChain]], [[LlamaIndex]], Crew AI, and Haystack. Also works with Data Prep Kit for chunking and tokenization post-parsing. [[RAGFlow]] uses Docling as one of its document parsing backends alongside MinerU. [[01_Sources/web_clips/infiniflow-ragflow-infinity]]

## When to use it
- ✅ RAG corpus contains PDFs, slide decks, or Word documents with non-trivial layout (tables, multi-column, figures).
- ✅ Scanned or image-heavy documents need OCR before embedding.
- ✅ Structure-aware chunking is desired (split on headings, not on fixed token counts).
- ✅ Data sensitivity requires local, self-hosted processing.
- ❌ Corpus is already clean plain text or Markdown — overhead not justified.

## Related pages
- [[Chunking]]
- [[Embeddings]]
- [[LangChain]]
- [[LlamaIndex]]
- [[Retrieval-Augmented Generation]]
- [[RAGFlow]] — uses Docling as a parsing backend
- [[MarkItDown]] — Microsoft's lighter-weight alternative

## Sources
> [!todo] Source needed — no paper in 01_Sources/ yet; information from docling-project.github.io
