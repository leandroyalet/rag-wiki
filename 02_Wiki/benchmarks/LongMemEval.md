---
type: benchmark
aliases: [LongMemEval-S, Long-Memory Evaluation]
tags: [benchmark, eval, long-context, memory, agents]
status: stub
created: 2026-06-18
updated: 2026-06-18
sources: ["[[sen2026grep]]"]
homepage: 
repo: 
docs: 
year: 2025
---

# LongMemEval

> **TL;DR** A benchmark for an agent's ability to answer questions over long, multi-session conversations spanning many turns — testing long-term interactive memory rather than single-document retrieval.

## What it measures
LongMemEval (Wu et al., ICLR 2025) tests an agent's ability to answer questions over long conversations spanning multiple sessions. Each question comes with sessions of a certain type: one or more **oracle sessions** containing the information needed to answer correctly, plus a variable number of **distractor sessions** that are irrelevant to the query. It stresses long-term conversational memory and the ability to locate relevant evidence in a noisy, multi-session haystack. [[sen2026grep]]

## Question categories
Questions span six categories: [[sen2026grep]]
- **Knowledge-update (KU)** — tracking state that changes over time.
- **Multi-session (MS)** — aggregating information across sessions.
- **Single-session-assistant (SS-A)** — recalling model-generated content.
- **Single-session-preference (SS-P)** — user personal preferences.
- **Single-session-user (SS-U)** — user-stated facts.
- **Temporal-reasoning (TR)** — computing durations, ordering events, resolving dates.

## Variants
- **LongMemEval-S** — the smaller subset; [[sen2026grep]] uses a 116-question slice of it. Full per-question haystacks range ~39–66 sessions.

## Metrics
| Metric | Description | Range |
|--------|-------------|-------|
| Accuracy | Fraction of questions a judge marks correct vs the reference answer | 0–100% |

Evaluation uses an [[LLM-as-Judge]] grader. [[sen2026grep]] instantiate GPT-4o as the metric model: the grader sees the question, reference answer, and the agent's hypothesis and outputs a binary judgment under category-conditioned instructions (tolerance for off-by-one temporal counts, rubric scoring for preferences, `_abs` variant handling).

## Reported baselines
From [[sen2026grep]] (Chronos custom harness, grep-only, inline, full haystack, n=116, grader GPT-4o):
- Claude Opus 4.6 — 93.1% overall; per-category KU 94.4 / MS 83.9 / SS-A 100 / SS-P 100 / SS-U 87.5 / TR 87.1.
- GPT-5.4 — 89.7% overall (weaker on TR at 67.7).
- Gemini 3.1 Pro — 91.4% overall.
- Mean across the study: grep 83.6% vs vector 78.4%. Scores vary widely by [[Agent Harness]] and tool-calling mode (see [[Agentic Search]]).

## Limitations / caveats
- Answers often license on **verbatim spans** (exact dates, counts, preferences, user facts), which disproportionately favors lexical/`grep` retrieval over dense retrieval — results may not transfer to paraphrase-heavy or semantic-synthesis domains. [[sen2026grep]]
- Distractors are resampled when the session limit changes, so mid-grid peaks are not absolute difficulty signals.

## Related benchmarks
- [[BEIR]] — static-pipeline retrieval benchmark; [[sen2026grep]] argues such benchmarks under-estimate the variance agent scaffolding introduces.

## Sources
- [[sen2026grep]]
