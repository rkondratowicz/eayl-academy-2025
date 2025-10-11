---
applyTo: "**"
---

# Slidev Presentation Instructions

When working with Slidev presentations in this repository, follow these guidelines:

## File Structure and Naming

- Each presentation should be in its own folder under `slides/`
- The markdown file should match the folder name (e.g., `cryptography-101/cryptography-101.md`)
- This ensures unique, descriptive filenames and avoids multiple files named `slides.md`

## Creating New Presentations

When creating a new Slidev presentation:

1. Create a folder in `slides/` with a descriptive kebab-case name
2. Create a markdown file with the same name as the folder
3. Start with proper frontmatter:
   ```yaml
   ---
   theme: default
   title: Your Presentation Title
   transition: view-transition
   mdc: true
   ---
   ```
4. Separate slides with `---`
5. Add npm scripts to `package.json`:
   - `dev:topic-name` - Run in development mode
   - `build:topic-name` - Build for production
   - `export:topic-name-pdf` - Export to PDF
6. Update `build:all` and `export:all` scripts to include the new presentation
7. **Update the main `README.md`** to document the new presentation:
   - Add the new presentation under the `📁 slides/` section
   - Include the folder name, brief description, and filename
   - Maintain alphabetical or logical ordering
   - Keep the existing structure and format

## Slidev Features to Use

- **Layouts**: Use appropriate layouts (`cover`, `center`, `two-cols`, `default`, `end`)
- **Mermaid Diagrams**: Use ` ```mermaid ` code blocks for visual diagrams
  - Include theme and scale options: ` ```mermaid {theme: 'neutral', scale: 0.85} `
  - Use sequence diagrams for processes
  - Use flowcharts for decision trees
  - Use graphs for relationships
- **Code Highlighting**: Use fenced code blocks with language specification
- **Presenter Notes**: Add HTML comments at the end of slides for notes
- **Transitions**: Configure slide transitions in frontmatter

## Code Examples in Presentations

- Always specify the language for syntax highlighting
- Keep examples concise and focused
- Use comments to explain complex concepts
- Format code consistently with the language conventions

## Mermaid Diagram Best Practices

- Use `theme: 'neutral'` for consistent appearance
- Adjust `scale` to fit content (typically 0.7-0.9)
- Add descriptive labels to all nodes
- Use consistent styling with `style` directives
- Keep diagrams simple and focused on one concept

## npm Scripts Convention

Follow this naming pattern for scripts:

- `dev:topic-name` - Development server with hot reload
- `build:topic-name` - Static HTML build in `dist/topic-name`
- `export:topic-name-pdf` - PDF export in the presentation folder
- `build:all` - Build all presentations
- `export:all` - Export all presentations to PDF

## Presentation Content Guidelines

- Start with a cover slide including title and subtitle
- Include a summary or key takeaways slide near the end
- Use an `end` layout for the final slide
- Break complex topics into multiple slides
- Use tables for comparing concepts or features
- Include visual elements (diagrams, icons) to enhance understanding
- Keep text concise - presentations should be visual aids, not documents
- **Layouts**: Use appropriate layouts (`cover`, `center`, `two-cols`, `default`, `end`)
- **Mermaid Diagrams**: Use ` ```mermaid ` code blocks for visual diagrams
- **Word Limit**: Keep slide content to maximum 50 words per slide (excluding code examples)
  - Focus on key points and bullet lists
  - Use visual elements instead of text when possible
  - Code examples don't count toward the 50-word limit

## Documentation and Research

- **Use Context7 MCP**: When creating or updating slides, use the Context7 MCP tool to access up-to-date documentation
  - Search for library-specific documentation with `resolve-library-id`
  - Get comprehensive docs with `get-library-docs`
  - Ensure accurate and current technical information
  - Reference official documentation for code examples and best practices

## Code Formatting

After completing any work on presentations or related code, always run the Biome formatter to ensure consistent code formatting:

```bash
npm run format:biome
```

This should be done as the final step before considering the task complete.
