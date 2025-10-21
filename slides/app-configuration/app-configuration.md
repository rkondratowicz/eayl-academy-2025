---
theme: default
title: Application Configuration in Node.js
transition: view-transition
mdc: true
---

# Application Configuration in Node.js

A beginner's guide to managing application settings

---
layout: default
---

# What is Configuration?

Configuration refers to settings that control how your application behaves  
**without changing the code itself**.

---

# For example

<v-clicks>

- Database connection URLs
- API keys and secrets
- Port numbers
- Feature flags (enabling/disabling features)
- External service endpoints

</v-clicks>

---
layout: default
---

# Why Separate Configuration from Code?

<v-clicks>

- 🔒 **Security**: Keep secrets out of version control
- 🔄 **Flexibility**: Run the same code in different environments
- ✨ **Simplicity**: Change settings without redeploying code
- 🤝 **Collaboration**: Different developers can use different settings locally

</v-clicks>

---
layout: center
---

# Understanding Environment Variables

---
layout: default
---

# What are Environment Variables?

Environment variables are key-value pairs that exist in your **operating system**,  
not in your code.

<v-clicks>

- Every running process (program) has access to its environment
- Think of them as a global key-value store for your system
- They live "outside" your application

</v-clicks>

---
layout: default
---

# Why Do Environment Variables Exist?

<v-clicks>

- Originally designed for system configuration (like `PATH`, `HOME`)
- Allow the same program to behave differently in different contexts
- Separate "what the code does" from "how it should be configured"

</v-clicks>

---
layout: center
---

# Environment Variables in Node.js

---
layout: default
---

# Accessing Environment Variables

In Node.js, all environment variables are available through the `process.env` object:

```typescript {all|2|3|4|6}
// Reading environment variables
const port = process.env.PORT;
const nodeEnv = process.env.NODE_ENV;
const databaseUrl = process.env.DATABASE_URL;

console.log(port); // undefined if not set
```

<v-click>

**Important**: All environment variable values are **strings**, even if they look like numbers!

</v-click>

---
layout: default
---

# Type Conversion

```typescript {all|1|2}
const port: string | undefined = process.env.PORT; // This is a string "3000"
const portNumber: number = parseInt(process.env.PORT || "0"); // Convert to number
```

---
layout: default
---

# Setting Environment Variables

**On Unix/Mac (Terminal):**

```bash
PORT=3000 node app.js
```

**On Windows (Command Prompt):**

```cmd
set PORT=3000 && node app.js
```

**On Windows (PowerShell):**

```powershell
$env:PORT=3000; node app.js
```

---
layout: default
---

# Multiple Environment Variables

```bash
PORT=3000 NODE_ENV=development DATABASE_URL=postgres://localhost/mydb node app.js
```

<v-click>

This gets messy quickly! 😰

</v-click>

---
layout: default
---

# Common Environment Variables in Node.js

## NODE_ENV

The most important environment variable for Node.js applications:

```typescript
if (process.env.NODE_ENV === "production") {
  // Use production settings
} else {
  // Use development settings
}
```

<v-click>

**Common values**: `development`, `production`, `test`

</v-click>

---
layout: center
---

# The Problem with Environment Variables

Setting environment variables manually every time is tedious! 😫

```bash
PORT=3000 DATABASE_URL=postgres://localhost/mydb API_KEY=abc123 SECRET=xyz789 node app.js
```

---
layout: center
---

# Solution: The .env File Pattern

---
layout: default
---

# The .env File

A `.env` file stores environment variables in a simple text file:

**.env**

```
PORT=3000
DATABASE_URL=postgres://localhost/mydb
API_KEY=abc123
SECRET=xyz789
NODE_ENV=development
```

<v-click>

Simple key-value pairs, one per line! ✅

</v-click>

---
layout: default
---

# Using dotenv Package

The `dotenv` package reads `.env` files and loads them into `process.env`:

**Installation:**

```bash
npm install dotenv
```

<v-click>

**Usage (at the top of your main file):**

```typescript
import "dotenv/config";

// Now you can access variables from .env
const port = process.env.PORT; // "3000"
```

</v-click>

---
layout: two-cols-header
---

# Practical Example: Express Server

::left::

**❌ Without Configuration (Bad):**

```typescript
import express from "express";
const app = express();

// Hardcoded values - bad!
app.listen(3000, () => {
  console.log("Server on port 3000");
});
```

::right::

**✅ With Configuration (Good):**

```typescript
import "dotenv/config";
import express from "express";
const app = express();

const PORT = parseInt(process.env.PORT || "3000");

app.listen(PORT, () => {
  console.log(`Server on port ${PORT}`);
});
```

---
layout: default
---

# Complete Example

**.env**

```
PORT=3000
NODE_ENV=development
```

**app.ts**

```typescript {all|1|2-3|5-6|8-13|15-17}{maxHeight:'300px'}
import "dotenv/config";
import express, { Request, Response } from "express";

const app = express();

const PORT = parseInt(process.env.PORT || "3000");
const NODE_ENV = process.env.NODE_ENV || "development";

app.get("/", (req: Request, res: Response) => {
  res.json({
    message: "Hello World",
    environment: NODE_ENV,
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT} in ${NODE_ENV} mode`);
});
```

---
layout: default
---

# Important: .gitignore

**Never commit .env files to version control!** 🚫

**.gitignore**

```
.env
.env.local
.env.*.local
```

<v-clicks>

**Why?**

- Contains secrets and API keys
- Everyone would see your passwords
- Different environments need different values

</v-clicks>

---
layout: default
---

# Best Practice: .env.example

Create a template file that **can** be committed:

**.env.example**

```
PORT=3000
DATABASE_URL=postgres://localhost/mydb
API_KEY=your_api_key_here
SECRET=your_secret_here
NODE_ENV=development
```

<v-click>

This helps other developers know what variables they need to set!

</v-click>

---
layout: default
---

# Configuration Best Practices

<v-clicks>

1. **Always provide defaults** for non-sensitive values

   ```typescript
   const PORT = parseInt(process.env.PORT || "3000");
   ```

2. **Validate required variables** at startup

   ```typescript
   if (!process.env.API_KEY) {
     throw new Error("API_KEY is required");
   }
   ```

3. **Use .env for local development**, but in production use platform-specific tools

4. **Never hardcode secrets** in your code

5. **Document all required variables** in `.env.example`

</v-clicks>

---
layout: default
---

# Different Environments

<v-clicks>

**Development** (`.env`)

```
DATABASE_URL=postgres://localhost/mydb
API_URL=http://localhost:4000
DEBUG=true
```

**Production** (Platform environment variables)

```
DATABASE_URL=postgres://prod-server/mydb
API_URL=https://api.production.com
DEBUG=false
```

Same code, different configuration! 🎉

</v-clicks>

---
layout: default
---

# Common Mistakes to Avoid

<v-clicks>

1. ❌ Committing `.env` files to Git
2. ❌ Forgetting that env vars are strings
3. ❌ Not providing default values
4. ❌ Hardcoding values "just for testing"
5. ❌ Using the same secrets in dev and prod

</v-clicks>

---
layout: default
---

# When to Load dotenv

<v-clicks>

**Load as early as possible** in your application:

```typescript
// ✅ At the very top of your entry point
import "dotenv/config";

import express from "express";
import { db } from "./database.js"; // This might need env vars!
```

**Not here:**

```typescript
// ❌ Too late - other modules might need it
import express from "express";
import { db } from "./database.js";
import "dotenv/config";
```

</v-clicks>

---
layout: default
---

# Production Configuration

In production, **don't use .env files**!

<v-clicks>

Use platform-specific tools:

- **Heroku**: Dashboard or CLI
- **Vercel/Netlify**: Dashboard environment variables
- **Docker**: `-e` flags or docker-compose
- **Kubernetes**: ConfigMaps and Secrets
- **AWS**: Parameter Store or Secrets Manager

Why? Better security, access control, and encryption! 🔐

</v-clicks>

---
layout: default
---

# Real-World Configuration Structure

```ts {*}{maxHeight:'400px'}
// config.ts
import "dotenv/config";

interface Config {
  port: number;
  nodeEnv: string;
  database: {
    url: string;
    poolSize: number;
  };
  api: {
    key: string;
    secret: string;
  };
  features: {
    debugMode: boolean;
  };
}

export const config: Config = {
  port: parseInt(process.env.PORT || "3000"),
  nodeEnv: process.env.NODE_ENV || "development",
  database: {
    url: process.env.DATABASE_URL || "",
    poolSize: parseInt(process.env.DB_POOL_SIZE || "10"),
  },
  api: {
    key: process.env.API_KEY || "",
    secret: process.env.API_SECRET || "",
  },
  features: {
    debugMode: process.env.DEBUG === "true",
  },
};
```

---
layout: default
---

# Using the Config Module

```typescript
// app.ts
import { config } from "./config.js";
import express, { Request, Response } from "express";

const app = express();

app.get("/", (req: Request, res: Response) => {
  res.json({
    environment: config.nodeEnv,
    debugMode: config.features.debugMode,
  });
});

app.listen(config.port, () => {
  console.log(`Server running on port ${config.port}`);
});
```

<v-click>

Centralized configuration! ✨

</v-click>

---
layout: default
---

# Validation Example

```typescript {all|4-9|11-15|17}
// config.ts
import "dotenv/config";

// Required variables
const required = ["DATABASE_URL", "API_KEY"] as const;
for (const key of required) {
  if (!process.env[key]) {
    throw new Error(`Missing required environment variable: ${key}`);
  }
}

// Export validated config
export const config = {
  database: process.env.DATABASE_URL!,
  apiKey: process.env.API_KEY!,
  port: parseInt(process.env.PORT || "3000"),
};
```

---
layout: center
---

# Key Takeaways

---
layout: default
---

# Summary

<v-clicks>

1. **Configuration** separates settings from code
2. **Environment variables** are OS-level key-value pairs
3. **dotenv** makes managing env vars easy locally
4. Always use **`.env.example`** to document required variables
5. **Never commit** `.env` files to version control
6. **Validate** required configuration at startup
7. Use **platform tools** in production, not `.env` files
8. Provide **sensible defaults** when possible

</v-clicks>

---
layout: center
---

# Questions?

---
layout: end
---

# Thank You!
