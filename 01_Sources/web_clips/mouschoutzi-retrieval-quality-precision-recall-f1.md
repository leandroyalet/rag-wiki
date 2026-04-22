---
title: "How to Evaluate Retrieval Quality in RAG Pipelines: Precision@k, Recall@k, and F1@k | by Maria Mouschoutzi, PhD | in AI Advances"
source: "https://freedium-mirror.cfd/https://ai.gopubby.com/how-to-evaluate-retrieval-quality-in-rag-pipelines-precision-k-recall-k-and-f1-k-9d344a62358b"
author:
published:
created: 2026-04-18
description: "Why care about the quality of the retrieval of your RAG pipeline, and what metrics to use for..."
tags:
  - "clippings"
---
[< Go to the original](https://ai.gopubby.com/how-to-evaluate-retrieval-quality-in-rag-pipelines-precision-k-recall-k-and-f1-k-9d344a62358b#bypass)

![Preview image](https://miro.medium.com/v2/resize:fit:700/0*xi1smPx5hgGrdEQ3.jpeg)

## How to Evaluate Retrieval Quality in RAG Pipelines: Precision@k, Recall@k, and F1@k

## Why care about the quality of the retrieval of your RAG pipeline, and what metrics to use for evaluating it[AI Advances](https://medium.com/ai-advances "Democratizing access to artificial intelligence")androidstudio ~16 min read · November 11, 2025 (Updated: November 11, 2025) · Free: No

*— This story has been previously published on* 🍨 *[DataCream](https://datacream.substack.com/)*

In my previous posts, I have walked you through [putting together a very basic RAG pipeline in Python](https://datacream.substack.com/p/hitchhikers-guide-to-rag-with-chatgpt), as well as [chunking large text documents](https://datacream.substack.com/p/hitchhikers-guide-to-rag-from-tiny). We've also looked into [how documents are transformed into embeddings](https://datacream.substack.com/p/rag-explained-understanding-embeddings), allowing us to quickly search for similar documents within a vector database, along with [how reranking is used](https://datacream.substack.com/p/rag-explained-reranking-for-better) to identify the most appropriate documents for answering the user's query.

So, now that we've retrieved the relevant documents, it's time to pass them into the LLM for the generation step. But before that, it is important to be able to tell if the retrieval mechanism works well and can successfully identify relevant results. After all, retrieving the chunks that contain the answer to the user's query is the very first step for being able to generate a meaningful answer.

Therefore, this is exactly what we are going to explore in today's post. In particular, we are going to take a look at some of the most popular metrics for evaluating retrieval and reranking performance.

> I write **[DataCream](https://datacream.substack.com/)** *🍨R, where I'm learning and experimenting with AI and data. **[Subscribe here](https://datacream.substack.com/)** to learn and explore with me.*

*

## [Maria Mouschoutzi, PhD - Medium](https://medium.com/@m.mouschoutzi)

### Read writing from Maria Mouschoutzi, PhD on Medium. learning, experimenting, and writing about AI and data 👩🏻💻…med

medium.com

### Why care about measuring retrieval performance

So, our goal is to evaluate how well our embedding model and vector database bring back candidate text chunks. Essentially, what we are trying to find out here is " *Are the right documents somewhere in the top-k retrieved set*?", or does our vector search return complete garbage?

There are several different measures we can utilize to answer this question. Most of them originate from the [Information Retrieval](https://en.wikipedia.org/wiki/Information_retrieval) field.

Before we begin, it's useful to distinguish between two types of measures — these are **binary** and **graded** relevance measures. More specifically, binary measures characterize a retrieved text chunk either as relevant or irrelevant for answering the user's query — there is no in between. On the contrary, graded measures assign a relevance value to each text chunk that is retrieved, somewhere in a spectrum ranging from complete irrelevance to complete relevance.

In general, binary measures characterize each chunk as relevant or irrelevant, a hit or a miss, a positive or a negative. As a result, when considering binary retrieval measures, we can end up in one of the following situations:

- True Positive ➔ A result is retrieved in the top k and is indeed relevant to the user's query; it is correctly retrieved.
- False Positive ➔ A result is retrieved in the top k, but is in fact irrelevant; it is wrongly retrieved.
- True Negative ➔ A result is not retrieved in the top k and is indeed not relevant to the user's query; it is correctly not retrieved.
- False Negative ➔ A result is not retrieved in the top k, but it was in fact relevant; it is wrongly not retrieved.
![None](https://miro.medium.com/v2/resize:fit:700/0*OguoBjuDqzsBq9KU.png)

Image by author

As you can imagine, True situations — True Positive and True Negative — are what we are looking for. On the flip side, False situations — False Negative and False Positive — are what we are trying to minimize, but this is a rather conflicting goal. More specifically, in order to include all relevant results that exist (that is, minimize the False Negatives), we need to make our search more inclusive, but by making the search more inclusive, we also risk increasing the False Positives.

Another distinction we can make is between order-unaware and order-aware relevance measures. As their names indicate, order-unaware measures only express whether a relevant result exists in the top k retrieved text chunks, or not. On the flip side, order-aware measures also take into account the ranking in which a text chunk appears, apart from whether it just makes an appearance on the top k chunks.

All retrieval evaluation measures can be calculated for different values of k, thus, we denote them as ' *some measure'@k*, like HitRate@k or Precision@k (duh!). Anyways, in the rest of this post, I'll be exploring some basic binary, order-unaware, retrieval evaluation metrics.

### Some order-unaware, binary measures

Binary order-unaware measures for evaluating retrieval are the most straightforward and intuitive to understand. Thus, they are a great starting point for getting our heads around what exactly we are trying to measure and evaluate. Some common and useful binary, order-unaware measures are **HitRate@k,** **Recall@k**, **Precision@k, and F1@k**. But let's see all these in some more detail.

#### 🎯HitRate@K

HitRate@K is the simplest of all measures for evaluating the retrieval evaluation. It is a binary measure indicating whether there is at least one relevant result in the top k retrieved chunks, or not. Thus, it can only take two values: either 1 (if at least one relevant doc exists in the retrieved set), or 0 (if none of the retrieved documents is in reality relevant). It really is the most basic measure of success one can imagine — at least hitting the target with something. For a single query and the respective retrieved set of results, HitRate@k can be calculated as follows:

Image by author

In this way, we can calculate different Hit Rates for all queries and retrieved results in a test set, and finally, calculate the average HitRate@K of the entire test set.

Image by author

Arguably, Hit Rate is the simplest, most straightforward, and easiest to calculate retrieval metric; thus, it provides a good starting point for evaluating the retrieval step of our RAG pipeline.

#### 🎯Recall@K

Recall@K expresses how often the *relevant* documents appear within the top k retrieved documents. In essence, it evaluates how good we did with avoiding False Negatives. Recall@k is calculated as follows:

Image by author

Thus, it can range from 0 to 1, with 0 indicating that we only retrieved irrelevant results, and 1 indicating that we only retrieved relevant results (no False Negatives). It is like asking ' *Out of all the items that existed, how many did we get?*'. It indicates how many out of the top k results are truly relevant.

Recall focuses on the quantity of the retrieved results — how many out of all the relevant results did we manage to find? Thus, it functions well as a retrieval measure for scenarios where we need to find as many relevant results as possible, even by retrieving some irrelevant ones along with them.

Thus, the higher a Recall@k we achieve, the more relevant documents we have retrieved with the vector search, out of all the relevant documents that truly exist. On the contrary, retrieving documents with a bad Recall@k score is a rather bad start for the retrieval step of our RAG pipeline — if the appropriate relevant documents and relevant information aren't there in the first place, no magical reranking or LLM model is going to fix the situation.

#### 🎯Precision@k

Precision@k indicates how many of the top k retrieved documents are indeed relevant. In essence, it evaluates how good we did with not including False Positives. Precision@k can be calculated as follows:

Image by author

In other words, precision is the answer to the question " *Out of the items that we retrieved, how many are correct?*". It indicates how many of all the truly relevant results were successfully retrieved in the top k. As a result, it can range from 0 to 1, with 0 indicating that we only retrieved irrelevant results, and 1 indicating that we only retrieved relevant results (no irrelevant results retrieved — no False Positives).

Thereby, Precision@k largely emphasizes each retrieved result being valid, rather than exhaustively finding each and every result. In other words, Precision@k can serve well as a retrieval measure for scenarios valuing the quality of retrieved results over quantity. That is, retrieving results that we are sure are relevant, even if this means we mistakenly reject some relevant results.

#### 🎯F1@K

But what if we need both correct and complete results — what if we need the retrieved set to score high both in Recall and Precision? To achieve this, Recall@K and Precision@K can be combined into a single measure called F1@K, allowing us to create a score that simultaneously balances the validity and completeness of the retrieved results. In particular, F1@k can be calculated as follows:

Image by author

Again, F1@k can range from 0 to 1. An F1@k value close to 1 means that both Precision@k and Recall@k are high, meaning the retrieved results are both accurate and comprehensive. On the flip side, an F1@k value close to zero means that either Recall@k or Recall@k is low, or even both. In this way, F1@k serves as an effective single metric to evaluate balanced retrieval, since it will only be high when both precision and recall are high.

### So, is our vector search any good?

So now let's see how all these play out in the *'War and Peace'* example by answering one more time my favorite question — ' *Who is Anna Pávlovna*?'. As in my previous posts, I will once again be using the *[War and Peace](https://www.gutenberg.org/cache/epub/2600/pg2600.txt)* text as an example, licensed as Public Domain and easily accessible through [Project Gutenberg](https://www.gutenberg.org/). Our code thus far looks like this:

```python
import torch
from sentence_transformers import CrossEncoder
import os
from langchain.chat_models import ChatOpenAI
from langchain.document_loaders import TextLoader
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import FAISS
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.docstore.document import Document
import faiss

api_key = "your_api_key"
#%%
# initialize LLM
llm = ChatOpenAI(openai_api_key=api_key, model="gpt-4o-mini", temperature=0.3)
# initialize cross-encoder model
cross_encoder = CrossEncoder('cross-encoder/ms-marco-TinyBERT-L-2', device='cuda' if torch.cuda.is_available() else 'cpu')
def rerank_with_cross_encoder(query, relevant_docs):
    
    pairs = [(query, doc.page_content) for doc in relevant_docs] # pairs of (query, document) for cross-encoder
    scores = cross_encoder.predict(pairs) # relevance scores from cross-encoder model
    
    ranked_indices = np.argsort(scores)[::-1] # sort documents based on cross-encoder score (the higher, the better)
    ranked_docs = [relevant_docs[i] for i in ranked_indices]
    ranked_scores = [scores[i] for i in ranked_indices]
    
    return ranked_docs, ranked_scores
# initialize embeddings model
embeddings = OpenAIEmbeddings(openai_api_key=api_key)
# loading documents to be used for RAG 
text_folder =  "RAG files"  
documents = []
for filename in os.listdir(text_folder):
    if filename.lower().endswith(".txt"):
        file_path = os.path.join(text_folder, filename)
        loader = TextLoader(file_path)
        documents.extend(loader.load())
splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
split_docs = []
for doc in documents:
    chunks = splitter.split_text(doc.page_content)
    for chunk in chunks:
        split_docs.append(Document(page_content=chunk))
        
documents = split_docs
# normalize knowledge base embeddings
import numpy as np
def normalize(vectors):
    vectors = np.array(vectors)
    norms = np.linalg.norm(vectors, axis=1, keepdims=True)
    return vectors / norms
doc_texts = [doc.page_content for doc in documents]
doc_embeddings = embeddings.embed_documents(doc_texts)
doc_embeddings = normalize(doc_embeddings)
# faiss index with inner product
import faiss
dimension = doc_embeddings.shape[1]
index = faiss.IndexFlatIP(dimension)  # inner product index
index.add(doc_embeddings)
# create vector database w FAISS 
vector_store = FAISS(embedding_function=embeddings, index=index, docstore=None, index_to_docstore_id=None)
vector_store.docstore = {i: doc for i, doc in enumerate(documents)}
def main():
    print("Welcome to the RAG Assistant. Type 'exit' to quit.\n")
    
    while True:
        user_input = input("You: ").strip()
        if user_input.lower() == "exit":
            print("Exiting…")
            break
        # embedding + normalize query
        query_embedding = embeddings.embed_query(user_input)
        query_embedding = normalize([query_embedding]) 
        k_ = 10
        # search FAISS index
        D, I = index.search(query_embedding, k=k_)
        
        # get relevant documents
        relevant_docs = [vector_store.docstore[i] for i in I[0]]
        
        # rerank with our function
        reranked_docs, reranked_scores = rerank_with_cross_encoder(user_input, relevant_docs)
          
        # get top reranked chunks
        retrieved_context = "\n\n".join([doc.page_content for doc in reranked_docs[:5]])
        # get relevant documents
        relevant_docs = [vector_store.docstore[i] for i in I[0]]
        retrieved_context = "\n\n".join([doc.page_content for doc in relevant_docs])
        
        # D contains inner product scores == cosine similarities (since normalized)
        print("\nTop chunks and their cosine similarity scores:\n")
        for rank, (idx, score) in enumerate(zip(I[0], D[0]), start=1):
           print(f"Chunk {rank}:")
           print(f"Cosine similarity: {score:.4f}")
           print(f"Content:\n{vector_store.docstore[idx].page_content}\n{'-'*40}")
               
        # system prompt
        system_prompt = (
            "You are a helpful assistant. "
            "Use ONLY the following knowledge base context to answer the user. "
            "If the answer is not in the context, say you don't know.\n\n"
            f"Context:\n{retrieved_context}"
        )
        # messages for LLM 
        messages = [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_input}
        ]
        # generate response
        response = llm.invoke(messages)
        assistant_message = response.content.strip()
        print(f"\nAssistant: {assistant_message}\n")
if __name__ == "__main__":
    main()
```

Let's tweak it a little bit to calculate some retrieval measures.

First of all, we can add the following section at the beginning of our script, in order to define the retrieval evaluation metrics we want to calculate:

```python
#%% retrieval evaluation metrics
# Function to normalize text
def normalize_text(text):
    return " ".join(text.lower().split())
# Hit Rate @ K 
def hit_rate_at_k(retrieved_docs, ground_truth_texts, k):
    for doc in retrieved_docs[:k]:
        doc_norm = normalize_text(doc.page_content)
        if any(normalize_text(gt) in doc_norm or doc_norm in normalize_text(gt) for gt in ground_truth_texts):
            return True
    return False
# Precision @ k 
def precision_at_k(retrieved_docs, ground_truth_texts, k):
    hits = 0
    for doc in retrieved_docs[:k]:
        doc_norm = normalize_text(doc.page_content)
        if any(normalize_text(gt) in doc_norm or doc_norm in normalize_text(gt) for gt in ground_truth_texts):
            hits += 1
    return hits / k
# Recall @ k
def recall_at_k(retrieved_docs, ground_truth_texts, k):
    matched = set()
    for i, gt in enumerate(ground_truth_texts):
        gt_norm = normalize_text(gt)
        for doc in retrieved_docs[:k]:
            doc_norm = normalize_text(doc.page_content)
            if gt_norm in doc_norm or doc_norm in gt_norm:
                matched.add(i)
                break
    return len(matched) / len(ground_truth_texts) if ground_truth_texts else 0
# F1 @ K
def f1_at_k(precision, recall):
    return 2 * precision * recall / (precision + recall) if (precision + recall) > 0 else 0
```

In order to calculate any of those evaluation metrics, we need to first define a set of queries and the respective truly relevant chunks. This is a rather copious exercise; thus, I will be only demonstrating the process for one query — ' *Who is Anna Pávlovna*? — and the respective relevant text chunks that should ideally be retrieved. In any case, this information — either for just one query or for a real-life evaluation set — can be defined in the form of a ***ground truth dictionary***, allowing us to map various test queries to the expected relevant text chunks.

In particular, we can consider that the relevant chunks that should be included in the ground truth dictionary for our query ' *Who is Anna Pávlovna*?' are the following:

1. "It was in July 1805, and the speaker was the well-known Anna Pávlovna Schérer, maid of honor and favorite of the Empress Márya Fëdorovna. With these words, she greeted Prince Vasíli Kurágin, a man of high rank and importance, who was the first to arrive at her reception. Anna Pávlovna had had a cough for some days. She was, as she said, suffering from la grippe; grippe being then a new word in St. Petersburg, used only by the elite. All her invitations without exception, written in French, and delivered by a scarlet-liveried footman that morning, ran as follows: "If you have nothing better to do, Count (or Prince), and if the prospect of spending an evening with a poor invalid is not too terrible, I shall be very charmed to see you tonight between 7 and 10 — Annette Schérer." "
2. "Anna Pávlovna's "At Home" was like the former one, only the novelty she offered her guests this time was not Mortemart, but a diplomatist fresh from Berlin with the very latest details of the Emperor Alexander's visit to Potsdam, and of how the two august friends had pledged themselves in an indissoluble alliance to uphold the cause of justice against the enemy of the human race. Anna Pávlovna received Pierre with a shade of melancholy, evidently relating to the young man's recent loss by the death of Count Bezúkhov (everyone constantly considered it a duty to assure Pierre that he was greatly afflicted by the death of the father he had hardly known), and her melancholy was just like the august melancholy she showed at the mention of her most august Majesty the Empress Márya Fëdorovna. Pierre felt flattered by this. Anna Pávlovna arranged the different groups in her drawing room with her habitual skill. The large group, in which were"
3. "drawing room with her habitual skill. The large group, in which were Prince Vasíli and the generals, had the benefit of the diplomat. Another group was at the tea table. Pierre wished to join the former, but Anna Pávlovna — who was in the excited condition of a commander on a battlefield to whom thousands of new and brilliant ideas occur which there is hardly time to put in action — seeing Pierre, touched his sleeve with her finger, saying:"

In this way, we can define the ground truth for this one query and the respective chunks that contain the information that can answer the question as follows:

```
query = "Who is Anna Pávlovna?"

ground_truth_texts = [
    "It was in July, 1805, and the speaker was the well-known Anna Pávlovna Schérer, maid of honor and favorite of the Empress Márya Fëdorovna. With these words she greeted Prince Vasíli Kurágin, a man of high rank and importance, who was the first to arrive at her reception. Anna Pávlovna had had a cough for some days. She was, as she said, suffering from la grippe; grippe being then a new word in St. Petersburg, used only by the elite. All her invitations without exception, written in French, and delivered by a scarlet-liveried footman that morning, ran as follows: "If you have nothing better to do, Count (or Prince), and if the prospect of spending an evening with a poor invalid is not too terrible, I shall be very charmed to see you tonight between 7 and 10—Annette Schérer."",

    "Anna Pávlovna's "At Home" was like the former one, only the novelty she offered her guests this time was not Mortemart, but a diplomatist fresh from Berlin with the very latest details of the Emperor Alexander's visit to Potsdam, and of how the two august friends had pledged themselves in an indissoluble alliance to uphold the cause of justice against the enemy of the human race. Anna Pávlovna received Pierre with a shade of melancholy, evidently relating to the young man's recent loss by the death of Count Bezúkhov (everyone constantly considered it a duty to assure Pierre that he was greatly afflicted by the death of the father he had hardly known), and her melancholy was just like the august melancholy she showed at the mention of her most august Majesty the Empress Márya Fëdorovna. Pierre felt flattered by this. Anna Pávlovna arranged the different groups in her drawing room with her habitual skill. The large group, in which were",

    "drawing room with her habitual skill. The large group, in which were Prince Vasíli and the generals, had the benefit of the diplomat. Another group was at the tea table. Pierre wished to join the former, but Anna Pávlovna—who was in the excited condition of a commander on a battlefield to whom thousands of new and brilliant ideas occur which there is hardly time to put in action—seeing Pierre, touched his sleeve with her finger, saying:"
]
```

Finally, we can also add the following section to our `main()` function in order to appropriately calculate and display the evaluation metrics:

```perl
...
        k_ = 10
        # search FAISS index
        D, I = index.search(query_embedding, k=k_)
        
        # get relevant documents
        relevant_docs = [vector_store.docstore[i] for i in I[0]]
        
        # rerank with our function
        reranked_docs, reranked_scores = rerank_with_cross_encoder(user_input, relevant_docs)
        
        # -- NEW SECTION --
        
        # Evaluate reranked docs using metrics
        top_k_docs = reranked_docs[:k_]  # or change \`k\` as needed
        precision = precision_at_k(top_k_docs, ground_truth_texts, k=k_)
        recall = recall_at_k(top_k_docs, ground_truth_texts, k=k_)
        f1 = f1_at_k(precision, recall)
        hit = hit_rate_at_k(top_k_docs, ground_truth_texts, k=k_)
        
        print("\n--- Retrieval Evaluation Metrics ---")
        print(f"Hit@6: {hit}")
        print(f"Precision@6: {precision:.2f}")
        print(f"Recall@6: {recall:.2f}")
        print(f"F1@6: {f1:.2f}")
        print("-" * 40)
        
        # -- NEW SECTION --
        
        # get top reranked chunks
        retrieved_context = "\n\n".join([doc.page_content for doc in reranked_docs[:2]])
        ...
```

Notice that we run the evaluation **after reranking**. Since the metrics we calculate — like Precision@K, Recall@K, and F1@K — **are order-unaware, evaluating them on the top k retrieved chunks before or after reranking yields the same results, as long as the set of top k items remains the same.**

So, for our question ' *Who is Anna Pávlovna*?' and @k = 10, we get the following scores:

Image by author

But what is the meaning of this?

- @k = 10, meaning that we calculate all evaluation metrics on the top 10 retrieved chunks.
- Hit@10 = True, meaning that at least one of the correct (ground truth) chunks was found in the top 10 retrieved chunks.
- Precision@10 = 0.20, meaning that out of the 10 retrieved chunks, only 2 were correct (0.20 = 2/10). In other words, the retriever also brought back irrelevant information; only 20% of what it retrieved was actually useful.
- Recall@10 = 0.67, meaning that we retrieved 67% of all relevant chunks available in the ground truth within the top 10 documents.
- F1@10 = 0.31, indicating the overall retrieval quality combining both precision and recall. An F1 score of 0.31 indicates moderate performance, and we know that this is due to decent recall but low precision.

As mentioned earlier, we can calculate those metrics for any k — it makes sense to calculate only for values of k larger than the number of chunks per query in the ground truth. In this way, we can experiment with different values of k and understand how our retrieval system performs as we expand or narrow the scope of retrieved results.

### On my mind

While metrics like Precision@K, Recall@K, and F1@K can be computed for asingle query and its corresponding set of retrieved chunks (like wedid here), in a real-world evaluation, they are typically evaluated over a collection of queries, known as the test set. More precisely, each query in the test set is associated with its own set of ground truth relevant chunks. We then calculate the retrieval metrics individually for each query, and then average the results across all queries.

Ultimately, understanding the meaning of various retrieval metrics that can be calculated is really important for effectively evaluating and fine-tuning a RAG pipeline. Most importantly, an effective retrieval mechanism — finding the appropriate documents — is the foundation for generating meaningful answers with a RAG setup.

*Loved this post? Let's be friends! Join me on:*

📰 ***[Substack](https://datacream.substack.com/)*** 💌 ***[Medium](https://medium.com/@m.mouschoutzi)*** 💼 ***[LinkedIn](https://www.linkedin.com/in/mariamouschoutzi/)*** ☕ ***[Buy me a coffee](http://buymeacoffee.com/mmouschoutzi)******!***

### What about pialgorithms?

Looking to bring the power of RAG into your organization?

**[pialgorithms](https://pialgorithms.com/)** can do it for you ***👉*** ***[book a demo](https://pialgorithms.com/#contact)*** ***today***

*

*

[#ai](https://medium.com/tag/ai "AI") [#artificial-intelligence](https://medium.com/tag/artificial-intelligence "Artificial Intelligence") [#technology](https://medium.com/tag/technology "Technology") [#data-science](https://medium.com/tag/data-science "Data Science") [#python](https://medium.com/tag/python "Python")

*