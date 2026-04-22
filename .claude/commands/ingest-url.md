Fetch a URL, save it as a web clip, then ingest it into the RAG wiki vault.

The URL to ingest is: $ARGUMENTS

## Steps

1. **Fetch the URL** content using the WebFetch tool.

2. **Save as a web clip** in `01_Sources/web_clips/` with a descriptive kebab-case filename derived from the article title and author (e.g., `smith-2024-hybrid-search-survey.md`). Use this frontmatter template:

```yaml
---
title: "<full article title>"
source: "<url>"
author:
  - "<author name>"
published: <YYYY-MM-DD or leave blank if unknown>
created: 2026-04-18
description: "<one-sentence description>"
tags:
  - clippings
---
```

Followed by the full article body in markdown.

3. **Run the ingest flow** on the newly created clip file — identical to the `/ingest` command:
   - Extract entities.
   - Create or update wiki pages in `02_Wiki/`.
   - Cite with `[[01_Sources/web_clips/kebab-case-name]]`.
   - Mark uncitable claims with `> [!todo] Source needed`.

4. **Log the operation** — append to `_meta/log.md`:
```
## YYYY-MM-DD HH:MM — Claude Code (/ingest-url)
- **operation**: ingest-url
- **source**: <url>
- **clip saved**: 01_Sources/web_clips/<filename>
- **files touched**: <list of created/updated wiki pages>
```

After finishing, report: clip filename, pages created (list), pages updated (list).
