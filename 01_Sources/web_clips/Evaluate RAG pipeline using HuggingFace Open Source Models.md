---
title: "Evaluate RAG pipeline using HuggingFace Open Source Models"
source: "https://huggingface.co/blog/lucifertrj/evaluate-rag"
author:
  - "[[Tarun Jain]]"
published: 2024-06-26
created: 2026-04-22
description: "A Blog post by Tarun Jain on Hugging Face"
tags:
  - "clippings"
---
In today’s AI era, applications that allow us to interact with data have become essential. Understanding a large book or report by simply uploading the file and querying it is now possible thanks to Retrieval-Augmented Generation (RAG). This method leverages the capabilities of large language models (LLMs) to generate content based on prompts and provided data, incorporating context into queries to reduce hallucinations by consulting source data before responding.

BeyondLLM is an open-source framework that simplifies the development of RAG applications, LLM evaluations, and observability, all in just a few lines of code.

## What is RAG?

Retrieval Augmented Generation (RAG) is an advanced natural language processing (NLP) technique that merges two core NLP tasks: information retrieval and text generation. The purpose of RAG is to enhance text generation by integrating information from external sources, leading to more accurate and contextually relevant responses.

Traditional text generation models like GPT-3 generate text based on patterns learned from extensive datasets, but they might lack access to specific, current, or contextually relevant information. RAG overcomes this limitation by incorporating an information retrieval component.

## RAG Workflow

[![image/png](https://cdn-uploads.huggingface.co/production/uploads/630f3058236215d0b7078806/oC70dfA1DuIOukTwniouG.png)](https://cdn-uploads.huggingface.co/production/uploads/630f3058236215d0b7078806/oC70dfA1DuIOukTwniouG.png)

Retrieval: The model first retrieves relevant information from external sources, which can include databases, knowledge bases, document collections, or even search engine results. This step aims to find snippets or passages of text related to the input or prompt.

Augmentation: The retrieved information is combined with the original input or prompt, enriching the context available to the model. This additional knowledge helps the model produce more informed and accurate responses.

Generation: Finally, the model generates a response that considers both the retrieved information and the original input. This added context enables the model to produce outputs that are more contextually appropriate and relevant.

RAG is particularly useful in NLP tasks such as question-answering, dialogue generation, summarization, and more. By incorporating external knowledge, RAG models can provide more accurate and informative responses than traditional models that rely solely on their training data.

## Building a RAG Pipeline with BeyondLLM

Let's build a RAG pipeline and explore its core concepts using BeyondLLM.

### Step 1: Data Ingestion and Preprocessing

First, we need to load and preprocess the source file. BeyondLLM provides various loaders for different data types, including PDFs and YouTube videos. We can specify text-splitting parameters like chunk\_size and chunk\_overlap during preprocessing.

```python
from beyondllm import source, embeddings, retrieve, llms, generator
import os
from getpass import getpass

os.environ['HUGGINGFACE_ACCESS_TOKEN'] = getpass("Enter your HF API token:")

data = source.fit(path="https://www.youtube.com/watch?v=oJJyTztI_6g", dtype="youtube", chunk_size=1024, chunk_overlap=0)
```

In this step, we load the video from YouTube, preprocess it by splitting the text into manageable chunks of 1024 characters each, with no overlap between the chunks. This preprocessing is crucial because LLMs have a limited context length.

### Step 2: Embeddings

Next, we need an embedding model to convert the chunked text into numerical embeddings. These embeddings facilitate retrievers in comparing queries with embeddings rather than plain text.

```python
from beyondllm.embeddings import HuggingFaceEmbeddings

model_name = 'BAAI/bge-small-en-v1.5'
embed_model = HuggingFaceEmbeddings(model_name=model_name)
```

The HuggingFaceEmbeddings class from BeyondLLM allows us to use various embedding models available on HuggingFace Hub. Here, we use the "BAAI/bge-small-en-v1.5" model for generating embeddings.

### Step 3: Retrieval- Index your data

Now, we define the retriever, which uses an advanced cross-rerank technique to retrieve specific chunks of text. This method compares query and document embeddings directly for accurate relevance assessments.

```python
from beyondllm.retrieve import auto_retriever

retriever = auto_retriever(data=data, embed_model=embed_model, type="cross-rerank", top_k=2)
```

The auto\_retriever method enables efficient retrieval by combining multiple retrieval techniques. In this case, it uses a cross-rerank approach to find the top 2 most relevant chunks of text related to the query.

### Step 4: LLM Generation

An LLM uses the retrieved documents and the user’s query to generate a coherent response. Here, we use the mistralai/Mistral-7B-Instruct-v0.2 model from Huggingface Hub.

```python
from beyondllm.llms import HuggingFaceHubModel

llm = HuggingFaceHubModel(model="mistralai/Mistral-7B-Instruct-v0.2")
```

The HuggingFaceHubModel class allows us to access and use various LLMs available on HuggingFace Hub. In this example, we use the "mistralai/Mistral-7B-Instruct-v0.2" model for generating responses.

### Step 5: Integrating Components

Next, we integrate all components using the generator.Generate method in BeyondLLM.

```python
from beyondllm.generator import Generate

system_prompt = f"""
<s>[INST]
You are an AI Assistant.
Please provide direct answers to questions.
[/INST]
</s>
"""

pipeline = Generate(
    question=" What is the name of the organization mentioned in the video?",
    retriever=retriever,
    system_prompt=system_prompt,
    llm=llm
)

print(pipeline.call())
```

Here, we define a system prompt to guide the LLM's response generation. The Generate class combines the retriever and LLM to form a complete RAG pipeline. The call method executes the pipeline, retrieving relevant chunks and generating a response to the given question.

### Step-6 Evaluate your RAG app

After constructing a complete RAG pipeline, we evaluate its performance using metrics available in BeyondLLM: Context Relevance, Groundedness, Answer Relevance, RAG Triads, and Ground Truth.

- Context Relevance: Measures how relevant the retrieved chunks are to the user’s query.
- Answer Relevance: Assesses the LLM’s ability to generate useful answers.
- Groundedness: Determines the relation of LLM’s responses to the retrieved information.
- Ground Truth: Measures alignment between the LLM’s response and a predefined correct answer.
- RAG Triad: Directly calculates all three key evaluation metrics.

```python
print(pipeline.get_rag_triad_evals())
```

## Conclusion

Thus, we have constructed and evaluated a RAG pipeline that ingests data, creates embeddings, retrieves information, and answers questions with the help of an LLM. BeyondLLM makes it simple to build, evaluate, and observe RAG applications, making AI development more accessible and efficient.

Co-author: [Shivaya Pandey](https://huggingface.co/sh1v4y4)

## Try BeyondLLM

Explore the [cookbook](https://github.com/aiplanethub/beyondllm/tree/main/cookbook) to learn more!

Try out this use case with the BeyondLLM framework on [Colab](https://colab.research.google.com/drive/1vf9ebWWmZDn6vP9uqy-Zgzt8RSUSV-1o?usp=sharing&source=post_page-----c3cd710a6357--------------------------------).

Read the BeyondLLM documentation and create new use cases: [BeyondLLM Documentation](https://beyondllm.aiplanet.com/).

Support the project by giving a ⭐️ to the [GitHub repo](https://github.com/aiplanethub/beyondllm).