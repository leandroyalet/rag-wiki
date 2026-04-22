#!/usr/bin/env bash
set -euo pipefail

QUARTZ_DIR="quartz-build"
QUARTZ_REPO="https://github.com/jackyzha0/quartz.git"
QUARTZ_VERSION="v4"   # branch/tag to pin

# ── 1. Get Quartz ────────────────────────────────────────────────────────────
if [ -d "$QUARTZ_DIR/.git" ]; then
  echo ">> Reusing cached Quartz clone"
  git -C "$QUARTZ_DIR" fetch --quiet
  git -C "$QUARTZ_DIR" checkout --quiet "$QUARTZ_VERSION"
else
  echo ">> Cloning Quartz $QUARTZ_VERSION"
  git clone --branch "$QUARTZ_VERSION" --depth 1 "$QUARTZ_REPO" "$QUARTZ_DIR"
fi

# ── 2. Install dependencies ───────────────────────────────────────────────────
echo ">> Installing Node dependencies"
cd "$QUARTZ_DIR"
npm install --omit=dev

# ── 3. Copy vault content ─────────────────────────────────────────────────────
echo ">> Syncing vault content"
CONTENT_DIR="content"
rm -rf "$CONTENT_DIR"
mkdir -p "$CONTENT_DIR"

# Main wiki pages
cp -r ../02_Wiki/. "$CONTENT_DIR/"

# Meta pages (index, log, lint reports, etc.)
mkdir -p "$CONTENT_DIR/_meta"
cp -r ../_meta/. "$CONTENT_DIR/_meta/"

# Literature notes from 01_Sources/papers/ (md only, no PDFs)
mkdir -p "$CONTENT_DIR/sources/papers"
find ../01_Sources/papers -maxdepth 1 -name "*.md" -exec cp {} "$CONTENT_DIR/sources/papers/" \;

# Web clips from 01_Sources/web_clips/
mkdir -p "$CONTENT_DIR/sources/web_clips"
find ../01_Sources/web_clips -maxdepth 1 -name "*.md" -exec cp {} "$CONTENT_DIR/sources/web_clips/" \;

# Home page — Quartz requires content/index.md at the root
# Promote _meta/index.md to the content root (mv avoids a duplicate)
if [ -f "$CONTENT_DIR/_meta/index.md" ]; then
  mv "$CONTENT_DIR/_meta/index.md" "$CONTENT_DIR/index.md"
else
  echo -e "---\ntitle: RAG - Wiki\n---\n\n# RAG - Wiki\n\nWelcome to the RAG research wiki." > "$CONTENT_DIR/index.md"
fi

# ── 4. Custom Quartz config (optional) ───────────────────────────────────────
if [ -f "../quartz.config.ts" ]; then
  echo ">> Applying custom quartz.config.ts"
  cp ../quartz.config.ts quartz.config.ts
fi

# ── 5. Build ──────────────────────────────────────────────────────────────────
echo ">> Building static site"
npx quartz build

echo ">> Done — output in $QUARTZ_DIR/public"
