---
type: tool
aliases: [kreuzberg, goldziher/kreuzberg]
tags: [rag, tool, document-processing, ingestion, parsing, ocr]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: []
homepage: https://kreuzberg.dev
repo: https://github.com/Goldziher/kreuzberg
year: 2024
---

# Kreuzberg

> **TL;DR** Rust-core document extraction library with Python and 10+ language bindings — extracts text, metadata, tables, and code intelligence from 91+ file formats at native speeds, with multiple OCR backends and a token-efficient wire format for LLM/RAG pipelines.

## What it is
Kreuzberg (by Na'aman Hirschfeld) is a document-to-text extraction engine built on a Rust core with bindings for Python, Node.js/TypeScript, Ruby, Go, Java, C#, PHP, Elixir, R, and C. It targets the ingestion layer of RAG and LLM pipelines, covering a broader format surface than [[Docling]] or [[MarkItDown]] and adding code intelligence as a first-class feature.

**License**: Elastic License 2.0 (ELv2) — source-available but with commercial use restrictions; not OSI open source.

## Supported formats
91+ formats across 8 categories:

| Category | Formats |
|----------|---------|
| **Office** | DOCX, XLSX, PPTX, ODF variants, PDF, EPUB, FB2 |
| **Images** | PNG, JPG, TIFF, WebP, JP2 (OCR applied) |
| **Web / Data** | HTML, XML, JSON, YAML, CSV, Markdown |
| **Email / Archives** | EML, MSG, ZIP, TAR, 7Z |
| **Academic** | LaTeX, Jupyter notebooks, BibTeX, JATS articles |
| **Code** | 248 programming languages via tree-sitter |

## How it works

```python
from kreuzberg import extract_file, ExtractionConfig, OcrConfig

# Async extraction (recommended)
result = await extract_file("document.pdf")
print(result.content)          # extracted text
print(result.tables)           # list of structured tables
print(result.metadata)         # author, creation date, etc.

# With OCR config for scanned PDFs
config = ExtractionConfig(
    force_ocr=True,
    ocr=OcrConfig(backend="tesseract", language="eng")
)
result = await extract_file("scanned.pdf", config=config)
```

**Pipeline**:
1. Format detection from file extension or MIME type.
2. Format-specific parser (pure-Rust PDF, pandoc for Office, tree-sitter for code).
3. Optional OCR pass for image-based content.
4. Metadata extraction (author, dates, document properties).
5. Output serialization — Markdown (GFM via Comrak) or TOON wire format.

## Key features

**Multiple OCR backends**: Tesseract (via native bindings), PaddleOCR, EasyOCR. For difficult documents, Vision Language Model backends are supported: GPT-4o, Claude, Gemini, Ollama. Table detection and structure reconstruction included.

**Code intelligence**: Extracts functions, classes, imports, symbols, and docstrings from 248 languages via tree-sitter — enabling semantic chunking of code repositories without a separate AST tool.

**TOON wire format**: Token-efficient serialization optimized for LLM/RAG pipelines, ~30–50% fewer tokens than JSON — relevant when passing extraction results directly to an LLM context window.

**Streaming**: Memory-efficient parsers handle multi-GB files without loading the full document into memory.

**Batch processing**: Parallel extraction with configurable concurrency.

**Optional embeddings**: Vector embeddings via ONNX Runtime (optional dependency, no GPU required).

**Language detection**: Detects document language; useful for multi-lingual corpora.

## Performance
Rust core with SIMD optimizations and full parallelism; no GPU required.

| Format | Throughput | Memory |
|--------|-----------|--------|
| PDF (text-based) | 10–100 MB/s | ~50 MB |
| Office documents | 20–200 MB/s | ~100 MB |
| Images (with OCR) | 1–5 MB/s | variable |

Claimed 10–50× speed improvement over Python-native alternatives.

## Python specifics
- Python 3.10+
- `pip install kreuzberg` (sync) or `pip install kreuzberg[async]`
- Optional: `onnxruntime>=1.22` for embeddings, Tesseract system package for OCR

## Comparison with similar tools

| | Kreuzberg | [[Docling]] | [[MarkItDown]] |
|---|---|---|---|
| Core language | Rust | Python | Python |
| Language bindings | 10+ | Python only | Python only |
| Format support | 91+ | ~15 | ~20 |
| Code intelligence | ✅ tree-sitter | ❌ | ❌ |
| OCR backends | Tesseract, PaddleOCR, EasyOCR, VLMs | EasyOCR, Tesseract | ❌ (limited) |
| Token-efficient output | ✅ TOON | ❌ | ❌ |
| License | ELv2 (proprietary) | MIT | MIT |
| GPU required | ❌ | ❌ | ❌ |

## When to use it

- ✅ Mixed corpus with many formats (archives, emails, code, academic) — wider coverage than Docling or MarkItDown.
- ✅ Code-centric RAG — tree-sitter code intelligence is unique to Kreuzberg.
- ✅ Multi-language codebase needing Node.js, Go, or Java ingestion — only option with first-class bindings beyond Python.
- ✅ Token budget is tight — TOON format reduces context usage 30–50% vs JSON.
- ❌ Fully open-source requirement — ELv2 restricts commercial redistribution; use Docling instead.
- ❌ Layout-aware PDF extraction with reading-order detection — Docling's ML-based layout model is stronger.

## Related pages
- [[Docling]]
- [[MarkItDown]]
- [[Chunking]] — Kreuzberg's code intelligence enables semantic chunking of code files
- [[Retrieval-Augmented Generation]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/ yet; information from kreuzberg.dev and github.com/Goldziher/kreuzberg
