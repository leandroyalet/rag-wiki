---
type: method
aliases: [ReAct, Reason+Act, reasoning and acting]
tags: [method, agents, agentic-search, prompting]
status: stub
created: 2026-06-18
updated: 2026-06-18
sources: ["[[sen2026grep]]"]
introduced_by: Yao et al.
year: 2023
---

# ReAct

> **TL;DR** An agent pattern that interleaves reasoning traces ("thoughts") with tool actions, letting an LLM plan, act, observe, and refine in a loop — the most widely adopted pattern for custom agent harnesses.

## Problem it solves
A single-shot LLM cannot adaptively gather evidence: it must commit to an answer from whatever is in context. ReAct lets the model reason about what it needs, take an action to obtain it, observe the result, and iterate — enabling tool-mediated, multi-step problem solving such as [[Agentic Search]].

## Key idea
Interleave free-form **reasoning traces** with **tool actions** in the generation stream (Thought → Action → Observation → Thought …). The reasoning steps let the model decompose the task and decide the next action; the actions ground the reasoning in external tool results. [[sen2026grep]]

## Pipeline / Steps
1. **Thought** — the model reasons about the current state and what to do next.
2. **Action** — it issues a tool call (e.g. a search/`grep`/vector query).
3. **Observation** — the tool result is fed back into the context.
4. Repeat until the model decides it has enough to answer, then it produces a final response.

## Reference implementations
- The dominant pattern for **custom [[Agent Harness|harnesses]]** built on agent frameworks / provider SDKs (e.g. [[LangChain]]). [[sen2026grep]]

## When to use / when not to
- ✅ Tasks needing iterative evidence gathering, tool use, or multi-hop retrieval.
- ✅ When you want explicit, inspectable reasoning interleaved with actions.
- ❌ Adds latency and tokens vs single-shot; overkill for simple single-retrieval queries.

## Related / alternatives
- [[Agentic Search]]
- [[Agent Harness]]
- [[Multi-hop Retrieval]]

## Sources
- [[sen2026grep]]
> [!todo] Source needed — Yao et al. (2023) "ReAct: Synergizing Reasoning and Acting in Language Models" (ICLR) is the canonical reference; not yet in 01_Sources/
