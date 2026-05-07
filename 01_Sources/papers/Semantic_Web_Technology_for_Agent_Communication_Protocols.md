---
title: "Semantic Web Technology for Agent Communication Protocols"
authors: "Idoia Berges, Jesús Bermúdez, Alfredo Goñi, Arantza Illarramendi"
citekey: berges2024commOnt
aliases: [berges2024commOnt]
year: 2024
venue: "ArXiv"
url: "https://arxiv.org/abs/2401.11841"
tags: [paper, arxiv, semantic-web, owl, agents]
status: summarized
added_by: Pablo
---

# Semantic Web Technology for Agent Communication Protocols

## Summary
Proposes a framework for semantic interoperability between autonomous agents using OWL-DL, SWRL, and Event Calculus. Demonstrates that OWL/SWRL is sufficient to reason about complex inter-agent communication without pre-negotiation.

**Key stack:**
- **OWL-DL** — formally describes communication protocols and their constituent acts.
- **SWRL** — rule-based reasoning for protocol interpretation.
- **Event Calculus** — formalises the intended semantics of communication acts as social commitments (fluents).
- **CommOnt** — the paper's custom communication acts ontology.

**RAG relevance:** Illustrates the reasoning power of OWL-DL + SWRL in agentic settings. In agentic RAG, agents need to communicate and coordinate; formal ontology-backed protocols can reduce ambiguity. Also extends the OWL row in the RDF stack table (see [[RDF]]).

# Semantic Web Technology for Agent Communication Protocols

## Resumen
One relevant aspect in the development of the Semantic Web framework is the achievement of a real inter-agents communication capability at the semantic level. The agents should be able to communicate and understand each other using standard communication protocols freely, that is, without needing a laborious a priori preparation, before the communication takes place. For that setting we present in this paper a proposal that promotes to describe standard communication protocols using Semantic Web technology (specifically, OWL-DL and SWRL). Those protocols are constituted by communication acts. In our proposal those communication acts are described as terms that belong to a communication acts ontology, that we have developed, called CommOnt. The intended semantics associated to the communication acts in the ontology is expressed through social commitments that are formalized as fluents in the Event Calculus. In summary, OWL-DL reasoners and rule engines help in our proposal for reasoning about protocols. We define some comparison relationships (dealing with notions of equivalence and specialization) between protocols used by agents from different systems.
