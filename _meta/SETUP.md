---
type: meta
tags: [setup, onboarding]
updated: 2026-04-18
---

# Setup for new collaborators

## 1. Requirements

- [Obsidian](https://obsidian.md) ≥ 1.6
- `git` installed locally
- Optional but recommended: `node` ≥ 20 (for Claude Code)
- Optional: [Zotero](https://www.zotero.org/) with **Better BibTeX** (Edit → Preferences → Better BibTeX, citation template: `authEtal2+year`)

## 2. Clone the vault

```bash
git clone git@github.com:<org>/<repo>.git ~/rag-vault
```

If the repo is private, authenticate with SSH or with a fine-grained personal access token (scoped only to this repo).

## 3. Open it in Obsidian

- Open Obsidian → **Open folder as vault** → pick `~/rag-vault`.
- On first open, Obsidian will ask whether you trust the community plugins shipped in `.obsidian/plugins/`. Say yes (they're the team's, audited).

## 4. Required plugins (already in the repo)

- **Obsidian Git** — sync with remote. Enable **commit-and-sync** every 10 min and **pull on startup**.
- **Templater** — templates with dynamic variables (`{{date}}`, etc.). Point it at `_templates/`.
- **Dataview** — queries over frontmatter (useful for `reading-list` and project dashboards).
- **Tag Wrangler** — rename tags globally (needed to keep `tag-registry` clean).

## 5. Optional plugins (recommended)

- **Zotero Integration** — if you work with Zotero, it generates literature notes from your library. Set output folder to `01_Sources/papers/` and template to `_templates/paper.md`.
- **Citations** — lighter alternative if you don't use Zotero Desktop.
- **Pandoc Plugin** — export `06_Outlines/` to PDF/LaTeX/docx.
- **Advanced Slides** — markdown-based slide decks.
- **Excalidraw** — embedded diagrams.

## 6. Configure Git

```bash
cd ~/rag-vault
git config user.name "your name"
git config user.email "you@email"
```

In the Obsidian Git plugin settings:
- **Commit author name/email**: same as above.
- **Commit message**: `{{hostname}}: {{files}}` (helps see who pushed what from where).
- **Vault backup interval**: `10` minutes.
- **Auto pull interval**: `10` minutes.
- **Pull on startup**: ON.

## 7. Install Claude Code (optional, recommended)

```bash
npm install -g @anthropic-ai/claude-code
```

Authenticate with your Anthropic account the first time you run `claude` in the vault directory.

From `~/rag-vault`:

```bash
claude
```

Claude will automatically read `CLAUDE.md` and understand the vault's structure. You can ask things like:
- *"Ingest the paper I just added to `01_Sources/papers/`"*.
- *"Run a lint: find broken links and orphan pages"*.
- *"Summarize everything the vault says about reranking"*.

## 8. Install Obsidian Web Clipper

Browser extension: https://obsidian.md/clipper

### Configuration for this vault

In the Web Clipper settings:

- **Vault**: select the `rag-vault` vault.
- **Default folder**: `01_Sources/web_clips/`.
- **Filename format**: `{{date}} - {{title | safe}}`.
- **Template**: create a new one, see below.

### Suggested Web Clipper template

In the extension, under **Templates → New template**, set the body to:

```markdown
---
type: clip
title: "{{title}}"
url: {{url}}
author: {{author}}
site: {{domain}}
published: {{published}}
clipped: {{date}}
clipped_by: 
tags: [clip, to-review]
status: new
---

# {{title}}

**Source**: {{url}}
**Author**: {{author}} · **Published**: {{published}}

---

{{content}}

---

## Reader notes

_(add your observations, questions, connections to other vault pages here)_
```

Enable "Highlight" so user selections come in as blockquotes in the markdown.

## 9. First session

1. Pull the repo.
2. Add your name to `_meta/CONTRIBUTING.md` if you want (optional).
3. Open `_meta/index.md` and browse around.
4. Pick a paper from [[_meta/reading-list|reading-list]] and get started.

## 10. Troubleshooting

- **Merge conflicts in Obsidian Git**: open the file in an external editor (VS Code), resolve, commit from CLI. Obsidian Git doesn't handle large conflicts well.
- **Plugins not showing up**: Settings → Community plugins → "Restore" after cloning.
- **Very large PDFs in git**: if a paper is > 25 MB, consider Git LFS or keeping it in Zotero and only committing the literature note.
