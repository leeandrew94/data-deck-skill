# Data Deck Skill

Language: [English](#english) | [中文](README.zh.md)

## English

Generate data-driven HTML slide decks from CSV/Excel files. Single-file output with interactive ECharts charts, KPI dashboards, and data insights.

**Core flow**: Data analysis → Chart generation → Insight extraction → Unified style output

## Quick Start

```bash
npx skills add https://github.com/leeandrew94/data-deck-skill --skill data-deck-skill
```

Or tell any AI Agent with shell access:

```
Clone https://github.com/leeandrew94/data-deck-skill to ~/.claude/skills/data-deck-skill, then verify SKILL.md, assets/, and references/ exist.
```

After installation, just say:

```
Turn this sales data into a weekly report PPT, use business style.
```

## Features

- **Native ECharts charts** — interactive, not screenshots. Hover for details
- **9 visual styles** — Business Clean / Data Tech / Minimal White / Dark Neon / Warm Business / Morandi / Deep Ocean / Fresh Green / Business Report
- **Auto data insights** — extracts key metrics and conclusions from data
- **Keyboard navigation** — ← → / scroll / swipe, like a real PPT
- **Mobile responsive** — auto-switches to vertical scroll on phones
- **Single HTML file** — open in browser, no server needed
- **PDF export** — one command to generate PDF with chart rendering
- **Low-power mode** — press B to disable animations

## Use Cases

**✅ Good for**: Weekly/monthly reports, sales dashboards, business presentations, data analysis demos, reports for leadership/clients

**❌ Not for**: Simple data viewing (use pandas), large-scale real-time queries (use BI tools), collaborative editing

## Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Claude Code | ✅ | Native skill workflow |
| OpenCode | ✅ | Full compatibility |
| Codex | ✅ | Great for PPT generation |
| Cursor | ✅ | Needs file read/write + shell |
| Other local Agents | ✅ | Needs file read/write + shell |
| Plain Chatbot | ❌ | Unstable without file system |

## Visual Styles

| Style | Best For | Primary Color |
|-------|----------|---------------|
| 📊 Business Clean | Formal reports, management | Enterprise Blue |
| 🔬 Data Tech | Analytics, dashboards | Cyan |
| 📄 Minimal White | Print/email | Near-black |
| 🌃 Dark Neon | Social media, launches | Neon Purple |
| 🔥 Warm Business | Marketing, sales review | Amber Orange |
| 🎨 Morandi | Fashion, creative | Morandi tones |
| 🌊 Deep Ocean | Finance, annual reports | Deep Blue |
| 🌿 Fresh Green | ESG, health, sustainability | Forest Green |
| 💼 Business Report | Swiss International style | Klein Blue |

## Page Layouts

| Type | Use Case |
|------|----------|
| Cover | First page: title + subtitle + date |
| KPI Dashboard | Show 3-5 key metrics |
| Chart Page | 1-2 ECharts charts + description |
| Insight Page | 2-4 data-driven conclusions |
| Data Table | Raw data preview (< 100 rows) |
| Closing | Last page: summary / next steps |

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `→` / `Space` | Next page |
| `←` | Previous page |
| `Home` | First page |
| `End` | Last page |
| `B` | Toggle low-power mode |
| `ESC` | Back to first page |

## Directory Structure

```
data-deck-skill/
├── SKILL.md              ← Main instruction file: full workflow
├── README.md             ← This file (English)
├── README.zh.md          ← Chinese documentation
├── assets/
│   ├── template.html     ← HTML template (ECharts loader, pagination engine, 9 theme presets)
│   └── echarts.min.js    ← ECharts local fallback
├── scripts/
│   ├── validate-deck.mjs ← Quality validation script
│   └── export-pdf.sh     ← PDF export script (Playwright screenshots → PDF)
└── references/
    ├── chart-selection.md ← Chart type selection rules + ECharts config templates
    ├── themes.md          ← 9 visual style CSS variable definitions
    ├── layouts.md         ← Page layout templates (cover/KPI/chart/insight/table/closing)
    ├── data-analysis.md   ← Data analysis pipeline (type detection, statistics, transformation)
    ├── components.md      ← Component handbook (KPI cards, chart containers, tables, navigation)
    └── checklist.md       ← Quality checklist (P0/P1/P2/P3 grading)
```

## Workflow

1. **Data analysis** — Read CSV/Excel, auto-detect column types, infer key metrics
2. **Select style** — Choose from 9 presets (custom colors not allowed)
3. **Plan pages** — Cover → KPI → Charts → Insights → Closing
4. **Generate HTML** — Copy template, replace theme colors, fill content and chart config
5. **Self-check** — Compare against checklist, P0 issues must pass
6. **Preview** — Open in browser
7. **Export PDF** (optional) — `bash scripts/export-pdf.sh ./index.html`

## License

MIT
