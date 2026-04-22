Audit the vault for structural and content issues and write a lint report.

## Checks to run

Work through `02_Wiki/` systematically. For each check, collect all violations before moving to the next.

### 1. Broken wikilinks
Scan all `.md` files for `[[Page Name]]` links. For each link, verify a file with that name (or an alias matching that name) exists somewhere in the vault. Report links that resolve to nothing.

### 2. Orphan pages
A page is orphaned if no other `.md` file links to it with `[[Page Name]]`. List all pages in `02_Wiki/` that have zero inbound wikilinks. (Exclude `_meta/` and `_templates/`.)

### 3. Missing frontmatter
List any page in `02_Wiki/` that is missing required frontmatter fields: `type`, `tags`, `status`, `created`, `updated`, `sources`.

### 4. Stubs with no body
A page with `status: stub` and a body of only template placeholders (lines starting with `_` or `_(to complete)_`) is effectively empty. Flag it.

### 5. Duplicate concepts
Look for pages that appear to cover the same entity (similar titles, overlapping aliases, or highly similar TL;DR lines). List candidate pairs with a short reason.

### 6. Concepts mentioned but no page
Scan prose in `02_Wiki/` for terms that are written as `[[Link]]` but don't yet have a corresponding page — these are wanted pages. Also note recurring technical terms (capitalised or domain-specific) that appear in multiple pages but have no `[[link]]` yet.

### 7. Contradictions
Look in `_meta/contradictions.md` for already-flagged ones. Scan wiki pages for claims that directly contradict each other (e.g., opposite assessments of a method's performance). Flag the pair of pages and the conflicting statements.

### 8. Uncited claims
Count pages that have body content but no entries in `sources:` frontmatter and no `[[citekey]]` inline citations. List the top offenders.

## Output

Write the full report to `_meta/lint-2026-04-18.md` with this structure:

```markdown
---
type: meta
tags: [lint]
created: 2026-04-18
---

# Lint report — 2026-04-18

## Summary
| Check | Issues found |
|-------|-------------|
| Broken links | N |
| Orphan pages | N |
| Missing frontmatter | N |
| Empty stubs | N |
| Duplicate candidates | N |
| Wanted pages | N |
| Contradictions | N |
| Uncited pages | N |

## Details
...
```

Then **append to `_meta/log.md`**:
```
## YYYY-MM-DD HH:MM — Claude Code (/lint-wiki)
- **operation**: lint-wiki
- **files touched**: _meta/lint-2026-04-18.md
- **notes**: <total issue count>
```

After writing the report, print the summary table to the conversation.
