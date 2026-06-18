---
type: concept
aliases: [agentic retrieval, agent-directed retrieval, tool-mediated retrieval]
tags: [rag, retrieval, agents, agentic-search]
status: stub
created: 2026-06-18
updated: 2026-06-18
sources: ["[[sen2026grep]]"]
---

# Agentic Search

> **TL;DR** Retrieval that is iterative and agent-directed: an LLM agent decides what to search, how many queries to issue, and whether results suffice — rather than a fixed query matched once against an index and the top-k concatenated into a prompt.

## Definition
Agentic search is the process by which an LLM agent identifies, executes, and consumes search operations over a corpus to answer a user query. Unlike standalone retrieval pipelines — where a fixed query is matched against a static index and the top-k results are concatenated into a prompt — agentic retrieval is iterative and agent-directed: the model decides *what* to search for, *how many* queries to issue, and *whether* the retrieved results are sufficient or require refinement. [[sen2026grep]]

## Context
This is the retrieval regime of modern tool-using LLM agents (see [[ReAct]]), as opposed to the single-shot retrieval of classic [[Retrieval-Augmented Generation]]. Agents receive ranked lists but do not treat them as terminal — they iterate. The effectiveness of any retrieval strategy in this setting is mediated by two design dimensions that jointly determine end-to-end behavior: the **retrieval strategy** (lexical, semantic, or hybrid) and the **[[Agent Harness]]** (custom vs provider-native CLI). [[sen2026grep]]

## How it works
1. The agent reads the question and decides on an initial search strategy (terms, flags, file targets).
2. It issues a tool call — e.g. `grep` ([[Sparse Retrieval]]) or a vector query ([[Dense Retrieval]]) — and inspects the returned hits.
3. Based on the results it may refine, broaden, or issue further queries (the tool-calling loop).
4. The loop continues until the model judges it has enough evidence, then it produces an answer.

When `grep` is available as a native bash tool, the boundary between "retrieval strategy" and "agent capability" blurs: the agent constructs its own search commands and targets dynamically rather than calling a predefined search API. [[sen2026grep]]

## Key finding — retrieval is not stable across stacks
A core empirical result is that retrieval effectiveness is **not a property of the retriever alone**. Across a 116-question [[LongMemEval]] study, lexical `grep` generally beat dense/vector retrieval, and inline grep exceeded inline vector for every harness–model pair — yet the same backbone could shift by ~16 points (e.g. Claude Opus 4.6: 93.1% under the Chronos harness vs 76.7% under Claude Code) purely from changing the harness, and file-based ("programmatic") result delivery could invert or erase the lexical advantage. "Retrieval" in an agent is therefore really **retrieval-plus-orchestration**. [[sen2026grep]]

## Trade-offs
- ✅ Adaptive: the agent can issue follow-up queries and recover from a weak first retrieval.
- ✅ With native bash `grep`, no embedding model or index is needed; the agent improvises search.
- ❌ End-to-end accuracy depends heavily on the harness and on how results are presented (inline vs file-based), adding variance that static IR benchmarks do not capture. [[sen2026grep]]
- ❌ Multi-step file-based retrieval can be brittle: weaker models execute the read–integrate–retry loop unreliably. [[sen2026grep]]

## Related pages
- [[Agent Harness]]
- [[ReAct]]
- [[Retrieval-Augmented Generation]]
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Hybrid Search]]
- [[LongMemEval]]

## Sources
- [[sen2026grep]]
