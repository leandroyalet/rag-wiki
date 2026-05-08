---
type: tool
aliases: [instructor, python-instructor, useinstructor]
tags: [rag, tool, structured-output, extraction, pydantic, llm]
status: stub
created: 2026-05-08
updated: 2026-05-08
sources: []
homepage: https://python.useinstructor.com
repo: https://github.com/instructor-ai/instructor
year: 2023
---

# Instructor

> **TL;DR** Python library that wraps LLM clients (OpenAI, Anthropic, Gemini, and 12+ others) to enforce Pydantic-validated structured output — retrying with error feedback on validation failure until the model produces a conforming response.

## What it is
Instructor (by Jason Liu, `instructor-ai/instructor`) is a structured-output layer that sits between your code and any LLM provider. You define the expected response shape as a Pydantic `BaseModel`, pass it as `response_model=`, and Instructor handles the rest: schema conversion, provider-specific API formatting, response parsing, validation, and retry-with-feedback.

It is not a RAG framework, but it fills a critical slot in RAG pipelines: the **extraction layer** — ensuring LLM responses arrive as typed, validated Python objects rather than raw strings.

## How it works

```python
import instructor
from openai import OpenAI
from pydantic import BaseModel

class Entity(BaseModel):
    name: str
    entity_type: str
    confidence: float

client = instructor.from_provider("openai/gpt-4o-mini")
entity = client.chat.completions.create(
    messages=[{"role": "user", "content": "Extract entity from: 'Apple released the iPhone 16'"}],
    response_model=Entity,
)
# entity.name == "Apple", entity.entity_type == "company", entity.confidence == 0.97
```

**Pipeline**:
1. `from_provider()` wraps the native LLM client, intercepting `create()` calls.
2. The Pydantic model's JSON schema is converted to the provider's preferred format (tool definition, JSON schema, etc.).
3. The LLM response is parsed and validated against the model.
4. On `ValidationError`, the error message is appended to the conversation as a "reask" and the request is retried.
5. A valid Pydantic instance is returned to the caller.

## Output modes

| Mode | How it works | Default for |
|------|-------------|-------------|
| **TOOLS** | Schema passed as a function/tool definition; model calls the tool | OpenAI, Anthropic, Google |
| **JSON** | System prompt instructs direct JSON output | Most providers as fallback |
| **MD_JSON** | JSON wrapped in a markdown code block | Databricks, some older providers |

Override with `mode=instructor.Mode.JSON` when a provider doesn't support tool calling.

## Retry mechanism
Instructor integrates with [Tenacity](https://tenacity.readthedocs.io/) for retry strategies. When the LLM returns an invalid response, the `ValidationError` (with field-level detail) is fed back into the conversation so the model can self-correct:

```python
client = instructor.from_provider(
    "anthropic/claude-3-5-haiku-latest",
    max_retries=3,
)
```

Available strategies:
- **`max_retries`** — simple attempt cap (validation errors).
- **`retry_if_exception_type`** — retry only on specific exceptions (`RateLimitError`, `ValidationError`).
- **`retry_if_result`** — custom result predicate (e.g., confidence below threshold).
- **Exponential backoff** via `wait_exponential()` — recommended for rate limits.

Recommended defaults: 2–3 retries for validation errors, 5 for rate limits, 4 for network issues.

## Supported providers
15+ providers via `from_provider("provider/model")`: OpenAI, Anthropic, Google Gemini, Mistral, Cohere, DeepSeek, Ollama (local), llama-cpp-python (local), and others.

## Relevance to RAG

In a RAG pipeline, Instructor is useful at two points:

**1. Structured generation (output layer)**
After retrieval and generation, Instructor ensures the LLM's answer conforms to a schema — critical when downstream code needs to parse the response (e.g., filling a database row, populating a UI component, triggering an action).

**2. Metadata and entity extraction (ingestion layer)**
During document ingestion, Instructor can extract structured metadata (entities, dates, relations, chunk-level summaries) from raw text for enriching the index — a more reliable alternative to manual JSON parsing of LLM output.

**Not needed when**: the RAG system only needs free-text answers and has no downstream structured-data consumers.

## Streaming
Instructor supports partial streaming — the Pydantic model is populated incrementally as tokens arrive, allowing downstream code to act on fields as soon as they are validated rather than waiting for the full response.

## Adoption
3M+ monthly downloads, 11k GitHub stars, 100+ contributors (per docs, 2024).

## When to use it

- ✅ LLM output must be consumed by code (databases, APIs, UI fields) — free-text answers break parsers.
- ✅ Multi-provider codebase — `from_provider()` gives a uniform interface across OpenAI, Anthropic, Gemini, and local models.
- ✅ Extraction pipelines — entity recognition, metadata tagging, structured QA from retrieved chunks.
- ❌ Simple Q&A with no schema requirement — adds unnecessary overhead.
- ❌ Complex RAG orchestration — use [[LangChain]] or [[LlamaIndex]] as the outer framework; Instructor handles only the output contract.

## Related pages
- [[Retrieval-Augmented Generation]]
- [[Chunking]] — Instructor can extract structured metadata per chunk at ingestion time
- [[LangChain]]
- [[LlamaIndex]]

## Sources
> [!todo] Source needed — no paper in 01_Sources/ yet; information from python.useinstructor.com
