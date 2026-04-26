---
type: tool
aliases: [markitdown, Microsoft MarkItDown]
tags: [rag, tool, document-processing, ingestion, parsing]
status: stub
created: 2026-04-22
updated: 2026-04-22
sources: []
homepage: https://github.com/microsoft/markitdown
repo: https://github.com/microsoft/markitdown
---

# MarkItDown

> **TL;DR** Microsoft's lightweight Python utility that converts PDFs, Office files, images, audio, HTML, and more into Markdown — optimised for feeding LLM pipelines, not for human-readable output.

## What it is
MarkItDown is an open-source library (MIT license) by Microsoft that converts a wide range of file formats to Markdown for use in LLM and RAG pipelines. Unlike [[Docling]], which focuses on high-fidelity layout and structure analysis, MarkItDown prioritises simplicity and breadth of format support — the output is "extremely close to plain text" with just enough Markdown structure to represent headings, lists, and tables.

**Input formats**: PDF, Word (DOCX), PowerPoint (PPTX), Excel (XLSX), images (EXIF + OCR), audio (transcription), HTML, YouTube URLs, CSV, JSON, XML, ZIP archives, ePub.

**Output format**: Markdown (plain text with minimal markup).

**Requires**: Python ≥ 3.10.

## Where it fits in the RAG pipeline
Like [[Docling]], MarkItDown sits at the ingestion layer — before [[Chunking]] and [[Embeddings]]:

```
Raw files → MarkItDown (convert to Markdown) → Chunks → Embeddings → Vector Database
```

## Key features
| Feature | Description |
|---------|-------------|
| **Broad format support** | 12+ input types in a single library |
| **LLM integration** | Pass `llm_client` + `llm_model` for image descriptions via GPT-4o or equivalent |
| **Azure Document Intelligence** | Optional backend for higher-accuracy PDF parsing |
| **Plugin system** | Disabled by default; third-party plugins extend OCR and other capabilities |
| **CLI + Python API** | `markitdown file.pdf > out.md` or programmatic use |

## Usage

### CLI
```bash
pip install markitdown
markitdown path/to/file.pdf > output.md
```

### Python API
```python
from markitdown import MarkItDown

# Basic conversion
md = MarkItDown()
result = md.convert("report.pdf")
print(result.text_content)

# With LLM for image descriptions
from openai import OpenAI
md = MarkItDown(llm_client=OpenAI(), llm_model="gpt-4o")
result = md.convert("slide_deck.pptx")

# With Azure Document Intelligence (better PDF accuracy)
md = MarkItDown(docintel_endpoint="<your-endpoint>")
result = md.convert("scanned.pdf")
```

## MarkItDown vs Docling
| | MarkItDown | [[Docling]] |
|---|---|---|
| **Origin** | Microsoft | IBM Research |
| **Focus** | Breadth of formats, simplicity | Layout fidelity, structure analysis |
| **Table extraction** | Basic | Full row/column reconstruction |
| **OCR** | Via plugin / LLM | Built-in |
| **Structured output** | Markdown only | Markdown, JSON, HTML, DocTags |
| **Audio transcription** | ✅ | ✅ |
| **YouTube** | ✅ | ❌ |
| **Best for** | Quick ingestion, diverse file types | Complex PDFs, structure-aware chunking |

## When to use it
- ✅ Need to ingest a wide variety of file types with minimal setup.
- ✅ Audio or video content (YouTube, WAV/MP3) needs to enter the pipeline.
- ✅ Lightweight ingestion where layout fidelity is not critical.
- ❌ Complex multi-column PDFs or table-heavy documents — [[Docling]] gives better structure.
- ❌ Human-readable output required — MarkItDown's own docs warn it is for machines, not humans.

## Related pages
- [[Docling]]
- [[Chunking]]
- [[Embeddings]]
- [[Retrieval-Augmented Generation]]
- [[LangChain]]
- [[LlamaIndex]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/; information from github.com/microsoft/markitdown
