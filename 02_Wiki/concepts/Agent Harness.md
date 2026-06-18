---
type: concept
aliases: [agent harness, agent scaffolding, harness, provider-native CLI, custom harness]
tags: [rag, agents, agentic-search, orchestration]
status: stub
created: 2026-06-18
updated: 2026-06-18
sources: ["[[sen2026grep]]"]
---

# Agent Harness

> **TL;DR** The environment layer that manages an agent's tool-calling loop — it constructs the prompt, dispatches tool calls, receives results, and decides whether to keep iterating or produce an answer. The harness shapes retrieval effectiveness as much as the retriever itself.

## Definition
The agent harness is the environment layer that manages the tool-calling loop: it constructs the prompt, dispatches tool calls, receives results, and decides whether to continue iterating or produce a final answer. [[sen2026grep]]

## Two classes
The harness determines the degree of control afforded over the agentic loop. [[sen2026grep]] distinguishes two fundamentally different classes:

### Custom harnesses
Built by developers using agent frameworks, provider SDKs, or custom code (e.g. on [[LangChain]]). They provide fine-grained control over every stage of the loop: system prompt, tool definitions, context construction, result formatting, and iteration-termination criteria. The [[ReAct]] paradigm (interleaving reasoning traces with tool actions) is the most widely adopted pattern. Custom harnesses enable domain-specific optimizations — dynamic prompting, result-truncation policies, reranking of retrieved passages, and explicit management of the context window as the conversation grows. **Cost**: significant engineering overhead (prompt engineering, tool interface design, context management). [[sen2026grep]]

The paper's own **Chronos** harness is a custom harness built on [[LangChain]] with grep + vector tools over conversation turns and structured temporal events, using category-conditioned prompting. [[sen2026grep]]

### Provider-native CLI harnesses
Embed tool calling into a shell-based interface where the model has direct access to system utilities such as `grep`, `find`, `cat`, and other Unix tools as native actions. The harness manages context construction and iteration control according to the provider's internal, largely opaque implementation. Examples: **Claude Code** (Anthropic), **Codex CLI** (OpenAI), **Gemini CLI** (Google). **Cost**: minimal setup; leverages the provider's optimized context engineering, but sacrifices the fine-grained control of custom harnesses. [[sen2026grep]]

## Why it matters
Retrieval effectiveness is not stable across harnesses even when the corpus is byte-identical. In [[sen2026grep]], the same Claude Opus 4.6 backbone reached 93.1% inline-grep accuracy under the Chronos custom harness but 76.7% under Claude Code — changing the harness shifted the ceiling by roughly as much as swapping the retriever. Provider-native CLIs also show stable inductive biases (e.g. Claude Code favoring grep for Opus/Haiku, Gemini CLI favoring vector for Gemini 3.1 Pro) attributable to default hints, how stdout is chunked into the transcript, and tool-error surfaces. A harness is "not passive infrastructure." [[sen2026grep]]

## Tool-calling architectures (orthogonal dimension)
How results are delivered after a tool executes — a context-engineering decision:
- **Standard / Inline**: results returned as tool-response messages appended to the conversation context. Default for native function calling; simple, but large result sets compete for context-window space (see [[Context Rot]]). [[sen2026grep]]
- **Programmatic / File-based**: results written to disk; the model receives only a path/summary pointer and must take an explicit action (`grep`, `cat`, `read_file`) to access them. Decouples result size from context pressure but adds an indirect, latency-bearing step that weaker models execute unreliably. [[sen2026grep]]

## Related pages
- [[Agentic Search]]
- [[ReAct]]
- [[Context Rot]]
- [[LangChain]]
- [[LongMemEval]]

## Sources
- [[sen2026grep]]
