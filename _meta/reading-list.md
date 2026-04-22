---
type: meta
tags: [reading-list]
updated: 2026-04-18
---

# Reading list

Team-prioritized reading queue. When someone finishes a paper, tick the box and add the [[citekey]] as a link once the literature note is created in `01_Sources/papers/`.

If you use Dataview, you can autogenerate this list with:

```dataview
TABLE year, venue, added_by, status
FROM "01_Sources/papers"
WHERE status = "to-read"
SORT added desc
```

## High priority
- [ ] Lewis et al., 2020 — *Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks* → [[lewis2020rag]]
- [ ] Karpukhin et al., 2020 — *Dense Passage Retrieval for Open-Domain QA* → [[karpukhin2020dpr]]
- [ ] Gao et al., 2023 — *Precise Zero-Shot Dense Retrieval without Relevance Labels* (HyDE) → [[gao2023hyde]]

## Medium priority
- [ ] Sarthi et al., 2024 — RAPTOR → [[sarthi2024raptor]]
- [ ] Edge et al., 2024 — GraphRAG → [[edge2024graphrag]]

## To classify
- [ ] 

---

_When an entry moves to "read", move it to the "Recently read" section below and archive it monthly._

## Recently read
- _(empty)_
