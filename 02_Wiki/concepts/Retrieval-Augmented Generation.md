---
type: concept
aliases: [RAG]
tags: [rag, retrieval, generation, foundational]
status: draft
created: 2026-04-18
updated: 2026-05-16
sources: ["[[lewis2020rag]]", "[[emonet2024sparql]]", "[[barnett2024failures]]", "[[agrawal2025cag]]", "[[chatzikyriakidis2025raggedevents]]", "[[oche2025ragsurvey]]", "[[wampler2025ragstack]]", "[[brehme2025ragindustry]]", "[[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]]", "[[01_Sources/web_clips/RAG, LLM Wiki, or Gbrain? How Your Agent Remembers Changes Everything  by Yanli Liu  in AI Advances]]"]
---

# Retrieval-Augmented Generation

> **TL;DR** Two-stage architecture — *retrieve* relevant documents from an external store, then *generate* a response conditioned on them — that lets an LLM answer about specific or up-to-date information without being retrained.

## Definition
RAG is a pattern where a language model generates text conditioned on fragments retrieved at inference time from an external knowledge base. The base typically lives in a [[Vector Database]] and is queried using [[Embeddings]], though variants exist with [[Sparse Retrieval]] and [[Hybrid Search]].

## Context
It addresses three problems of "naked" LLMs:
1. **Frozen knowledge** at training time.
2. **Hallucinations** about specific facts.
3. **Inability to cite sources** verifiably.

It was formalized by [[lewis2020rag]] at NeurIPS 2020, combining a DPR retriever with a BART generator fine-tuned jointly. Since then the term has broadened to describe almost any pipeline that concatenates retrieval + generation, even without joint fine-tuning.

### Historical milestones
| Period | Event |
|--------|-------|
| 2017–2019 | DrQA, R³, ORQA — pipeline-based retrieve-and-read precursors |
| 2020 | [[lewis2020rag]] formalizes RAG; Guu et al. introduce REALM (retrieval-aware pre-training) |
| 2021 | [[Fusion-in-Decoder]] (FiD) improves multi-document generation; [[KILT]] unifies 11 knowledge tasks |
| 2022 | RETRO shows a 7.5B-param model + 2T-token retrieval corpus ≈ GPT-3 175B on knowledge tasks |
| 2023 | RAG integrated with GPT-4-class generators; Modular/Agentic RAG emerge |
| 2024–25 | Enterprise focus: proprietary data handling, security, scalability |

[[oche2025ragsurvey]]

## How it works
Canonical pipeline:

1. **Indexing (offline)**: documents → [[Chunking]] → [[Embeddings]] → [[Vector Database]].
2. **Retrieval (online)**: query → embedding → top-k similar chunks.
3. **Augmentation**: build a prompt with the query + retrieved chunks.
4. **Generation**: the LLM produces the answer conditioned on the augmented prompt.

Optionally, a [[Reranking]] step is inserted between 2 and 3 to filter noise.

## Variants
- **RAG-Sequence** — retrieve once, condition the entire output sequence on a single fixed document (marginalize over top-k at sequence level). [[lewis2020rag]]
- **RAG-Token** — allow the retrieved document to change at each generation token, marginalizing over top-k at each step. [[lewis2020rag]]
- **[[Fusion-in-Decoder]] (FiD)** — encode each passage independently, concatenate encoder states, let the decoder attend across all passages jointly. Outperforms RAG-Seq/Token on NQ and TriviaQA. [[oche2025ragsurvey]]
- **Naive RAG** — the canonical pipeline; nothing more.
- **Advanced RAG** — adds query expansion techniques ([[HyDE]], [[Query Expansion]]), reranking, and post-processing.
- **Modular RAG** — configurable orchestration, sometimes with [[Multi-hop Retrieval]] or agentic loops.
- [[RAG-Fusion]], [[RAPTOR]], [[GraphRAG]] as specific extensions.
- **Iterative RAG** — performs multiple retrieval loops; each pass uses the LLM's partial answer to reformulate the next query until the response converges. Related to [[Multi-hop Retrieval]]. [[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]]
- **Adaptive RAG** — dynamically selects the retrieval strategy (no retrieval / single-hop / multi-hop) based on query complexity, routing simple fact lookups past the retriever entirely. [[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]]
- **Real-Time RAG** — incorporates live data feeds (news APIs, event streams) to keep retrieved knowledge fresh for time-sensitive queries. [[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]]
- **Hierarchical RAG** — organises the index as a multi-level tree: summaries at higher levels, raw chunks at leaves; retrieval starts at summary level and drills down only when needed. See also [[RAPTOR]]. [[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]]
- **Structured-output RAG** — generation target is a formal query (SPARQL, SQL) rather than free text; requires schema-aware retrieval and a validation loop. See [[Text-to-SPARQL]]. [[emonet2024sparql]]

## Trade-offs
- ✅ Knowledge updatable without retraining.
- ✅ Verifiable answers (the system can cite its chunks).
- ✅ Marginal cost of adding knowledge ≈ cost of indexing.
- ❌ Quality bounded by the retriever: *garbage in, garbage out*.
- ❌ Latency: adds a search to the loop.
- ❌ Context window: retrieved chunks compete with prompt space.

## Comparison with alternatives
- **Fine-tuning**: internalizes knowledge in the weights. RAG doesn't modify the model. Fine-tuning wins on fluency over a domain; RAG wins on updateability and verifiability.
- **Long-context LLMs**: stuff everything into context. Viable for small corpora; doesn't scale to millions of docs and is expensive per token.
- **[[Cache-Augmented Generation]] (CAG)**: preloads a compressed knowledge snapshot into the context window; eliminates retrieval latency and noise but bounded by context window size and suffers cache staleness. [[agrawal2025cag]]
- **[[_meta/open-questions#Q2|Reranker vs. more recall]]** is a recurring debate within the pattern itself.

## When RAG may not help
The **inverse calibration principle** ([[chatzikyriakidis2025raggedevents]]): for well-documented domains, strong models (GPT-4o, Claude-3.5 Sonnet) may perform *worse* with RAG augmentation than without — retrieved context introduces conflicting signals against strong parametric knowledge. Weak models (Llama 3.2 3B) benefit from RAG in those same domains. The implication: always evaluate baseline (no RAG) vs. RAG+; don't assume augmentation helps. [[chatzikyriakidis2025raggedevents]]

## Critique of the pattern
Karpathy (2026) argues that classic RAG **rediscovers knowledge on every query**: the synthesis doesn't accumulate. He proposes compiling that knowledge into a wiki maintained by the LLM — the pattern this vault uses. See [[CLAUDE|CLAUDE.md]].

Liu (2025) names three structural failure patterns inherent to the RAG architecture [[01_Sources/web_clips/RAG, LLM Wiki, or Gbrain? How Your Agent Remembers Changes Everything  by Yanli Liu  in AI Advances]]:
- **The chunking problem** — RAG retrieves text fragments, not synthesized knowledge; questions requiring cross-document reasoning receive disconnected pieces rather than an integrated answer.
- **The re-derivation problem** — every query re-runs retrieval and synthesis from scratch; no learning accumulates across sessions and redundant computation is unavoidable.
- **The passivity problem** — RAG is reactive: it waits for queries; it never proactively maintains, reconciles, or updates its knowledge base.

These limitations motivate hybrid architectures: LLM Wiki (Karpathy's "compiler" model, where the LLM synthesises and writes knowledge into long-lived notes) and GBrain / "fat skills" (Garry Tan's "operator" model, where agents autonomously act and maintain state). [[01_Sources/web_clips/RAG, LLM Wiki, or Gbrain? How Your Agent Remembers Changes Everything  by Yanli Liu  in AI Advances]]

## Industry adoption (2025)
A semi-structured interview study with 13 industry practitioners ([[brehme2025ragindustry]]) found:
- Current RAG deployments are **mostly domain-specific QA** in prototype/early-production stage.
- Top system requirements: **data protection, security, output quality** (ethics and scalability underemphasised).
- **Data preprocessing** (cleaning, formatting, normalising source documents) is the most consistently cited operational challenge — pre-indexing quality affects all downstream failure points.
- System evaluation is **predominantly human-conducted**; automated frameworks (RAGAS, DeepEval) are known but not yet standard practice in industry.

[[brehme2025ragindustry]]

## Architecture taxonomy
[[wampler2025ragstack]] proposes a five-dimensional classification of RAG systems (2018–2025 literature review):

| Dimension | Options |
|-----------|---------|
| Retrieval strategy | Single-pass · Iterative · Multi-hop |
| Fusion mechanism | Early ([[Fusion-in-Decoder\|FiD]]) · Late (RAG-Sequence) · Marginal ([[RAG-Fusion]]) |
| Knowledge modality | Text-only · Structured · Multi-modal |
| Trust calibration | Abstention · Citation grounding · Uncertainty quantification |
| Pipeline adaptivity | Static rule-based · Agentic/self-adaptive |

Deployment recommendations: hybrid sparse-dense retrieval for balanced performance; two-stage retrieval (bi-encoder + cross-encoder [[Reranking|reranking]]) for precision; semantic windowing beats fixed-size [[Chunking]] for context preservation. [[wampler2025ragstack]]

## Tooling
Common orchestration frameworks: [[LangChain]], [[LlamaIndex]], [[Haystack]].
Evaluation: [[RAGAS]], [[DeepEval]], [[TruLens]], [[LLM-as-Judge]].

## Related pages
- [[Dense Retrieval]]
- [[Sparse Retrieval]]
- [[Hybrid Search]]
- [[Chunking]]
- [[Reranking]]
- [[Hallucination in RAG]]
- [[RAG Failure Points]]
- [[Cache-Augmented Generation]]

## Sources
- [[lewis2020rag]] — original paper.
- [[emonet2024sparql]] — applies RAG to federated SPARQL query generation with schema-aware retrieval and validation.
- [[barnett2024failures]] — seven failure point taxonomy from production deployments.
- [[agrawal2025cag]] — CAG as RAG alternative; ACC compression; hybrid framework.
- [[chatzikyriakidis2025raggedevents]] — inverse calibration principle: strong models may degrade with RAG augmentation.
- [[wampler2025ragstack]] — five-dimensional taxonomy + trust framework from 2018–2025 systematic review.
- [[brehme2025ragindustry]] — 13-practitioner interview study: data preprocessing top challenge; human eval still dominant.
- [[01_Sources/web_clips/Different Retrieval Methods  by Yed Pavankumar]] — taxonomy of RAG variants including Iterative, Adaptive, Real-Time, Hierarchical.
- [[01_Sources/web_clips/RAG, LLM Wiki, or Gbrain? How Your Agent Remembers Changes Everything  by Yanli Liu  in AI Advances]] — three-architecture comparison; chunking/re-derivation/passivity failure patterns.
