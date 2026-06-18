---
type: paper
citekey: sen2026grep
title: "Is Grep All You Need? How Agent Harnesses Reshape Agentic Search"
authors: [Sahil Sen, Akhil Kasturi, Elias Lumer, Anmol Gulati, Vamse Kumar Subbiah]
year: 2026
venue: arXiv
url: https://arxiv.org/abs/2605.15184
pdf: "[[2605.15184v1.pdf]]"
tags: [paper, rag, retrieval, agentic-search, evaluation, long-context]
status: summarized
added: 2026-06-17
added_by: Claude Code
---

# Is Grep All You Need? How Agent Harnesses Reshape Agentic Search

> **TL;DR** An empirical study (PwC) over a 116-question [[LongMemEval]] subset showing that in agentic search, lexical retrieval (`grep`) generally beats dense/vector retrieval — inline `grep` exceeds inline vector for *every* harness–model pair — but the result is not a property of the retriever alone: the [[Agent Harness]] (custom vs provider-native CLI) and the tool-calling architecture (inline vs file-based/programmatic) can invert or erase the lexical advantage even when the corpus is byte-identical.

## Why we read it
First systematic comparison of retrieval strategy *interacting with* agent architecture and tool-calling paradigm, rather than evaluating retrievers in isolation. Directly relevant to how the team should think about [[Agentic Search]], harness choice, and what static IR benchmarks like [[BEIR]] miss.

## Problem
Existing literature benchmarks retrieval (lexical vs dense, chunking, reranking) in **standalone pipelines** that assume a fixed query matched against an index and the top-k concatenated into a prompt. Modern agents instead run an iterative, tool-mediated retrieval loop: the agent decides what to search, how many queries to issue, and whether results suffice — all mediated by the [[Agent Harness]] and its tool-calling interface. Two under-examined dimensions: (1) how retrieval results are *presented* (injected inline vs written to files the agent must read), and (2) robustness as the ratio of irrelevant to relevant material (noise/scale) grows.

## Contribution
- **Retrieval, harness, and presentation**: evidence on how lexical-vs-dense choice combines with the orchestration layer and with whether tool outputs are surfaced inline or through files.
- **Noise and scale**: characterization of how end-to-end behavior evolves as irrelevant surrounding content grows relative to task-relevant material.
- **Heterogeneity across agent stacks**: a direct comparison showing retrieval effectiveness is *not stable* across architecturally distinct harnesses (custom vs provider-native CLIs) even with the text corpus held fixed.

## Method
Two experiments on a 116-question subset of [[LongMemEval]] (LongMemEval-S), which tests answering over long multi-session conversations. Questions span six categories: knowledge-update, multi-session, single-session-assistant, single-session-preference, single-session-user, temporal-reasoning.

- **Retrieval implementations** operate over per-question files where conversation turns and structured temporal events are serialized via **Chronos** (the authors' temporal-event preprocessing pipeline / custom harness, arXiv:2603.16862). Lexical = `grep` (regex over raw text, no embedding model/index). Semantic = vector search (embed turns+events into a per-question index, ANN + reranking). See [[Dense Retrieval]], [[Sparse Retrieval]].
- **Agent harnesses** (see [[Agent Harness]]): one **custom harness** (Chronos, built on [[LangChain]]) and three **provider-native CLI harnesses** — Claude Code (Anthropic), Codex CLI (OpenAI), Gemini CLI (Google).
- **Tool-calling architectures**: **Standard / Inline** (results appended to the conversation context) vs **Programmatic / File-based** (results written to disk; the agent must `grep`/`cat`/`read_file` to access them).
- **Models** (5): Claude Opus 4.6, Claude Haiku 4.5, GPT-5.4, Gemini 3.1 Pro, Gemini 3.1 Flash-Lite.
- **Evaluation**: [[LLM-as-Judge]] with GPT-4o as the metric model, following the LongMemEval protocol; accuracy = fraction of questions the grader affirms.

**Experiment 1** isolates retrieval mode × harness × tool-calling method on the full per-question haystack. **Experiment 2** sweeps per-question session limits (s5, s10, s20, s30, full = 39–66 sessions) for grep-only vs vector-only, holding oracle sessions and filling remaining slots with sampled distractors, to study robustness as noise accumulates.

## Results
- **Inline lexical > inline dense, universally**: inline `grep` exceeds inline vector for every harness–model pair in Experiment 1. Largest margin: Chronos with Gemini 3.1 Flash-Lite (86.2% vs 62.9%); narrowest: Claude Code with Claude Opus 4.6 (76.7% vs 75.0%). [[LongMemEval]]
- **Harness matters as much as the retriever**: same Claude Opus 4.6 backbone reaches 93.1% inline grep under Chronos but 76.7% under Claude Code — changing the harness shifts the ceiling by roughly as much as swapping retrievers within a fixed harness.
- **Programmatic delivery reshuffles the comparison**: file-based vector exceeds file-based grep on five of ten harness–model pairs, while programmatic grep stays higher on others. Sharpest regression: Codex with GPT-5.4 drops from 93.1% inline grep to 55.2% programmatic grep (vector at 67.2%) — a cautionary tale that "cheap retrieval (regex over local JSON) is not *easy* end-to-end when the harness turns each hit into a multi-step read–integrate–retry the model executes unreliably."
- **Experiment 2 (scaling)**: both methods degrade only mildly as noise grows; grep > vector on average (mean 83.6% grep vs 78.4% vector). Trajectories are *not monotone* and cross depending on backbone and harness; retrieval families do not degrade in parallel as noise increases.
- **Stable provider biases**: Claude Code favors grep for Opus/Haiku at every configuration; Gemini CLI favors vector for Gemini 3.1 Pro throughout — suggesting harness-level inductive biases (default hints, how stdout is chunked, tool-error surfaces).

## Critique / Limitations
- Conclusions are tied to **long-memory conversational QA**, where answers often license on verbatim spans (dates, counts, preferences) — exactly where lexical tools are disproportionately helpful. The authors explicitly do **not** claim grep beats vector in general; in paraphrase-heavy or semantic-synthesis domains, dense/hybrid routing may win.
- No Codex vector intermediate-scaling rows yet, so the strongest cross-experiment claim is conditional.
- Tables do not isolate query strings or retrieved sets (no trace-level causal attribution); harness-level effects are hypothesized, not mechanistically proven.
- Practical takeaway for benchmarks: reporting only [[BM25]] vs ANN in a static pipeline *under-estimates the variance introduced by agent scaffolding* — "retrieval" in an agent is really retrieval-plus-orchestration. [[BEIR]]

## Connections to other sources
- Builds the corpus/task on [[LongMemEval]] (Wu et al. 2025).
- Uses [[LangChain]] for the custom Chronos harness; Chronos = the authors' prior work on temporal-aware long-memory retrieval (arXiv:2603.16862).
- Cites the [[ReAct]] paradigm (Yao et al. 2023) as the dominant pattern for custom harnesses.
- References "context rot" / Lost-in-the-Middle as motivation for file-based delivery — see [[Context Rot]].
- Contrast to static-pipeline retrieval framing in [[BEIR]]; complements lexical-vs-dense discussion in [[Dense Retrieval]] / [[Sparse Retrieval]] / [[Hybrid Search]].

## Relevant quotes
> "Across Chronos and the provider CLIs, grep generally yields higher accuracy than vector retrieval in our comparisons; at the same time, overall scores still depend strongly on which harness and tool-calling style is used, even when the underlying conversation data are the same." (Abstract)

> "'retrieval' in Table 1 is really retrieval-plus-orchestration. ... reporting only BM25 vs. ANN in a static pipeline under-estimates the variance introduced by agent scaffolding." (§4.1.4)
