# Markdown Cheatsheet

## Headers
```
# H1
## H2
### H3
#### H4
##### H5
###### H6
```

## Text Formatting
- **Bold**: `**text**` or `__text__`
- *Italic*: `*text*` or `_text_`
- ~~Strikethrough~~: `~~text~~`
- `Inline code`: `` `code` ``

## Lists
**Unordered:**
```
- Item 1
- Item 2
  - Nested item
```

**Ordered:**
```
1. First item
2. Second item
   1. Nested item
```

## Links & Images
- Link: `[text](URL)`
- Image: `![alt text](URL)`

## Code Blocks
````
```language
code here
```
````


## Tables
**Syntax:**
```
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Row 2    | Data     | More     |
```

**Renders as:**
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Row 2    | Data     | More     |

## Blockquotes
**Syntax:**
```
> This is a blockquote
```

**Renders as:**
> This is a blockquote

## Important Gotchas ⚠️

1. **Line breaks**: Add two spaces at the end of a line  
   to create a line break (or use a blank line for paragraph)

1. **Escaping**: Use backslash `\` to escape special characters: `\*`, `\#`, `\_`

1. **Lists spacing**: Need blank line before/after lists when mixing with other content

1. **Nested lists**: Use 2-4 spaces (be consistent) for proper nesting

1. **Code in lists**: Indent code blocks 4 extra spaces in lists