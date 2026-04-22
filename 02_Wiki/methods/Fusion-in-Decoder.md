---
type: method
aliases: [FiD, Fusion in Decoder]
tags: [method, rag, generation, multi-document]
status: stub
created: 2026-04-21
updated: 2026-04-21
sources: ["[[oche2025ragsurvey]]"]
introduced_by: Izacard & Grave
year: 2021
---

# Fusion-in-Decoder

> **TL;DR** Encode each retrieved passage independently with a T5 encoder, then concatenate all representations for the decoder — enabling the model to attend jointly across all passages at generation time without the quadratic cost of encoding them together.

## Problem it solves
Naive RAG either concatenates all passages into one long encoder input (expensive, hits sequence length limits) or marginalizes over them separately (misses cross-passage evidence). FiD finds a middle ground: cheap independent encoding but joint cross-passage attention in the decoder. [[oche2025ragsurvey]]

## Key idea
Split the workload: the encoder runs independently on each (question + passage) pair in parallel; the decoder receives the concatenated encoder states and can attend across all passages simultaneously via standard cross-attention. This is "late fusion" at the decoder level.

## Pipeline / Steps
1. Retrieve top-k passages for the query (e.g., with DPR).
2. For each passage i, prepend the question: `[question] <sep> [passage_i]`.
3. Encode each concatenated string independently with a shared encoder → k hidden-state matrices.
4. Concatenate all k encoder outputs along the sequence dimension.
5. Run the decoder with cross-attention over the full concatenated representation → generate the answer.

## Reference implementations
- Original: T5-based, evaluated on NaturalQuestions and TriviaQA. [[oche2025ragsurvey]]
- HuggingFace Transformers includes `FiDT5` implementation.

## Reported results
FiD with 100 passages outperforms RAG-Token and RAG-Sequence on NaturalQuestions and TriviaQA. [[oche2025ragsurvey]]

## When to use / when not to
- ✅ Multi-document evidence needed — decoder jointly attends over all passages.
- ✅ Encoder parallelism: each passage encodes independently, scaling linearly with k.
- ❌ Decoder cost grows with k × passage length — expensive at large k.
- ❌ Requires fine-tuning the encoder-decoder; not a zero-shot plug-in.

## Related / alternatives
- [[Retrieval-Augmented Generation]] — RAG-Sequence/Token are the simpler baselines FiD improves on.
- [[Reranking]] — commonly applied before FiD to select top-k passages.
- [[RAPTOR]] — another multi-document synthesis approach, via hierarchical summaries.

## Sources
- [[oche2025ragsurvey]]
