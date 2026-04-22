Classify every file in `00_Inbox/` and recommend where to move each one.

## Steps

1. **List** all files in `00_Inbox/`.

2. **For each file**, read it (or its first ~50 lines if large) and determine:
   - **Type**: paper PDF/note, web clip, meeting note, idea/hypothesis, project draft, outline, or already-classified entity.
   - **Destination folder**:
     - Academic paper → `01_Sources/papers/` (needs PDF + sibling `.md` note with paper frontmatter)
     - Web article / blog post → `01_Sources/web_clips/` (kebab-case filename)
     - Meeting note → `04_Meetings/` (`YYYY-MM-DD - short title.md`)
     - Loose idea → `05_Ideas/`
     - Project draft → `03_Projects/<kebab-case-project>/`
     - Outline / draft paper → `06_Outlines/`
   - **Suggested filename**: follow naming conventions from CLAUDE.md section 3.
   - **Suggested tags**: from `_meta/tag-registry.md`.
   - **Frontmatter to add**: which template from `_templates/` to apply.

3. **Output a classification table**:

| File | Type | Destination | Suggested name | Notes |
|------|------|-------------|----------------|-------|
| ... | ... | ... | ... | ... |

4. **Ask the user to confirm** before moving any files. Only move files after explicit approval.

5. After moves are confirmed and executed, **log to `_meta/log.md`**:
```
## YYYY-MM-DD HH:MM — Claude Code (/process-inbox)
- **operation**: process-inbox
- **files processed**: <list>
- **moved to**: <destinations>
```
