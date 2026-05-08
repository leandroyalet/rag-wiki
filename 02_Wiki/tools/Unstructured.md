---
type: tool
aliases: [unstructured-io, Unstructured.IO, unstructured-ingest]
tags: [rag, tool, document-processing, ingestion, parsing, ocr]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: []
homepage: https://unstructured.io
repo: https://github.com/Unstructured-IO/unstructured
docs: https://docs.unstructured.io
year: 2022
---

# Unstructured

> **TL;DR** Open-source Python toolkit (Apache-2.0) that partitions documents into typed semantic elements (Title, NarrativeText, Table, …) before chunking — the most widely-adopted open-source ingestion layer for RAG pipelines, with 20+ source/destination connectors and native LangChain/LlamaIndex integrations.

## What it is
Unstructured (by Unstructured-IO) is a document-preprocessing library focused on converting raw documents into structured, typed element lists ready for downstream chunking and embedding. Unlike tools that produce plain text or Markdown, Unstructured returns **document element objects** with type labels and rich metadata — enabling structure-aware chunking strategies that respect section boundaries, tables, and page breaks.

**License**: Apache-2.0 (fully open source). A commercial **Unstructured Platform** adds hosted API access, table enrichment, and advanced chunking.

**Adoption**: 14.7k GitHub stars, 1.2k forks, 225+ releases (as of 2025).

## Core concept: element objects
Every partitioning call returns a list of `Element` objects rather than raw text. Each element carries:
- **Type** — semantic role of the content
- **Text** — the extracted string
- **Metadata** — page number, filename, coordinates, section, language, parent ID, etc.

| Element type | Meaning |
|---|---|
| `Title` | Section heading |
| `NarrativeText` | Body paragraph |
| `ListItem` | Bullet or numbered list item |
| `Table` | Tabular data (also as `text_as_html`) |
| `Image` | Embedded image reference |
| `Header` / `Footer` | Page header or footer |
| `Subject` / `Sender` / `Recipient` | Email-specific metadata fields |
| `PageBreak` | Explicit page boundary marker |

## How it works

```python
from unstructured.partition.auto import partition

# Auto-detect format and partition
elements = partition(filename="report.pdf", strategy="hi_res")

for el in elements:
    print(type(el).__name__, el.text[:80])
    # Title  "Q3 2024 Financial Results"
    # NarrativeText  "Revenue increased by 12% year-over-year..."
    # Table  "Region | Revenue | YoY\nNorth America | $4.2B | +8%..."
```

```python
# Format-specific — more control
from unstructured.partition.pdf import partition_pdf
elements = partition_pdf(
    "scanned_report.pdf",
    strategy="hi_res",
    languages=["eng", "deu"],
)
```

## Supported formats

| Category | Formats |
|---|---|
| **Documents** | PDF, DOCX, DOC, ODT, RTF, EPUB, ORG |
| **Presentations** | PPTX, PPT |
| **Spreadsheets** | XLSX, XLS, CSV, TSV |
| **Web** | HTML, XML |
| **Email** | EML, MSG |
| **Text / Markup** | TXT, Markdown, RST |
| **Images** | PNG, JPG, JPEG, HEIC |

## Partitioning strategies
Strategies are set per call with `strategy=`:

| Strategy | Engine | Best for |
|---|---|---|
| `auto` | Chooses below automatically | General-purpose default |
| `fast` | pdfminer (text extraction) | PDFs with selectable text; lowest latency |
| `hi_res` | Detectron2 layout model | Layout-sensitive docs; tables, multi-column |
| `ocr_only` | Tesseract OCR | Scanned PDFs and image-only documents |

`hi_res` is the most relevant mode for RAG — it uses a computer-vision layout detection model to identify where titles, paragraphs, tables, and images are on the page, rather than relying on PDF text coordinates.

## Chunking strategies
Applied after partitioning via `chunk_by_title()` or `chunk_basic()`:

| Strategy | How it works | When to use |
|---|---|---|
| `basic` | Combines sequential elements up to `max_characters`; never merges Tables | Default; format-agnostic |
| `by_title` | Starts a new chunk at every `Title` element; respects `multipage_sections` | Documents with clear headings; preserves section context |

Because chunking is performed on typed elements rather than raw text, `by_title` can identify section boundaries without heuristics — it simply breaks on `Title` objects.

## System dependencies
Unstructured is heavy on system packages:

| Dependency | Purpose |
|---|---|
| `libmagic-dev` | File-type detection |
| `poppler-utils` | PDF text extraction (fast strategy) |
| `tesseract-ocr` | OCR for images and scanned PDFs |
| `libreoffice` | DOC, PPT, ODP → DOCX conversion |
| `pandoc` | ODT, EPUB, RST, ORG, RTF → HTML conversion |

```bash
pip install "unstructured[pdf,docx,pptx]"
```
Format-specific extras (e.g., `[pdf]`, `[docx]`) install the Python bindings; the underlying system packages must be installed separately.

## Integrations
- **[[LangChain]]**: `UnstructuredFileLoader` — drop-in document loader.
- **[[LlamaIndex]]**: `UnstructuredReader` — ingests elements directly into an index.
- **20+ connectors** via `unstructured-ingest` CLI: S3, GCS, Azure Blob, SharePoint, Confluence, Slack, Notion, GitHub, Salesforce, and more.
- **Docker images**: `downloads.unstructured.io/unstructured-io/unstructured` — pre-bundled with all system dependencies (recommended for production).

## Comparison with similar tools

| | Unstructured | [[Docling]] | [[MarkItDown]] | [[Kreuzberg]] |
|---|---|---|---|---|
| Output model | Typed element objects | Markdown / DoclingDocument JSON | Markdown | Markdown / TOON |
| Structure awareness | ✅ (Detectron2 hi_res) | ✅ (transformer layout) | ❌ | Partial |
| OCR | Tesseract, hi_res | EasyOCR, Tesseract | ❌ | Tesseract, PaddleOCR, EasyOCR, VLMs |
| LangChain / LlamaIndex | ✅ native loaders | ✅ | ❌ | ❌ |
| Source connectors | ✅ 20+ | ❌ | ❌ | ❌ |
| License | Apache-2.0 | MIT | MIT | ELv2 |
| Language | Python | Python | Python | Rust + 10 bindings |
| System deps | Heavy (libreoffice, poppler, tesseract) | Moderate | Light | Moderate |

## When to use it

- ✅ RAG pipeline needs structure-aware chunking — `by_title` on element objects is more reliable than regex-based heading detection.
- ✅ Existing LangChain/LlamaIndex stack — native loaders require zero glue code.
- ✅ Ingesting from cloud storage or SaaS (S3, Confluence, Notion) — `unstructured-ingest` connectors handle auth and batching.
- ✅ Mixed document corpus with tables and images — typed element output preserves table HTML for downstream rendering.
- ❌ Minimal-dependency environments — system package requirements (libreoffice, poppler) are not installable everywhere; use MarkItDown instead.
- ❌ Code-centric corpora — no code intelligence; Kreuzberg's tree-sitter integration is better.
- ❌ High-throughput batch processing — Python-only, no Rust core; Kreuzberg is faster.

## Related pages
- [[Docling]]
- [[MarkItDown]]
- [[Kreuzberg]]
- [[Chunking]] — Unstructured's typed elements enable structure-aware chunking strategies
- [[LangChain]]
- [[LlamaIndex]]
- [[Retrieval-Augmented Generation]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/ yet; information from docs.unstructured.io and github.com/Unstructured-IO/unstructured
