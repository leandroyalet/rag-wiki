---
type: concept
aliases: [context rot, context pressure, lost in the middle]
tags: [rag, long-context, agents]
status: stub
created: 2026-06-18
updated: 2026-06-18
sources: ["[[sen2026grep]]"]
---

# Context Rot

> **TL;DR** The degradation in LLM performance on long-horizon tasks as the context window fills with competing material — tool results, conversation history, and the system prompt crowd out the passages that matter.

## Definition
"Context rot" names the phenomenon where large result sets and accumulated history compete for context-window space with the system prompt and the task-relevant passages, degrading performance on long-horizon tasks. It is closely related to the "Lost in the Middle" effect (Liu et al., 2024), where models under-use information placed in the middle of a long context. [[sen2026grep]]

## Context
In [[Agentic Search]], each tool result is appended to the conversation (inline/standard tool calling), so a long agent loop steadily accumulates context pressure. This is the main motivation for **file-based / programmatic tool-calling** (see [[Agent Harness]]): writing results to disk and reading only a pointer or summary keeps arbitrarily large result sets out of the context window — at the cost of an extra read step the model must execute. [[sen2026grep]]

## Mitigations
- **Result truncation** — discard part of large tool results (risks dropping relevant info). [[sen2026grep]]
- **File-based delivery** — write results to disk; the agent reads only what it needs. [[sen2026grep]]
- **Summarizing / discarding earlier tool results** as the conversation grows.
- Precision-oriented retrieval ([[Reranking]], [[Hybrid Search]]) so fewer, better chunks enter the window.

## Trade-offs
- File-based delivery relieves context pressure but adds indirection and latency, and can *invert* into a net loss when weaker models fail the read–integrate–retry loop. [[sen2026grep]]

## Related pages
- [[Agent Harness]]
- [[Agentic Search]]
- [[Hallucination in RAG]]

## Sources
- [[sen2026grep]]
> [!todo] Source needed — Liu et al. (2024) "Lost in the Middle" (TACL) is the canonical reference for the effect; not yet in 01_Sources/
