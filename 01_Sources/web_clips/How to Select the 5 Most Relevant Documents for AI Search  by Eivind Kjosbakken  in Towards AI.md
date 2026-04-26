---
title: "How to Select the 5 Most Relevant Documents for AI Search | by Eivind Kjosbakken | in Towards AI"
source: "https://freedium-mirror.cfd/https://pub.towardsai.net/how-to-select-the-5-most-relevant-documents-for-ai-search-d22ccd0721e3"
author:
published:
created: 2026-04-23
description: "Improve the document retrieval step of your RAG pipeline"
tags:
  - "clippings"
---
[< Go to the original](https://pub.towardsai.net/how-to-select-the-5-most-relevant-documents-for-ai-search-d22ccd0721e3#bypass)

![Preview image](https://miro.medium.com/v2/resize:fit:700/0*tPlCou9F_MCfoS60.jpg)

## How to Select the 5 Most Relevant Documents for AI Search

## Improve the document retrieval step of your RAG pipeline[Towards AI](https://medium.com/towards-artificial-intelligence "Making AI accessible to 100K+ learners.")androidstudio ~8 min read · October 23, 2025 (Updated: October 23, 2025) · Free: No

In this article, I discuss a specific step of the RAG pipeline: The document retrieval step. This step is critical for any RAG system's performance, considering that without fetching the most relevant documents, it's challenging for an LLM to correctly answer the user's questions. I'll discuss the traditional approach to fetching the most relevant documents, some techniques to improve it, and the benefits you'll see from better document retrieval in your RAG pipeline.

As per my last article on [Enriching LLM Context with Metadata](https://towardsdatascience.com/how-to-enrich-llm-context-to-significantly-enhance-capabilities/), I'll write my main goal for this article:

> ***My goal*** *for this article is to to highlight how you can fetch and filter the most relevant documents for your AI search.*

This figure showcases a traditional RAG pipeline. You start with the user query, which you encode using an embedding model. You then compare this embedding to the precomputed embedding of the entire document corpus. Usually, the documents are split into chunks, with some overlap between them, though some systems also just work with entire documents. After the embedding similarity is calculated, you only keep the top K most relevant documents, where K is a number you choose yourself, usually a number between 10 and 20. The step of fetching the most relevant documents given the semantic similarity is the topic of today's article. After fetching the most relevant documents, you feed them into an LLM along with the user query, and the LLM finally returns a response. Image by the author.

### Table of contents

- Why is optimal document retrieval important?
- Techniques to fetch more relevant documents
- Benefits of improving document retrieval
- Summary

### Why is optimal document retrieval important?

It's important to truly understand why the document fetching step is so critical to any RAG pipeline. To understand this, you must also have a general outline of the flow in a RAG pipeline:

1. The user enters their query
2. The query is embedded, and you calculate embedding similarity between the query and each individual document (or chunk of document)
3. We fetch the most relevant documents based on embedding similarity
4. The most relevant documents (or chunks) are fed into an LLM, and it's prompted to answer the user question given the provided chunks

This figure highlights the concept of embedding similarity. On the left side, you have the user query, with "Summarize the lease agreement". This query is embedded into the vector you see below the text. Furthermore, in the top middle, you have the available document corpus, which in this instance is four documents, all of which have precomputed embeddings. We then calculate the similarity between the query embedding and each of the documents, and come out with a similarity. In this example, K=2, so we feed the two most relevant documents to our LLM for question answering. Image by the author.

Now there are several aspects of the pipeline which is important. Elements such as:

- Which embedding model do you utilize
- Which LLM model do you use
- How many documents (or chunks) do you fetch

However, I would argue that there is likely no aspect more important than the selection of documents. This is because without the correct documents, it doesn't matter how good you're LLM is, or how many chunks you fetch, the answer is most likely to be incorrect.

The model will probably work with a slightly worse embedding model or a slightly older LLM. However, if you don't fetch the correct documents, you're RAG pipeline will fail.

### Traditional approaches

I'll first understand some traditional approaches that are used today, mainly using embedding similarity or keyword search.

#### Embedding similarity

Using embedding similarity to fetch the most relevant documents is the go-to approach today. This is a solid approach that is decent in most use cases. RAG with embedding similarity document retrieval is exactly as I described above.

#### Keyword search

Keyword search is also commonly used to fetch relevant documents. Traditional approaches, such as TF-IDF or BM25, are still used today with success. However, keyword search also has its weaknesses. For example, it only fetches documents based on an exact match, which introduces issues when an exact match is not possible.

Thus, I want to discuss some other techniques you can use to improve your document retrieval step.

### Techniques to fetch more relevant documents

In this section, I will discuss some more advanced techniques to fetch the most relevant documents. I'll divide the section into two. The first section will cover optimizing document retrieval for recall, referring to fetching as many of the relevant documents as possible from the corpus of available documents. The other subsection discusses how to optimize for precision. This means ensuring that the documents you fetch are actually correct and relevant for the user query.

#### Recall: Fetch more of the relevant documents

I'll discuss the following techniques:

- Contextual retrieval
- Fetching more chunks
- Reranking

**Contextual retrieval**

This figure highlights the pipeline for contextual retrieval. The pipeline contains similar elements to a traditional RAG pipeline with the user prompt, the vector database (DB), and prompting the LLM with the top K most relevant chunks. However, contextual retrieval further introduces a few new elements. First is the BM25 index, where all documents (or chunks) are indexed for BM25 search. Whenever a search is performed, we can then quickly index the query and fetch the most relevant documents according to BM25. We then keep the top K most relevant documents from both BM25 and semantic similarity (vector DB), and combine these embeddings. Finally, we, as usual, feed the most relevant documents into the LLM along with the user query, and receive a response. Image by the author.

[Contextual retrieval](https://www.anthropic.com/engineering/contextual-retrieval) is a technique introduced by Anthropic in September 2024. Their article covers two topics: Adding context to document chunks and combining keyword search (BM25) with semantic search to fetch relevant documents.

To add context to documents, they take each document chunk and prompt an LLM, given the chunk and the entire document, to rewrite the chunk to include both information from the given chunk and relevant context from the entire document.

For example, if you have a document divided into two chunks. Where chunk one includes important metadata such as an address, date, location, and time, and the other chunk contains information about a lease agreement. The LLM might rewrite the second chunk to include both the lease agreement and the most relevant part of the first chunk, which in this case is the address, location, and date.

Anthropic also discusses combining semantic search and keyword search in their article, essentially fetching documents with both techniques, and using a prioritized approach to combine the documents retrieved from each technique.

**Fetching more chunks**

A simpler approach to fetch more of the relevant documents is to simply fetch more chunks. The more chunks you fetch, the higher your likelihood of fetching the relevant chunks is. However, this has two main downsides:

- You'll likely get more irrelevant chunks as well (impacting recall)
- You'll increase the amount of tokens you feed to your LLM, which may negatively impact the LLM's output quality

**Reranking for recall**

Rereanking is also a powerful technique, which can be used to increase precision and recall when fetching relevant documents to a user query. When fetching documents based on semantic similarity, you'll assign a similarity score to all chunks, and typically only keep the top K most similar chunks (K is usually a number between 10 and 20, but it varies for different applications). This means that a reranker should attempt to put the relevant documents within the K most relevant documents, while keeping irrelevant documents out of the same list. I think Qwen Reranker is a good model; however, there are also many other rerankers out there.

#### Precision: Filter away irrelevant documents

- Reranking
- LLM verification

**Reranking for precision**

As discussed in the last section on recall, rerankers can also be used to improve precision. Rerankers will increase recall by adding relevant documents into the top K list of most relevant documents. On the other side, rerankers will improve precision, by ensuring that the irrelevant documents stay out of the top K most relevant documents list.

**LLM verification**

Utilizing LLM to judge chunk (or document) relevance is also a powerful technique to filter away irrelevant chunks. You can simply create a function like below:

You then feed each chunk (or document) through this function, and only keep the chunks or documents that are judged as relevant by the LLM.

This technique has two main downsides:

- LLM cost
- LLM response time

You'll be sending a lot of LLM API calls, which will inevitably incur a significant cost. Furthermore, sending so many queries will take time, which adds delay to your RAG pipeline. You should balance this with the need for rapid responses to the users.

### Benefits of improving document retrieval

There are numerous benefits to improving the document retrieval step in your RAG pipeline. Some examples are:

- Better LLM question answering performance
- Less hallucinations
- More often able to correctly answer users' queries
- Essentially, it makes the LLMs' job easier

Overall, the ability of your question answering model will increase in terms of the number of successfully answered user queries. This is the metric I recommend scoring your RAG system after, and you can read more about LLM system evaluations in my article on [Evaluating 5 Million Documents with Automatic Evals](https://eivindkjosbakken.com/2025/09/14/how-to-evaluate-5-million-documents-with-automatic-llm-evaluations/).

Fewer hallucinations are also an incredibly important factor. Hallucinations are one of the most significant issues we are facing with LLMs. They are so detrimental because they lower the users' trust in the question-answer system, which makes them less likely to continue using your application. However, ensuring the LLM both receives the relevant documents (precision), and minimizes the amount of irrelevant documents (recall), is valuable to minimize the amount of hallucinations the RAG system produces.

Less irrelevant documents (precision), also avoids the problems of [context bloat](https://eval.16x.engineer/blog/llm-context-management-guide) (too much noise in the context), or even [context poisoning](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html) (incorrect information provided in the documents).

### Summary

In this article, I've discussed how you can improve the document retrieval step of your RAG pipeline. I started off discussing how I believe the document retrieval step is the most significant part of the RAG pipeline, and you should spend time optimizing this step. Furthermore, I discussed how traditional RAG pipelines fetch relevant documents through semantic search and keyword search. Continuing, I discussed techniques you can utilize to improve both the precision and recall of retrieved documents, with techniques such as contextual retrieval and LLM chunk verification.

**👉 Find me on socials:**

🧑💻 [Get in touch](https://eivindkjosbakken.com/)

🔗 [LinkedIn](https://www.linkedin.com/in/eivind-kjosbakken/)

🐦 [X / Twitter](https://x.com/EivindKjos)

✍️ [Medium](https://oieivind.medium.com/)

Or read my other articles:

- [How to ensure reliability in LLM applications](https://eivindkjosbakken.com/2025/08/16/how-to-ensure-reliability-in-llm-applications/)
- [How to Perform Comprehensive Large Scale LLM Validation](https://eivindkjosbakken.com/2025/09/24/how-to-perform-comprehensive-large-scale-llm-validation/)

[< Go to the original](https://pub.towardsai.net/how-to-select-the-5-most-relevant-documents-for-ai-search-d22ccd0721e3#bypass)