# EAYL Academy 2025

Welcome to the EAYL Academy 2025 repository! This contains educational materials, presentations, and resources for the academy program.

## Repository Structure

### 📁 `cheatsheets/`
Quick reference guides and cheat sheets covering various topics:
- `ai-basic-terms.md` - Essential AI terminology and concepts
- `git-cheatsheet.md` - Git commands and workflow reference
- `it-acronyms.md` - Common IT acronyms and their meanings
- `markdown.md` - Markdown syntax and formatting guide
- `nodejs-typescript-guide.md` - A step-by-step guide to initialize a modern Node.js project with TypeScript using ES modules

### 📁 `links/`
Curated collections of useful links and resources:
- `web-dev.md` - Web development resources and tools

### 📁 `slides/`
Presentation materials created with [Slidev](https://sli.dev/):
- `app-configuration/` - Application configuration in Node.js. Managing application settings with environment variables and .env files
- `cryptography-101/` - Basic introduction to cryptography covering hashing, symmetric/asymmetric encryption, signatures, and more
- `di/` - Dependency Injection concepts and patterns
- `js-vs-ts/` - JavaScript vs TypeScript comparison presentation
- `password-storage/` - Password storage in databases: from naive approaches (plaintext) to modern secure methods (bcrypt, Argon2) with salt

**See [slides/README.md](slides/README.md) for detailed usage instructions**

## Quick Start

### Running Presentations Interactively

Use the interactive presentation launcher (requires [gum](https://github.com/charmbracelet/gum)):

```bash
./slides.sh
```

The script will:
- Show you a list of all available presentations
- Let you select one interactively
- Run the selected presentation with Slidev

**Installing gum:**
- macOS/Linux: `brew install gum`
- Other platforms: https://github.com/charmbracelet/gum#installation

