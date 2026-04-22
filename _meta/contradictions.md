---
type: meta
tags: [contradictions]
updated: 2026-04-21
---

# Detected contradictions

Claims in tension across sources. Found by hand or by `/lint-wiki`. Don't resolve hastily: record and discuss in a meeting.

Format:

```
### C{n} — title
- **Claim A**: "..." → [[sourceA]]
- **Claim B**: "..." → [[sourceB]]
- **Context**: why both can be true, or why one is outdated.
- **Tentative resolution**: ... (if any)
- **Status**: open | resolved | domain-specific
```

---

### C1 — Does RAG augmentation always improve generation quality?
- **Claim A**: "RAG substantially reduces hallucination rates vs. parametric-only generation by grounding outputs in retrieved evidence." → [[Retrieval-Augmented Generation]], [[oche2025ragsurvey]], [[lewis2020rag]]
- **Claim B**: "For strong models (GPT-4o, Claude-3.5 Sonnet), RAG augmentation *decreases* extraction coverage and introduces more hallucinations than base generation on well-documented domains." → [[Hallucination in RAG]], [[chatzikyriakidis2025raggedevents]]
- **Context**: Both can be simultaneously true. Claim A holds for smaller/weaker models and open-domain tasks where parametric knowledge is sparse. Claim B (inverse calibration principle) emerges when strong parametric knowledge conflicts with retrieved context, producing competing signals.
- **Tentative resolution**: Always evaluate a no-RAG baseline. RAG is not universally beneficial — benefit depends on model capability and domain coverage.
- **Status**: open
