---
title: "Building the Entire RAG Ecosystem and Optimizing Every Component"
source: "https://levelup.gitconnected.com/building-the-entire-rag-ecosystem-and-optimizing-every-component-8f23349b96a4"
author:
  - "[[Fareed Khan]]"
published: 2025-08-11
created: 2026-05-14
description: "“” is published by Fareed Khan in Level Up Coding."
tags:
  - "clippings"
---
## Routing, Indexing, Retrieval, Transformation and more.

Read this story for free: ==[link](https://medium.com/@fareedkhandev/8f23349b96a4?sk=bf79d63d67fe7c4b46afd09850d71985)==

Most teams, when creating a production-ready RAG system on their data, go through many rounds of experimentation and rely on several different components, each requiring its own setup, tuning, and careful handling. These components include…

![](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*ZjozYulECfqrzgMaTEZ-Rg.png)

Production Ready RAG System (Created by Fareed Khan )

1. **Query Transformations:** Rewriting user questions to be more effective for retrieval.
2. **Intelligent Routing:** Directing a query to the correct data source or a specialized tool.
3. **Indexing:** Creating a multi-layered knowledge base.
4. **Retrieval and Re-ranking:** Filtering noise and prioritizing the most relevant context.
5. **Self-Correcting Agentic Flows:** Building systems that can grade and improve their own work.
6. **End-to-End Evaluation:** Objectively measuring the performance of the entire pipeline.

and much more …

> We will learn and code each part of the RAG ecosystem along with visuals for easier understanding, starting from the basics to advanced techniques.

All the code (Theory + Notebook) is available in my GitHub Repo:

## [GitHub - FareedKhan-dev/rag-ecosystem: Understand and code every important component of RAG…](https://github.com/FareedKhan-dev/rag-ecosystem?source=post_page-----8f23349b96a4---------------------------------------)

### Understand and code every important component of RAG architecture - FareedKhan-dev/rag-ecosystem

github.com

My Table of content is divided into several sections. Take a look.

### Understanding Basic RAG System

### Advanced Query Transformations

- [Multi-Query Generation](#8d22)
- [RAG-Fusion](#9d43)
- [Decomposition](#bb02)
- [Step-Back Prompting](#ec25)
- [HyDE](#2e70)

### Routing & Query Construction

- [Logical Routing](#8177)
- [Semantic Routing](#9c86)
- [Query Structuring](#7992)

### Indexing Strategies

- [Multi-Representation Indexing](#fe6a)
- [Hierarchical Indexing (RAPTOR) Knowledge Tree](#460a)
- [Token-Level Precision (ColBERT)](#3ba8)

### Retrieval & Generation

- [Dedicated Re-ranking](#ec82)
- [Self-Correction using AI Agents](#8cd5)
- [Impact of Long Context](#3ce3)

### Manual RAG Evaluation

- [The Core Metrics: What Should We Measure?](#5c3c)
- [Building Evaluators from Scratch with LangChain](#e4c4)

### Evaluation with Frameworks

- [Rapid Evaluation with deepeval](#36c8)
- [Another Powerful Alternative with grouse](#fe82)
- [Evaluation with RAGAS](#298b)

### Summarizing Everything

## Understanding Basic RAG System

Before we look into the basics of RAG, we need to set the environment variables for tracing and other tasks, such as the LLMs API provider we will be using.

```c
import os

# Set LangChain API endpoint and API key
os.environ['LANGCHAIN_ENDPOINT'] = 'https://api.smith.langchain.com'
os.environ['LANGCHAIN_API_KEY'] = <your-api-key>  # Replace with your LangChain API key

# Set OpenAI API key
os.environ['OPENAI_API_KEY'] = <your-api-key>  # Replace with your OpenAI API key
```

You can obtain your `LangSmith` API key from [their official documentation](https://www.langchain.com/langsmith) to trace our RAG product throughout this blog. For the LLM, we will be using the `OpenAI` API but as you may already know, `LangChain` supports a variety of LLM providers as well.

The core RAG pipeline is the foundation of any advanced system, and understanding its components is important. Therefore, before going into the details of advanced components, we first need to understand the core logic of how a RAG system works, **but you can skip this section if you are already aware of how RAG system works.**

![](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*c_yxo0cUH8u7o5an-Tzi0g.png)

Basic RAG system (Created by Fareed Khan )

This simplest RAG can be break into three components:

- **Indexing**: Organize and store data in a structured format to enable efficient searching.
- **Retrieval**: Search and fetch relevant data based on a query or input.
- **Generation**: Create a final response or output using the retrieved data.

Let’s build this simple pipeline from the ground up to see how each piece works.

### Indexing Phase

Before our RAG system can answer any questions, it needs knowledge to draw from. For this, we’ll use a `WebBaseLoader` to pull content directly from [Lilian Weng's excellent blog post](https://lilianweng.github.io/posts/2023-06-23-agent/) on LLM-powered agents.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*dnSg_QmGd4J030_bznvUPw.png)

Indexing phase (Created by Fareed Khan )

```c
import bs4
from langchain_community.document_loaders import WebBaseLoader

# Initialize a web document loader with specific parsing instructions
loader = WebBaseLoader(
    web_paths=("https://lilianweng.github.io/posts/2023-06-23-agent/",),  # URL of the blog post to load
    bs_kwargs=dict(
        parse_only=bs4.SoupStrainer(
            class_=("post-content", "post-title", "post-header")  # Only parse specified HTML classes
        )
    ),
)

# Load the filtered content from the web page into documents
docs = loader.load()
```

The `bs_kwargs` argument helps us target only the relevant HTML tags (`post-content`, `post-title`, etc.), cleaning up our data from the start.

Now that we have the document, we face our first challenge. Feeding a massive document directly into an LLM is inefficient and often impossible due to context window limits.

> This is why **chunking** is a critical step. We need to break the document into smaller, semantically meaningful pieces.

The `RecursiveCharacterTextSplitter` is the recommended tool for this job because it intelligently tries to keep paragraphs and sentences intact.

```c
from langchain.text_splitter import RecursiveCharacterTextSplitter

# Create a text splitter to divide text into chunks of 1000 characters with 200-character overlap
text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)

# Split the loaded documents into smaller chunks
splits = text_splitter.split_documents(docs)
```

With `chunk_size=1000`, we are creating chunks of 1000 characters, and `chunk_overlap=200` ensures there is some continuity between them, which helps preserve context.

Our text is now split, but it’s still just text. To perform similarity searches, we need to convert these chunks into numerical representations called **embeddings**. We will then store these embeddings in a **vector store**, which is a specialized database designed for efficient searching of vectors.

The `Chroma` vector store and `OpenAIEmbeddings` make this incredibly simple. The following line handles both embedding and indexing in one go.

```c
from langchain_community.vectorstores import Chroma
from langchain_openai import OpenAIEmbeddings

# Embed the text chunks and store them in a Chroma vector store for similarity search
vectorstore = Chroma.from_documents(
    documents=splits, 
    embedding=OpenAIEmbeddings()  # Use OpenAI's embedding model to convert text into vectors
)
```

With our knowledge indexed, we are now ready to start asking questions.

### Retrieval

The vector store is our library, and the **retriever** is our smart librarian. It takes a user’s query, embeds it, and then fetches the most semantically similar chunks from the vector store.

![](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*jtf1FoBGfpnDPTTu9N94Wg.png)

Retrieval Phase (Created by Fareed Khan )

Creating a retriever from our `vectorstore` is a one-liner.

```c
# Create a retriever from the vector store
retriever = vectorstore.as_retriever()
```

Let’s test it. We’ll ask a question and see what our retriever finds.

```c
# Retrieve relevant documents for a query
docs = retriever.get_relevant_documents("What is Task Decomposition?")

# Print the content of the first retrieved document
print(docs[0].page_content)

#### OUTPUT ####
Task decomposition can be done (1) by LLM with simple prompting ...
Tree of Thoughts (Yao et al. 2023) extends CoT by exploring multiple ...
```

As you can see, the retriever successfully pulled the most relevant chunk from the blog post that directly discusses “Task decomposition.” This piece of context is exactly what the LLM needs to form an accurate answer.

### Generation

We have our context, but we need an LLM to read it and formulate a human-friendly answer. This is the **“Generation”** step in RAG.

![](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*0K6ognTAEOJQmb6KDL9wBw.png)

Generation Step (Created by Fareed Khan )

First, we need a good prompt template. This instructs the LLM on how to behave. Instead of writing our own, we can pull a pre-optimized one from LangChain Hub.

```c
from langchain import hub

# Pull a pre-made RAG prompt from LangChain Hub
prompt = hub.pull("rlm/rag-prompt")

# printing the prompt
print(prompt)

#### OUTPUT ####
human
You are an assistant for question-answering tasks. Use the following pieces
of retrieved context to answer the question. If you dont know the answer,
just say that you dont know. Use three sentences maximum and keep the
answer concise.

Question: {question} 
Context: {context} 
Answer:
```

Next, we initialize our LLM. We’ll use `gpt-3.5-turbo`.

```c
from langchain_openai import ChatOpenAI

# Initialize the LLM
llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)
```

Now for the final step: chaining everything together. Using the LangChain Expression Language (LCEL), we can pipe the output of one component into the input of the next.

```c
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough

# Helper function to format retrieved documents
def format_docs(docs):
    return "\n\n".join(doc.page_content for doc in docs)

# Define the full RAG chain
rag_chain = (
    {"context": retriever | format_docs, "question": RunnablePassthrough()}
    | prompt
    | llm
    | StrOutputParser()
)
```

Let’s break down this chain:

1. `{"context": retriever | format_docs, "question": RunnablePassthrough()}`: This part runs in parallel. It sends the user's question to the `retriever` to get documents, which are then formatted into a single string by `format_docs`. Simultaneously, `RunnablePassthrough` passes the original question through unchanged.
2. `| prompt`: The context and question are fed into our prompt template.
3. `| llm`: The formatted prompt is sent to the LLM.
4. `| StrOutputParser()`: This cleans up the LLM's output into a simple string.

Now, let’s invoke the entire chain.

```c
# Ask a question using the RAG chain
response = rag_chain.invoke("What is Task Decomposition?")
print(response)

#### OUTPUT ####
Task decomposition is a technique used to break down large tasks
into smaller, more manageable subgoals. This can be achieved by using a
Large Language Model (LLM) with simple prompts, task-specific instructions,
or human inputs. For example, ...
```

And there we have it, our RAG pipeline successfully retrieved relevant information about **“Task Decomposition”** and used it to generate a concise, accurate answer. This simple chain forms the foundation upon which we will build more advanced and powerful capabilities.

## Advanced Query Transformations

So, now that we understand the fundamentals of RAG pipeline. But production systems often reveal the limitations of this basic approach. One of the most common failure points is the user’s query itself.

![](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*FO2U9QA49kjn6OaBGZuq8A.png)

Query Transformation (Created by Fareed Khan )

> A query might be too specific, too broad, or use different vocabulary than our source documents, leading to poor retrieval results.

The solution isn’t to blame the user, it’s to make our system smarter. **Query Transformation** is a set of powerful techniques designed to re-write, expand, or break down the original question to significantly improve retrieval accuracy.

Instead of relying on a single query, we’ll engineer multiple, better-informed queries to cast a wider and more accurate net.

To test these new techniques, we will use the same indexed knowledge base from Basic RAG pipeline section that we have just gone through previously. This ensures we can directly compare the results and see the improvements.

As a quick refresher, here’s how we set up our retriever:

```c
# Load the blog post
loader = WebBaseLoader(
    web_paths=("https://lilianweng.github.io/posts/2023-06-23-agent/",),
    bs_kwargs=dict(
        parse_only=bs4.SoupStrainer(
            class_=("post-content", "post-title", "post-header")
        )
    ),
)
blog_docs = loader.load()

# Split the documents into chunks
text_splitter = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
    chunk_size=300, 
    chunk_overlap=50
)
splits = text_splitter.split_documents(blog_docs)

# Index the chunks in a Chroma vector store
vectorstore = Chroma.from_documents(documents=splits, 
                                    embedding=OpenAIEmbeddings())

# Create our retriever
retriever = vectorstore.as_retriever()
```

Now, with our retriever ready, let’s explore our first query transformation technique.

### Multi-Query Generation

A single user query represents just one perspective. Distance-based similarity search might miss relevant documents that use synonyms or discuss related concepts.

The Multi-Query approach tackles this by using an LLM to generate several different versions of the user’s question, effectively searching from multiple angles.

![](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*GjZoAISn6Jv3CBH87zUNPA.png)

Multi-Query Optimization (Created by Fareed Khan )

We’ll start by creating a prompt that instructs the LLM to generate these alternative questions.

```c
from langchain.prompts import ChatPromptTemplate

# Prompt for generating multiple queries
template = """You are an AI language model assistant. Your task is to generate five 
different versions of the given user question to retrieve relevant documents from a vector 
database. By generating multiple perspectives on the user question, your goal is to help
the user overcome some of the limitations of the distance-based similarity search. 
Provide these alternative questions separated by newlines. Original question: {question}"""
prompt_perspectives = ChatPromptTemplate.from_template(template)

# Chain to generate the queries
generate_queries = (
    prompt_perspectives 
    | ChatOpenAI(temperature=0) 
    | StrOutputParser() 
    | (lambda x: x.split("\n"))
)
```

Let’s test this chain and see what kind of queries it generates for our question.

```c
question = "What is task decomposition for LLM agents?"
generated_queries_list = generate_queries.invoke({"question": question})

# Print the generated queries
for i, q in enumerate(generated_queries_list):
    print(f"{i+1}. {q}")

#### OUTPUT ####
1. How can LLM agents break down complex tasks?
2. What is the process of task decomposition in the context of large language model agents?
3. What are the methods for decomposing tasks for LLM-powered agents?
4. Explain the concept of task decomposition as it applies to AI agents using LLMs.
5. In what ways do LLM agents handle task decomposition?
```

This is excellent. The LLM has rephrased our original question using different keywords like “break down complex tasks”, “methods”, and “process.” Now, we can retrieve documents for all of these queries and combine the results. A simple way to combine them is to take the unique set of all retrieved documents.

```c
from langchain.load import dumps, loads

def get_unique_union(documents: list[list]):
    """ A simple function to get the unique union of retrieved documents """
    # Flatten the list of lists and convert each Document to a string for uniqueness
    flattened_docs = [dumps(doc) for sublist in documents for doc in sublist]
    unique_docs = list(set(flattened_docs))
    return [loads(doc) for doc in unique_docs]

# Build the retrieval chain
retrieval_chain = generate_queries | retriever.map() | get_unique_union

# Invoke the chain and check the number of documents retrieved
docs = retrieval_chain.invoke({"question": question})
print(f"Total unique documents retrieved: {len(docs)}")

#### OUTPUT ####
Total unique documents retrieved: 6
```

By searching with five different queries, we retrieved a total of 6 unique documents, likely capturing a more comprehensive set of information than a single query would have. Now we can feed this context into our final RAG chain.

```c
from operator import itemgetter

# The final RAG chain
template = """Answer the following question based on this context:

{context}

Question: {question}
"""
prompt = ChatPromptTemplate.from_template(template)
llm = ChatOpenAI(temperature=0)

final_rag_chain = (
    {"context": retrieval_chain, "question": itemgetter("question")} 
    | prompt
    | llm
    | StrOutputParser()
)

final_rag_chain.invoke({"question": question})

#### OUTPUT ####
Task decomposition for LLM agents involves breaking down large,
complex tasks into smaller, more manageable sub-goals. This allows
the agent to work through a problem systematically. Methods for
decomposition include using the LLM itself with simple prompts ...
```

> This answer is more robust because it’s based on a wider pool of relevant documents.

### RAG-Fusion

Multi-Query is a great start, but simply taking a union of documents treats them all equally. What if one document was ranked highly by three of our queries, while another was a low-ranked result from only one?

![](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*qIJlH2bVjc1ZZflcniuHCw.png)

RAG Fusion (Created by Fareed Khan )

The first is clearly more important. RAG-Fusion improves on Multi-Query by not just fetching documents, but also …

> **re-ranking** them using a technique called **Reciprocal Rank Fusion (RRF)**.

RRF intelligently combines results from multiple searches. It boosts the score of documents that appear consistently high across different result lists, pushing the most relevant content to the top.

The code is very similar, but we’ll swap our `get_unique_union` function with an RRF implementation.

```c
def reciprocal_rank_fusion(results: list[list], k=60):
    """ Reciprocal Rank Fusion that intelligently combines multiple ranked lists """
    fused_scores = {}

    # Iterate through each list of ranked documents
    for docs in results:
        for rank, doc in enumerate(docs):
            doc_str = dumps(doc)
            if doc_str not in fused_scores:
                fused_scores[doc_str] = 0
            # The core of RRF: documents ranked higher (lower rank value) get a larger score
            fused_scores[doc_str] += 1 / (rank + k)

    # Sort documents by their new fused scores in descending order
    reranked_results = [
        (loads(doc), score)
        for doc, score in sorted(fused_scores.items(), key=lambda x: x[1], reverse=True)
    ]
    return reranked_results
```

The above function will re-rank the documents after they are fetched through similarity search, but we haven’t initialized it yet so let’s do that now.

```c
# Use a slightly different prompt for RAG-Fusion
template = """You are a helpful assistant that generates multiple search queries based on a single input query. \n
Generate multiple search queries related to: {question} \n
Output (4 queries):"""
prompt_rag_fusion = ChatPromptTemplate.from_template(template)

generate_queries = (
    prompt_rag_fusion 
    | ChatOpenAI(temperature=0)
    | StrOutputParser() 
    | (lambda x: x.split("\n"))
)

# Build the new retrieval chain with RRF
retrieval_chain_rag_fusion = generate_queries | retriever.map() | reciprocal_rank_fusion
docs = retrieval_chain_rag_fusion.invoke({"question": question})

print(f"Total re-ranked documents retrieved: {len(docs)}")

#### OUTPUT ####
Total re-ranked documents retrieved: 7
```

The final chain remains the same, but now it receives a more intelligently ranked context. RAG-Fusion is a powerful, low-effort way to increase the quality of your retrieval.

### Decomposition

Some questions are too complex to be answered in a single step. For example, **“What are the main components of an LLM-powered agent, and how do they interact?”** This is really two questions in one.