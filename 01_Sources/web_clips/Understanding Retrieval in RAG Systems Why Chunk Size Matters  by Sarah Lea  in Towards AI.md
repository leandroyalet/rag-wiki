---
title: "Understanding Retrieval in RAG Systems: Why Chunk Size Matters | by Sarah Lea | in Towards AI"
source: "https://freedium-mirror.cfd/https://pub.towardsai.net/understanding-retrieval-in-rag-systems-why-chunk-size-matters-6d976dd5b654"
author:
published:
created: 2026-04-30
description: "Your paywall breakthrough for Medium!"
tags:
  - "clippings"
---
[< Go to the original](https://pub.towardsai.net/understanding-retrieval-in-rag-systems-why-chunk-size-matters-6d976dd5b654#bypass)

![Preview image](https://miro.medium.com/v2/resize:fit:700/1*4lVk_eSEg5PuFvZ6vq9esw.png)

## Understanding Retrieval in RAG Systems: Why Chunk Size Matters[Towards AI](https://medium.com/towards-artificial-intelligence "Making AI accessible to 100K+ learners.")androidstudio ~19 min read · December 28, 2025 (Updated: December 28, 2025) · Free: No

#### A step-by-step retrieval guide using sentence transformers, chunk size and similarity scores.

*User: "How many vacation days am I entitled to at our company?" RAG bot: "With a 100% workload, you are entitled to 25 vacation days. From age 50, you receive an additional week."*

These are exactly the kinds of answers we expect today from retrieval-augmented generation systems. You upload a PDF, ask a few questions, and get back plausible and often usable answers. RAG systems are often surprisingly reliable.

The term Retrieval-Augmented Generation (RAG) was originally introduced by [Lewis et al.](https://arxiv.org/abs/2005.11401) to combine language models with external knowledge sources. Particularly for knowledge-intensive tasks and to reduce hallucinations. Today, RAG is commonly used in many applications where document-based question answering is required.

But what I have often asked myself is:

- **Why does a system answer exactly the way it answers? How exactly does it decide on an answer?**
- **What does it look like when a system makes wrong decisions that are not even noticeable at first glance?**

That is exactly what this article explores by building a small RAG system using three Markdown documents and three predefined questions.

No chat. No memory. And no LLM for answer generation.

This project helped me enormously to better understand the mechanics behind RAG systems. The goal is not a finished RAG system, but to understand how sensitive retrieval is to how chunking is defined, how sentence transformers work and what similarity scores indicate.

In this article, I show you step by step how we build the RAG system, what a sentence transformer is, how we evaluate the RAG system and what the difference is between a chunk size of 80, 220 and 500.

Let's dive in! The theory will follow along the way. The full code is available in a linked GitHub-Repo.

***Table of Content*** *[1 — RAG-System for Exactly Three Questions](#12b5)* *[2 — Step-by-Step Guide for the RAG-System](#28cb)* *[3 — Chunk Size Comparison (80, 220, 500)](#f929)* *[4 — Extension: Handling Uncertainty in RAG](#ff23)* *[Final Thoughts — How Could we Develop the App further?](#3027)**[Where to Continue Learning?](#3c61)*

### 1 — RAG-System for Exactly Three Questions

RAG systems technically work with documents that serve as an external knowledge base. These documents are split into text segments transformed into vectors and stored in a vector database. There are now countless vector databases. Two well-known examples are [FAISS](https://faiss.ai/index.html) or [ChromaDB](https://www.trychroma.com/).

For our project we build a small RAG system that answers exactly three predefined questions:

```bash
"Q1: What is the main advantage of separating content creation from formatting in OneLatex?",
"Q2: How does OneLatex interpret text highlighted in green in OneNote?",
"Q3: How does OneLatex interpret text highlighted in yellow in OneNote?"
```

There is no chat history no memory component and no agent logic. Each question is processed separately.

What happens during a query? At this point the system does not use the entire document but instead specifically searches for the text passages that semantically best match the question.

Why is this important at all? In RAG systems, answer quality often depends less on the language model itself and more on whether the [retrieval step finds the relevant text passages](https://arxiv.org/abs/2005.11401) in the first place.

What is the goal? We want to see how well retrieval works and whether the system finds relevant text passages without other components such as an LLM masking the result.

Everything else remains constant: The model the data and the questions.

The only parameter we change is the chunk size: It specifies how large a text segment is that is embedded as a unit. In this project I defined the chunk size based on characters. Other options would have been word-based or token-based. In addition, we use an overlap. This is an overlapping area between two chunks. The goal is to prevent important information from being lost exactly at the chunk boundary.

*Note for Newbies: RAG systems are not just language models. In practice, retrieval is often the critical part, as only retrieved text passages can be used for answer generation. A typical RAG pipeline includes chunking, embeddings, a vector index, retrieval, and optional generation.*

### 2 — Step-by-Step Guide for the RAG-System

**→ 🤓** **[Find the full code in the GitHub Repo](https://github.com/Sari95/RAG-System-Three-Questions/tree/main)** **🤓 ←**

#### 1) Preparation — Mise en place

First we create a new directory called *"rag-one-question"* and inside it we create a folder named *"data"*:

![None](https://miro.medium.com/v2/resize:fit:700/1*qj9RrNMEKQvFw2rEq-WAWQ.png)

Screenshot taken by the author

Next we create a file called *"requirements.txt"* and add the following:

```bash
numpy
sentence-transformers
```

We save the file in the rag-one-question directory.

In a terminal we now create a new Python environment and install the packages that are listed in the requirements.txt file:

*Note for Newbies: As a Windows user you can press Windows + R and open a terminal with cmd. There you navigate to the directory we created earlier using cd rag-one-question. Then you paste in the code below:*

```bash
python -m venv .venv

# Windows
.venv\Scripts\activate
# macOS/Linux
source .venv/bin/activate

pip install -r requirements.txt
```

Screenshot taken by the author

#### 2) Creating 3 Markdown Files

Next, we create the three.md files that form our small text corpus. For this I used excerpts from the documentation of OneLatex, a tool I use to write my university papers directly in OneNote.

The contents in the markdown files is kept deliberately simple to focus on retrieval, while using documents from a real application context. You can, of course, run the project with other texts as well. The only important thing is that the texts are clearly structured and not too large.

For this, we create the following three files as.md files and insert the text below:

**File 1: Name: onelatex\_introduction**

```markdown
OneLatex allows users to create professional documents by writing content in OneNote and converting it into pure LaTeX code.

The main benefit of this approach is that content creation is separated from formatting. Users can focus on writing their ideas in OneNote, while OneLatex handles many complex formatting aspects during the conversion process. For example, links between OneNote pages are automatically converted into document references.

OneLatex uses the structure of OneNote to organize documents. Each OneNote page represents a section or chapter in the final LaTeX document. This provides a clear overview of the document structure and makes reordering chapters easy by simply moving pages in OneNote. This is especially helpful for large documents where restructuring can otherwise become cumbersome.

In addition, OneLatex allows users to keep remarks, notes, hyperlinks, and files directly inside the same OneNote notebook. These supplementary materials can be marked with a blue background and are ignored during conversion. This makes the notebook an all-in-one documentation and collaboration hub without affecting the final LaTeX output.

Overall, OneLatex combines the user-friendly interface of OneNote with the power of LaTeX to provide an efficient workflow for professional document creation.

OneLatex deliberately ignores most formatting, except for bold, underline, and italic text. To ensure correct conversion, the text layout in OneNote should remain simple, using a single font and font size.

Using OneNote style templates such as Heading or Quote will cause the corresponding text blocks to be ignored during conversion. To ensure content is included, the Normal style should be used.
```

**File 2: Name: onelatex\_green\_settings**

```
If the background of a text in OneNote is highlighted in green, OneLatex interprets the content as settings.

For this to work, the text must be formatted as valid JSON, and the property names must match those used by OneLatex.

Settings can be copied from OneLatex and pasted into OneNote. Once pasted, they appear with a green background.

During the conversion process, OneLatex reads these green-highlighted settings and applies them accordingly.

Additional information about copying and pasting settings is provided in the OneLatex documentation. Further explanations describe how settings are applied in OneLatex and what the individual settings mean.
```

**File 3: Name: onelatex\_yellow\_settings**

```
If the background of a text in OneNote is marked in yellow, OneLatex interprets the text as native LaTeX code.

This allows users to write LaTeX commands directly in OneNote, similar to working in a LaTeX editor.

For example, LaTeX commands can be used to insert vertical space or start a new page. Entire tables can also be written manually if the table functionality of OneLatex is not used.

As an alternative to the yellow background color, the same behavior can be achieved by assigning the tag "Project B" to the text.

When copying content to the clipboard, tags such as "Project B" are not preserved. In such cases, the copied content will always use the background color instead of the tag.
```

We save the three files in the rag-one-question directory.

#### 3) Creating the main.py File

Finally, we need to create the *"main.py"* file. To do this, we open Visual Studio Code and insert the following code snippets:

First, we import some standard libraries. We import *"argparse"* so that we can change parameters such as *"chunk-size"* or *"top-k"* via the command line. We use os to read files from a directory. With *"dataclass"* we define a simple data structure for chunks. We use *"numpy"* for vector computation and sorting. And *"SentenceTransformer"* is the embedding model that translates text into vectors for us.

```python
#main.py
import argparse
import os
from dataclasses import dataclass
from typing import List, Tuple

import numpy as np
from sentence_transformers import SentenceTransformer
```

Next, we define the central data structure in the Chunk class. In our case, we define a chunk using the file name *(doc\_id),* a running number *(chunk\_id)* and the actual text *(text)*. These three fields are sufficient for us to later clearly identify both the content and the source.

```python
# ----------------------------
# Data structures
# ----------------------------
@dataclass
class Chunk:
    doc_id: str
    chunk_id: int
    text: str
```

Next, we define several functions:

- ***read\_markdown\_files()*****:** With this function, we load all documents with the.md extension and read their contents. The result of the function is a list of doc\_id and text.
- ***chunk\_text()*****:** With this function, we split a text into chunks. The chunking is kept simple and character-based: with chunk\_size we define the number of characters per chunk. To ensure that chunks do not break at an unfavorable position we use an overlap. This means the next chunk starts a few characters before the end of the previous chunk.
- ***embed\_texts()*****:** This function handles the embedding step. It takes a list of texts and returns an array of vectors. The important part here is *"normalize\_embeddings=True"*: This scales the vectors so that they all have the same length. This is useful because cosine similarity can then be computed as a dot product.
- ***top\_k\_cosine()*****:** With this function, we compute this dot product from *"embed\_texts()"*. The larger the value, the more semantically similar the query and the chunk are.
```sql
# ----------------------------
# Utilities
# ----------------------------
def read_markdown_files(folder: str) -> List[Tuple[str, str]]:
    """Return list of (doc_id, text). doc_id is filename."""
    docs = []
    for fname in sorted(os.listdir(folder)):
        if fname.lower().endswith(".md"):
            path = os.path.join(folder, fname)
            with open(path, "r", encoding="utf-8") as f:
                docs.append((fname, f.read()))
    if not docs:
        raise RuntimeError(f"No .md files found in {folder}")
    return docs

def chunk_text(text: str, chunk_size: int, overlap: int) -> List[str]:
    """
    Simple character-based chunking with overlap.
    This is intentionally naive to demonstrate chunking sensitivity.
    """
    if chunk_size <= 0:
        raise ValueError("chunk_size must be > 0")
    if overlap < 0:
        raise ValueError("overlap must be >= 0")
    if overlap >= chunk_size:
        raise ValueError("overlap must be smaller than chunk_size")

    text = " ".join(text.split())  # normalize whitespace
    chunks = []
    start = 0
    while start < len(text):
        end = min(start + chunk_size, len(text))
        chunk = text[start:end].strip()
        if chunk:
            chunks.append(chunk)
        if end == len(text):
            break
        start = end - overlap
    return chunks

def embed_texts(model: SentenceTransformer, texts: List[str]) -> np.ndarray:
    """
    Create normalized embeddings so cosine similarity is a dot product.
    """
    emb = model.encode(texts, normalize_embeddings=True, show_progress_bar=False)
    return np.asarray(emb, dtype=np.float32)

def top_k_cosine(query_emb: np.ndarray, chunk_embs: np.ndarray, k: int) -> List[int]:
    """
    query_emb: (d,)
    chunk_embs: (n, d)
    returns indices of top-k most similar chunks.
    """
    sims = chunk_embs @ query_emb  # dot product since normalized -> cosine
    k = min(k, len(sims))
    top_idx = np.argsort(-sims)[:k]
    return top_idx.tolist()
```

Now we have our basic components to build a mini RAG pipeline:

With the *"build\_chunks()"* function, we load all Markdown documents and apply *"chunk\_text()"* to each document. Each generated chunk is stored as a Chunk object, including the file name and chunk number. As a result, we get a large list of all chunks across all files.

We define the *"retrieve()"* function for the actual retrieval for a question: First, only the chunk texts *(chunk\_texts)* are extracted and then embeddings are generated for the chunks *(chunk\_embs)* as well as for the question *(q\_emb)*. The function then calls *"top\_k\_cosine"* and receives the indices of the best chunks. In addition, we use the function to compute the scores for all chunks using *"chunk\_embs @ q\_emb"*. As a result, the function returns a list of tuples *(rank, score, chunk)*, which can later be used to report the ranking, similarity score, source file and chunk ID.

```php
# ----------------------------
# Mini-RAG pipeline
# ----------------------------
def build_chunks(data_folder: str, chunk_size: int, overlap: int) -> List[Chunk]:
    docs = read_markdown_files(data_folder)
    all_chunks: List[Chunk] = []
    for doc_id, text in docs:
        chunks = chunk_text(text, chunk_size=chunk_size, overlap=overlap)
        for i, ch in enumerate(chunks):
            all_chunks.append(Chunk(doc_id=doc_id, chunk_id=i, text=ch))
    return all_chunks

def retrieve(model: SentenceTransformer, chunks: List[Chunk], question: str, top_k: int):
    chunk_texts = [c.text for c in chunks]
    chunk_embs = embed_texts(model, chunk_texts)
    q_emb = embed_texts(model, [question])[0]

    idxs = top_k_cosine(q_emb, chunk_embs, k=top_k)
    # compute scores for printing
    scores = (chunk_embs @ q_emb).tolist()

    results = []
    for rank, idx in enumerate(idxs, start=1):
        c = chunks[idx]
        results.append((rank, scores[idx], c))
    return results
```

In the main() block, we first define the command line arguments. There we specify where the data is located *(data-folder)*,how large the chunks should be *(chunk-size)*, how much overlap is used *(overlap)*, how many results we want to see *(top-k)* which embedding model we use *(model)* and whether we want to output all chunks in debug mode *(debug)*. The parameters are then parsed and the chunks are created using *"build\_chunks()"*. The script then prints a setup header so that for each run we can immediately see which settings were used.

Next, we define the three fixed questions so that we can compare the same workflow with different chunk sizes. And with *"model = SentenceTransformer(args.model)"* we finally load the model.

For each question, the same process then runs: The script calls *"retrieve()",* prints the top results, including score source and chunk number, and then outputs the *"Grounded answer (minimal)"* simply as the best chunk. The important point is that nothing is "rephrased" here by an LLM. You see exactly the text passage that the retrieval has classified as the most relevant.

```python
def main():
    parser = argparse.ArgumentParser(description="Mini-RAG: 3 fixed questions, no chat, no memory.")
    parser.add_argument("--data-folder", default="data", help="Folder with .md files")
    parser.add_argument("--chunk-size", type=int, default=220, help="Chunk size (characters)")
    parser.add_argument("--overlap", type=int, default=40, help="Overlap between chunks (characters)")
    parser.add_argument("--top-k", type=int, default=3, help="How many chunks to retrieve")
    parser.add_argument("--model", default="sentence-transformers/all-MiniLM-L6-v2",
                        help="SentenceTransformer model name")
    parser.add_argument("--debug", action="store_true", help="Print all chunks with IDs")
    args = parser.parse_args()

    # 1) Build chunks
    chunks = build_chunks(args.data_folder, chunk_size=args.chunk_size, overlap=args.overlap)

    print("\n=== Mini-RAG: Setup ===")
    print(f"Docs folder: {args.data_folder}")
    print(f"Chunks: {len(chunks)} | chunk_size={args.chunk_size} overlap={args.overlap}")
    print(f"Embedding model: {args.model}")

    if args.debug:
        print("\n--- All chunks ---")
        for c in chunks:
            print(f"[{c.doc_id} | chunk {c.chunk_id}] {c.text[:140]}{'...' if len(c.text) > 140 else ''}")

    # 2) Fixed questions (exactly 3)
    questions = [
        "Q1: What is the main advantage of separating content creation from formatting in OneLatex?",
        "Q2: How does OneLatex interpret text highlighted in green in OneNote?",
        #Alternative"Q2: Green-highlighted text in OneNote is interpreted as what in OneLatex?",
        "Q3: How does OneLatex interpret text highlighted in yellow in OneNote?"
    ]

    model = SentenceTransformer(args.model)

    print("\n=== Questions & Retrieval ===")
    for q in questions:
        print("\n" + "=" * 80)
        print(f"Q: {q}")

        results = retrieve(model, chunks, q, top_k=args.top_k)

        print("\nTop retrieved chunks:")
        for rank, score, c in results:
            preview = c.text.replace("\n", " ")
            if len(preview) > 220:
                preview = preview[:220] + "..."
            print(f"{rank:>2}. score={score:.3f} | source={c.doc_id} | chunk={c.chunk_id}")
            print(f"    {preview}")

        # 3) Minimal "answer": use the best chunk as grounded output
        best = results[0][2]
        print("\nGrounded answer (minimal):")
        print(f"Source: {best.doc_id} (chunk {best.chunk_id})")
        print(best.text)

    print("\n=== Done ===")

if __name__ == "__main__":
    main()
```

For embedding, we use *[all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2)* as the sentence transformer model. Sentence transformers convert entire sentences or text passages into numerical vectors that represent their meaning. Texts with similar meaning are located closer together in vector space than texts with different meanings.

What does this mean in practice? It is not individual words that are compared but the semantic meaning of the entire text passage.

The model is very lightweight and therefore also runs comfortably on a standard personal laptop. I ran it locally on my Lenovo laptop (64 GB of RAM), which was more than sufficient for this small experiment.

In our setup, a similarity to the question is calculated for each chunk and the chunks with the highest scores are considered the most relevant matches.

The score is a similarity metric between two vectors. In our case, this is cosine similarity. It tells us how close the meaning of the question is to the meaning of a chunk relative to the other chunks.

What is important is this: The score is not a probability and not a measure of truth. A high score does not mean that the content is correct, but only that the chunk is semantically more similar compared to other chunks.

*Note for Newbies: Scores can only be compared within a single run with the same question and the same candidate pool. A score of 0.78 is not "good" or "bad" by itself. It is only higher or lower than other scores in the same run.*

As the "answer" in this project, we use only the best chunk. There is no additional generation by an LLM.

Why do we do this here? This keeps it clearly visible what the retrieval actually delivers without a language model masking errors.

### 3 — Chunk Size Comparison (80, 220, 500)

For the evaluation, we open our terminal again and enter the command below for each experiment.

```
#Experiment 1 - Baseline
python main.py --chunk-size 220 --overlap 40 --top-k 3

#Experiment 2 - Small Chunk-Size
python main.py --chunk-size 80 --overlap 10 --top-k 3

#Experiment 3 - Big Chunk-Size
python main.py --chunk-size 500 --overlap 50 --top-k 3
```

Screenshot taken by the author

#### Chunk size 80: Too little Context

With a chunk size of 80 characters, many chunks contain only sentence fragments. The retrieval results are partly semantically correct.

But let us look at an example:

Screenshot taken by the author

In practice, these answers are hardly usable. The answers consist of half-sentences or truncated statements.

Here we clearly see: Retrieval works formally. The answer quality is still poor.

#### Chunk size 220: Stable but not Robust

The baseline chunk size works well in most cases. The correct documents are found and the answers are understandable.

What was interesting here, however, is this error: The distinction between "green" and "yellow" text highlighting could not be answered correctly.

Screenshot taken by the author

No matter whether we ask about the green or the yellow highlighting the answer for the yellow highlighting is returned.

In this version, which led to an error, we see that the scores for both chunks are very close to each other. The two best matches for the same question have very similar scores: the top 1 chunk reaches a score of 0.783 and the second best chunk a score of 0.774. The gap between the two matches is therefore very small.

Screenshot taken by the author

What is happening here? In this case, the system cannot clearly distinguish between the two candidates. Although the content-wise correct chunk is present, the system returns the wrong chunk as top 1 due to the minimally higher score.

I think for a demo, this baseline could work. For a productive system, however, it would be problematic.

#### Chunk size 500: More Stable Context

With a chunk size of 500 characters, the chunks now contain complete explanations. We hardly see any fragmentation anymore. In this setup, the distinction between "green" and "yellow" also works, although the question remains the same.

Screenshot taken by the author

With this small project, we can clearly see that chunk size not only influences retrieval but also the quality of the answers:

Very small chunks lose context. Medium sized chunks can be unstable. Larger chunks often deliver more robust results.

In addition, I found it interesting that the score gaps give us an indication of uncertainty. In the error between green and yellow, the scores of 0.783 and 0.774 are very close to each other. The system is uncertain, but still has to make a decision.

These are exactly the kinds of problems we also encounter when scaling RAG systems. The project is not intended to build a productive system. But it is worth starting with such a simple project to better understand the individual parameters.

### 4 — Extension: Handling Uncertainty in RAG

For this extension, we keep our mini RAG system but extend it with two simple mechanisms:

1. **Citations or nothing:** An answer is only valid if it refers to a chunk. This means every answer must name a source file and chunk ID.
2. **Uncertainty handling:** If scores are too close to each other as in the previous problem with the distinction between yellow and green the system indicates that it is too uncertain. This means if the retriever is uncertain due to the scores, the system returns the answer "I am too uncertain…".

#### 1) Keeping the Retrieval Output

First, we save the file again under the name *"main\_extension.py",* in which we insert the changes.

What we keep exactly the same as before is the retrieval: we continue to use *"top\_k=3"* and output the list of results. This is our basis for citation and uncertainty checking.

#### 2) Defining a Gap Rule for Uncertainty

Within the same question, we compare the scores and calculate the gap:

- Score (top 1) vs. score (top 2)
- Gap = score (top 1) — score (top 2)

If the gap is very small, the decision is uncertain.

For this, we define a threshold and set it for example, to *"gap\_threshold = 0.02"*. We could also change this later.

#### 3) Adapting main\_extension.py

In our main\_extension.py file, we insert the following function above main():

```php
def is_uncertain(results, gap_threshold: float) -> bool:
    """
    results: list of tuples (rank, score, Chunk) sorted by score desc.
    We compare top-1 vs top-2 for the SAME question.
    """
    if len(results) < 2:
        return False
    top1_score = results[0][1]
    top2_score = results[1][1]
    gap = top1_score - top2_score
    return gap < gap_threshold
```

In addition, we extend the argparse block with an additional argument so that we can add gap\_threshold as a CLI parameter:

```bash
parser.add_argument("--gap-threshold", type=float, default=0.02,
                    help="If top-1 and top-2 scores are closer than this, return 'too unsure'")
```

Screenshot taken by the author

#### 4) Modifying the Output

For the final adjustment, we change the output and replace the output of the grounded answer with the code shown below.

In confident cases, the system returns a normal answer plus a source, while in uncertain cases, the system does not return an answer but instead provides an explanation of the gap as well as top 1 versus top 2 as a source reference.

```python
gap_threshold = args.gap_threshold

print("\nGrounded answer:")
if is_uncertain(results, gap_threshold):
    top1 = results[0]  # (rank, score, Chunk)
    top2 = results[1]

    gap = top1[1] - top2[1]
    print("I'm too unsure because the two best passages fit almost equally well.")
    print(f"Gap (Top-1 - Top-2): {gap:.3f} (threshold={gap_threshold:.3f})")

    print("\nTop candidates (citations):")
    print(f"- Top-1: score=.3
 | {top1[2].doc_id} (chunk {top1[2].chunk_id})")
    print(f"- Top-2: score=.3
 | {top2[2].doc_id} (chunk {top2[2].chunk_id})")

    print("\nNote: Please clarify the question (e.g. by using more specific terms).")
else:
    best = results[0][2]
    best_score = results[0][1]
    print(f"Answer is based on: {best.doc_id} (chunk {best.chunk_id}) | score={best_score:.3f}")
    print(best.text)
```

#### 5) Let's Evaluate Again

Since we discovered the error in the baseline experiment earlier, we now test again with this chunking and enter the following command in the terminal:

```
python main_extension.py --chunk-size 220 --overlap 40 --top-k 3 --gap-threshold 0.02
```

And indeed we see that it now works.

For question Q2, the system no longer returns an answer related to the yellow color but instead responds that it is not certain and directly shows the two chunks that lead to this uncertainty. The system cannot clearly decide which of the two chunks is actually more relevant.

Screenshot taken by the author

With this extended version, the top-rated chunk is no longer automatically returned as the answer. Instead, an additional check is performed to see how clear this decision actually is by comparing the chunks of a question with the highest scores.

With this extension, the behavior of our system becomes more robust.

It answers questions directly only when the retrieval step shows a sufficiently clear preference for one chunk. Otherwise, it transparently communicates that the decision is uncertain. In real systems, an "I don't know" is often better than a plausible but wrong answer.

*On my* *[Substack Data Science Espresso](https://sarahleaschrch.substack.com/)**, I share practical guides and bite-sized updates from the world of Data Science, Python, AI, Machine Learning and Tech. Made for curious minds like yours.*

*Have a look and subscribe here on Medium or on Substack if you want to stay in the loop.*

### Final Thoughts

The choice of chunk size affects not only retrieval but also the quality and reliability of the answers. Small chunks lose context. Medium-sized chunks can be unstable. Larger chunks often deliver more robust results because they contain more coherent information.

In our mini RAG system, chunk size plays almost no role with regard to cost or inference length. We do not use an LLM for answer generation and the returned texts are short. Here, chunk size mainly influences how stable the retrieval behaves. Runtime or resource consumption, on the other hand, is hardly affected.

In productive systems, this looks different. There, chunk size is a clear cost-quality trade-off. Larger chunks mean more context tokens that are passed to a language model during inference. More context leads to higher inference costs and more computational effort when creating embeddings. This becomes particularly relevant for long answers or when multiple chunks per query are used. In such cases, it can quickly become expensive if we define a chunk size of 500.

At the same time, a larger chunk size reduces the total number of chunks. This saves storage in the vector index and can stabilize retrieval. What is important here: during retrieval itself, there are hardly any additional costs. Vector search costs the same regardless of chunk length and the computation of cosine similarity also does not depend on text length.

**If we now want to extend the system, what could we do?**

- **Make retrieval more robust (before the LLM):** In this example, I deliberately did not use an LLM to make visible how retrieval works. As a next step, we could align chunking more strongly with the document structure, for example, based on headings paragraphs or lists instead of using only a fixed character length.
- **Handle uncertainty explicitly:** With the extension, we have already started to make uncertainty visible through the similarity score gap. In a productive system, we could build on this and define different reactions, for example, asking a follow up question, loading additional context or linking directly to relevant pages.
- **Improve query understanding:** In our project, we defined exactly three questions. In real systems, however, user questions are usually vague, often incomplete and very diverse. Possible extensions would be query rewriting, the use of synonyms, tool specific vocabulary or controlled suggestions such as "Did you mean …?".

Own visualization — Illustrations from [unDraw.co](https://undraw.co/illustrations)

### Where to continue learning

- [IBM Blog — What is RAG?](https://www.ibm.com/think/topics/retrieval-augmented-generation)
- [DataCamp Blog — What is Retrieval Augmented Generation (RAG)?](https://www.datacamp.com/blog/what-is-retrieval-augmented-generation-rag)
- [Nvidia Blog — What is RAG?](https://www.nvidia.com/en-us/glossary/retrieval-augmented-generation/)
- [Documentation of Chroma DB](https://docs.trychroma.com/docs/overview/introduction)
- [Paper Lewis et al. — Leveraging Passage Retrieval with Generative Models for Open Domain Question Answering](https://arxiv.org/abs/2007.01282)
- [Medium Article — RAG in Action: Build your Own Local PDF Chatbot as a Beginner](https://medium.com/data-science-collective/rag-in-action-build-your-own-local-pdf-chatbot-as-a-beginner-96c2833869ff)

[< Go to the original](https://pub.towardsai.net/understanding-retrieval-in-rag-systems-why-chunk-size-matters-6d976dd5b654#bypass)