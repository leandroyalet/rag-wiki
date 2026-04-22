---
type: meta
tags: [open-questions]
updated: 2026-04-18
---

# Open questions

Living list of questions the team **hasn't resolved yet**. Different from [[contradictions]] (which are claims in tension across sources). This is where open research questions live.

Format:

```
### Q{n} — short title
- **Question**: full statement.
- **Why it matters**: 1–2 sentences.
- **Status**: open | partial | probable-answer-pending-test
- **Hints / sources**: [[ ]]
- **Owner**: @person (if someone is looking at it)
```

---

### Q1 — Semantic chunking vs. fixed-size chunking?
- **Question**: under what conditions does chunking based on semantic boundaries beat fixed-token chunking with overlap?
- **Why it matters**: affects any pipeline from the very first step.
- **Status**: open
- **Hints / sources**: _(pending)_
- **Owner**: —

### Q2 — Local reranker vs. API: break-even point
- **Question**: above what query volume / day does a self-hosted reranker (bge-reranker, cross-encoder) beat an API (Cohere Rerank)?
- **Why it matters**: architecture and cost decision.
- **Status**: open
- **Hints / sources**: _(pending)_
- **Owner**: —

### Q3 — When does HyDE actually help?
- **Question**: in which query types does HyDE improve recall vs. when does it degrade it (noise from the hypothetical document's hallucinations)?
- **Why it matters**: it's a technique with mixed reputation; we want our own criteria.
- **Status**: open
- **Hints / sources**: [[HyDE]] _(stub)_
- **Owner**: —

---

_When a question is closed, move it to the "Resolved" section with the answer and sources._

## Resolved
- _(empty)_
