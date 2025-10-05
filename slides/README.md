# Slides

This directory contains presentation slides created with [Slidev](https://sli.dev/).

## 🚀 Getting Started

### Prerequisites

Make sure you have Node.js installed (version 18 or higher recommended).

### Installation

If you haven't already, install the Slidev dependencies:

```bash
npm install
```

## 📊 Running the Slides

### Development Mode

To run a slide deck in development mode with hot-reload, use the npm scripts:

**Dependency Injection slides:**
```bash
npm run dev:di
```

**JavaScript vs TypeScript comparison:**
```bash
npm run dev:js-ts
```

The slides will open in your browser at `http://localhost:3030` by default.

### Presenter Mode

To open presenter mode while viewing the slides, press `O` (or click the presenter icon). This will open a separate window with:
- Current and next slide preview
- Speaker notes
- Timer

### Navigation

- **Arrow keys** or **Space**: Next slide
- **Arrow keys**: Previous slide
- **F**: Toggle fullscreen
- **O**: Toggle presenter mode
- **D**: Toggle dark mode
- **G**: Go to specific slide (enter slide number)

### Building for Production

To build static HTML for deployment:

**Build a specific deck:**
```bash
npm run build:di        # Builds dependency injection slides
npm run build:js-ts     # Builds JavaScript vs TypeScript slides
```

**Build all decks:**
```bash
npm run build:all
```

The output will be in the `dist` folder (organized by topic).

### Exporting to PDF

To export slides as PDF:

**Export a specific deck:**
```bash
npm run export:di-pdf      # Exports dependency injection slides to PDF
npm run export:js-ts-pdf   # Exports JavaScript vs TypeScript slides to PDF
```

**Export all decks:**
```bash
npm run export:all
```

Note: You may need to install Playwright browsers on first run:

```bash
npx playwright install chromium
```
