#!/usr/bin/env bash
# export-pdf.sh — Export a data-deck HTML presentation to PDF
#
# Usage:
#   bash scripts/export-pdf.sh <path-to-html> [output.pdf] [--compact]
#
# Examples:
#   bash scripts/export-pdf.sh ./output/index.html
#   bash scripts/export-pdf.sh ./output/index.html ./report.pdf
#   bash scripts/export-pdf.sh ./output/index.html --compact   # 1280x720, smaller file
#
# What this does:
#   1. Starts a local HTTP server (fonts & ECharts need HTTP)
#   2. Uses Playwright to screenshot each slide at 1920x1080
#   3. Combines all screenshots into a single PDF
#   4. Cleans up temp files
#
# Requirements: Node.js (Playwright is auto-installed in a temp directory)
set -euo pipefail

# ─── Colors ────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

info()  { echo -e "${CYAN}ℹ${NC} $*"; }
ok()    { echo -e "${GREEN}✓${NC} $*"; }
warn()  { echo -e "${YELLOW}⚠${NC} $*"; }
err()   { echo -e "${RED}✗${NC} $*" >&2; }

# ─── Parse flags ──────────────────────────────────────────

VIEWPORT_W=1920
VIEWPORT_H=1080
COMPACT=false

POSITIONAL=()
for arg in "$@"; do
    case $arg in
        --compact)
            COMPACT=true
            VIEWPORT_W=1280
            VIEWPORT_H=720
            ;;
        *)
            POSITIONAL+=("$arg")
            ;;
    esac
done
set -- "${POSITIONAL[@]}"

# ─── Input validation ─────────────────────────────────────

if [[ $# -lt 1 ]]; then
    err "Usage: bash scripts/export-pdf.sh <path-to-html> [output.pdf] [--compact]"
    err ""
    err "Examples:"
    err "  bash scripts/export-pdf.sh ./output/index.html"
    err "  bash scripts/export-pdf.sh ./output/index.html ./report.pdf"
    err "  bash scripts/export-pdf.sh ./output/index.html --compact"
    exit 1
fi

INPUT_HTML="$1"
if [[ ! -f "$INPUT_HTML" ]]; then
    err "File not found: $INPUT_HTML"
    exit 1
fi

# Resolve to absolute path
INPUT_HTML=$(cd "$(dirname "$INPUT_HTML")" && pwd)/$(basename "$INPUT_HTML")

# Output PDF path
if [[ $# -ge 2 ]]; then
    OUTPUT_PDF="$2"
else
    OUTPUT_PDF="$(dirname "$INPUT_HTML")/$(basename "$INPUT_HTML" .html).pdf"
fi

OUTPUT_DIR=$(dirname "$OUTPUT_PDF")
mkdir -p "$OUTPUT_DIR"
OUTPUT_PDF="$OUTPUT_DIR/$(basename "$OUTPUT_PDF")"

echo ""
echo -e "${BOLD}╔══════════════════════════════════════╗${NC}"
echo -e "${BOLD}║    Data Deck → PDF Export             ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════╝${NC}"
echo ""

# ─── Step 1: Check dependencies ───────────────────────────

info "Checking dependencies..."

if ! command -v npx &>/dev/null; then
    err "Node.js is required but not installed."
    err ""
    err "Install Node.js:"
    err "  macOS:   brew install node"
    err "  or visit https://nodejs.org"
    exit 1
fi

ok "Node.js found"

# Detect system Chrome/Edge to avoid downloading Chromium (~150MB)
BROWSER_CHANNEL=""
if [[ "$(uname)" == "Darwin" ]]; then
    if [[ -d "/Applications/Google Chrome.app" ]]; then
        BROWSER_CHANNEL="chrome"
        ok "Found Google Chrome — will use it directly"
    elif [[ -d "/Applications/Microsoft Edge.app" ]]; then
        BROWSER_CHANNEL="msedge"
        ok "Found Microsoft Edge — will use it directly"
    fi
elif [[ "$(uname)" == "Linux" ]]; then
    if command -v google-chrome &>/dev/null || command -v google-chrome-stable &>/dev/null; then
        BROWSER_CHANNEL="chrome"
        ok "Found Google Chrome — will use it directly"
    elif command -v microsoft-edge &>/dev/null; then
        BROWSER_CHANNEL="msedge"
        ok "Found Microsoft Edge — will use it directly"
    fi
fi

if [[ -z "$BROWSER_CHANNEL" ]]; then
    warn "No Chrome/Edge found — will download Chromium (first run only, ~150MB)"
fi

# ─── Step 2: Create the Playwright export script ──────────

TEMP_DIR=$(mktemp -d)
TEMP_SCRIPT="$TEMP_DIR/export-deck.mjs"

SERVE_DIR=$(dirname "$INPUT_HTML")
HTML_FILENAME=$(basename "$INPUT_HTML")

cat > "$TEMP_SCRIPT" << 'EXPORT_SCRIPT'
// export-deck.mjs — Playwright script to export data-deck slides to PDF
//
// Works with data-deck-skill's horizontal slide structure:
//   - #deck container with transform: translateX(-N*100vw)
//   - window.deckGoTo(n) navigation function
//   - ECharts charts that need time to render

import { chromium } from 'playwright';
import { createServer } from 'http';
import { readFileSync, existsSync, mkdirSync, unlinkSync } from 'fs';
import { join, extname } from 'path';

const SERVE_DIR = process.argv[2];
const HTML_FILE = process.argv[3];
const OUTPUT_PDF = process.argv[4];
const SCREENSHOT_DIR = process.argv[5];
const VP_WIDTH = parseInt(process.argv[6]) || 1920;
const VP_HEIGHT = parseInt(process.argv[7]) || 1080;
const BROWSER_CHANNEL = process.argv[8] || ''; // 'chrome', 'msedge', or '' for bundled Chromium

// ─── Static file server ───────────────────────────────────

const MIME_TYPES = {
  '.html': 'text/html', '.css': 'text/css', '.js': 'application/javascript',
  '.json': 'application/json', '.png': 'image/png', '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg', '.gif': 'image/gif', '.svg': 'image/svg+xml',
  '.webp': 'image/webp', '.woff': 'font/woff', '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
};

const server = createServer((req, res) => {
  const decodedUrl = decodeURIComponent(req.url);
  let filePath = join(SERVE_DIR, decodedUrl === '/' ? HTML_FILE : decodedUrl);
  try {
    const content = readFileSync(filePath);
    const ext = extname(filePath).toLowerCase();
    res.writeHead(200, { 'Content-Type': MIME_TYPES[ext] || 'application/octet-stream' });
    res.end(content);
  } catch {
    res.writeHead(404);
    res.end('Not found');
  }
});

const port = await new Promise((resolve) => {
  server.listen(0, () => resolve(server.address().port));
});

console.log(`  Local server on port ${port}`);

// ─── Screenshot each slide ────────────────────────────────

const launchOpts = BROWSER_CHANNEL ? { channel: BROWSER_CHANNEL } : {};
const browser = await chromium.launch(launchOpts);
const page = await browser.newPage({
  viewport: { width: VP_WIDTH, height: VP_HEIGHT },
});

await page.goto(`http://localhost:${port}/`, { waitUntil: 'networkidle' });
await page.evaluate(() => document.fonts.ready);

// Wait for ECharts to load and render
await page.waitForFunction(() => window.echarts != null, { timeout: 15000 }).catch(() => {
  console.log('  Warning: ECharts not detected, charts may not render');
});
await page.waitForTimeout(2000);

// Count slides
const slideCount = await page.evaluate(() => {
  return document.querySelectorAll('.slide').length;
});

console.log(`  Found ${slideCount} slides`);

if (slideCount === 0) {
  console.error('  ERROR: No .slide elements found.');
  await browser.close();
  server.close();
  process.exit(1);
}

// Screenshot each slide
mkdirSync(SCREENSHOT_DIR, { recursive: true });
const screenshotPaths = [];

for (let i = 0; i < slideCount; i++) {
  // Use the deck's own navigation function
  await page.evaluate((index) => {
    // Strategy 1: Use window.deckGoTo (data-deck-skill's nav function)
    if (typeof window.deckGoTo === 'function') {
      window.deckGoTo(index);
    } else {
      // Strategy 2: Direct transform manipulation
      const deck = document.getElementById('deck');
      if (deck) {
        deck.style.transform = `translateX(-${index * 100}vw)`;
      }
    }
  }, i);

  // Wait for slide transition + chart resize
  await page.waitForTimeout(600);

  // Force all .reveal elements visible
  await page.evaluate((index) => {
    const slides = document.querySelectorAll('.slide');
    const currentSlide = slides[index];
    if (currentSlide) {
      currentSlide.querySelectorAll('.reveal').forEach(el => {
        el.style.opacity = '1';
        el.style.transform = 'none';
        el.style.visibility = 'visible';
      });
    }
  }, i);

  // Trigger chart resize for current slide
  await page.evaluate(() => {
    window.dispatchEvent(new Event('resize'));
    window.dispatchEvent(new CustomEvent('slide-change', { detail: { index: 0 } }));
  });

  await page.waitForTimeout(300);

  const screenshotPath = join(SCREENSHOT_DIR, `slide-${String(i + 1).padStart(3, '0')}.png`);
  await page.screenshot({ path: screenshotPath, fullPage: false });
  screenshotPaths.push(screenshotPath);
  console.log(`  Captured slide ${i + 1}/${slideCount}`);
}

await browser.close();
server.close();

// ─── Combine screenshots into PDF ─────────────────────────

console.log('  Assembling PDF...');

const browser2 = await chromium.launch(launchOpts);
const pdfPage = await browser2.newPage();

const imagesHtml = screenshotPaths.map((p) => {
  const imgData = readFileSync(p).toString('base64');
  return `<div class="page"><img src="data:image/png;base64,${imgData}" /></div>`;
}).join('\n');

const pdfHtml = `<!DOCTYPE html>
<html>
<head>
<style>
  * { margin: 0; padding: 0; }
  @page { size: ${VP_WIDTH}px ${VP_HEIGHT}px; margin: 0; }
  .page {
    width: ${VP_WIDTH}px;
    height: ${VP_HEIGHT}px;
    page-break-after: always;
    overflow: hidden;
  }
  .page:last-child { page-break-after: auto; }
  img {
    width: ${VP_WIDTH}px;
    height: ${VP_HEIGHT}px;
    display: block;
    object-fit: contain;
  }
</style>
</head>
<body>${imagesHtml}</body>
</html>`;

await pdfPage.setContent(pdfHtml, { waitUntil: 'load' });
await pdfPage.pdf({
  path: OUTPUT_PDF,
  width: `${VP_WIDTH}px`,
  height: `${VP_HEIGHT}px`,
  printBackground: true,
  margin: { top: 0, right: 0, bottom: 0, left: 0 },
});

await browser2.close();

// Clean up screenshots
screenshotPaths.forEach(p => unlinkSync(p));

console.log(`  ✓ PDF saved to: ${OUTPUT_PDF}`);
EXPORT_SCRIPT

# ─── Step 3: Install Playwright ────────────────────────────

info "Setting up Playwright..."
echo ""

cd "$TEMP_DIR"

cat > "$TEMP_DIR/package.json" << 'PKG'
{ "name": "deck-pdf-export", "private": true, "type": "module" }
PKG

npm install playwright &>/dev/null || {
    err "Failed to install Playwright."
    err "Try: npm install playwright"
    rm -rf "$TEMP_DIR"
    exit 1
}

# Only download Chromium if no system Chrome/Edge is available
if [[ -z "$BROWSER_CHANNEL" ]]; then
    info "Downloading Chromium (first run only)..."
    npx playwright install chromium 2>/dev/null || {
        err "Failed to install Chromium for Playwright."
        err "Try: npx playwright install chromium"
        rm -rf "$TEMP_DIR"
        exit 1
    }
fi

ok "Playwright ready"
echo ""

# ─── Step 4: Run the export ───────────────────────────────

SCREENSHOT_DIR="$TEMP_DIR/screenshots"

info "Exporting slides to PDF..."
echo ""

if [[ "$COMPACT" == "true" ]]; then
    info "Using compact mode (1280×720)"
fi

node "$TEMP_SCRIPT" "$SERVE_DIR" "$HTML_FILENAME" "$OUTPUT_PDF" "$SCREENSHOT_DIR" "$VIEWPORT_W" "$VIEWPORT_H" "$BROWSER_CHANNEL" || {
    err "PDF export failed."
    rm -rf "$TEMP_DIR"
    exit 1
}

# ─── Step 5: Cleanup ──────────────────────────────────────

rm -rf "$TEMP_DIR"

echo ""
echo -e "${BOLD}════════════════════════════════════════${NC}"
ok "PDF exported successfully!"
echo ""
echo -e "  ${BOLD}File:${NC}  $OUTPUT_PDF"
echo ""
FILE_SIZE=$(du -h "$OUTPUT_PDF" | cut -f1 | xargs)
echo "  Size: $FILE_SIZE"
echo ""
echo "  Animations are not preserved (static export)."
echo "  Charts are captured as rendered on screen."
echo -e "${BOLD}════════════════════════════════════════${NC}"
echo ""

# Auto-open
if command -v open &>/dev/null; then
    open "$OUTPUT_PDF"
elif command -v xdg-open &>/dev/null; then
    xdg-open "$OUTPUT_PDF"
fi
