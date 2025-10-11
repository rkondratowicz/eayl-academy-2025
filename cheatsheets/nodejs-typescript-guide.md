# Modern Node.js + TypeScript Setup Guide

A step-by-step guide to initialize a modern Node.js project with TypeScript using ES modules.

## Step-by-Step Instructions

### 1. Initialize the Project

```bash
mkdir my-project
cd my-project
npm init -y
```

### 2. Install TypeScript and Node Types

```bash
npm install -D typescript @types/node tsx
```

- `typescript`: The TypeScript compiler
- `@types/node`: Type definitions for Node.js
- `tsx`: Modern TypeScript execution engine (alternative to ts-node, better for ES modules)

### 3. Create `tsconfig.json`

Create a `tsconfig.json` file with modern ES module settings:

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "esModuleInterop": true,
    "strict": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### 4. Update `package.json`

Add the `"type": "module"` field and scripts:

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "type": "module",
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "scripts": {
    "dev": "tsx watch src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js"
  },
  "devDependencies": {
    "@types/node": "^24.0.0",
    "tsx": "^4.0.0",
    "typescript": "^5.0.0"
  }
}
```

### 5. Create Project Structure

```bash
mkdir src
touch src/index.ts
```

### 6. Write Some Code

In `src/index.ts`:

```typescript
export function greet(name: string): string {
  return `Hello, ${name}!`;
}

console.log(greet("World"));
```

### 7. Run Your Project

**Development (with hot reload):**

```bash
npm run dev
```

**Build for production:**

```bash
npm run build
```

**Run production build:**

```bash
npm start
```

## Key Points for ES Modules

### File Extensions in Imports

When importing local files, use `.js` extension in imports (TypeScript will resolve to `.ts` files):

```typescript
import { something } from "./utils.js";
```

### `__dirname` Alternative

ES modules don't have `__dirname`. Use this instead:

```typescript
import { fileURLToPath } from "url";
import { dirname } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
```

### Top-level Await

Top-level await is supported by default in ES modules:

```typescript
const data = await fetchSomeData();
console.log(data);
```

## Summary

You now have a modern Node.js + TypeScript project with ES modules. The `tsx` tool provides fast development with hot reloads, and you can build optimized JavaScript for production with `tsc`.

## Next steps

You can now install your favourite test framework, linter and formatter.  
I recommend:

- [Vitest](https://vitest.dev/) for testing
- [Biome](https://biomejs.dev/) for linting and formatting
