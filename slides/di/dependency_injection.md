---
theme: default
background: https://cover.sli.dev
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Dependency Injection
  Breaking the Chains of Tight Coupling

  EAYL Academy 2025
drawings:
  persist: false
transition: slide-left
title: Dependency Injection
mdc: true
---

# Dependency Injection

**Breaking the Chains of Tight Coupling**

<div class="pt-12">
  <span class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    EAYL Academy 2025
  </span>
</div>

---

## What is Dependency Injection?

**Design pattern** that removes hard-coded dependencies

**Dependencies** are provided externally rather than created internally

**Goal**: Loose coupling, better testability, flexibility

---

layout: center
class: text-center

---

## The Problem

---

### Tight Coupling - Hard to Test & Change

<div class="flex items-center justify-center h-full">

```typescript
import { EmailService } from "./EmailService";

export class UserService {
  private emailService = new EmailService(); // Hard dependency!

  async registerUser(email: string, name: string) {
    const user = { email, name, id: Math.random() };

    // This will always send real emails, even in tests!
    await this.emailService.sendWelcomeEmail(user);

    return user;
  }
}

// Hard to test - always uses real email service
const userService = new UserService();
```

</div>

---

layout: center
class: text-center

---

## The Solution

---

### Dependency Injection - Flexible & Testable

<div class="flex items-center justify-center h-full">

```typescript
interface EmailService {
    sendWelcomeEmail(user: any): Promise<void>;
}

export class UserService {
    constructor(private emailService: EmailService) {}  // Injected!

    async registerUser(email: string, name: string) {
        const user = { email, name, id: Math.random() };

        // Uses the injected email service
        await this.emailService.sendWelcomeEmail(user);

        return user;
    }
}

const emailService = new EmailService(...);
const userService = new UserService(emailService));
```

</div>

---

layout: center
class: text-center

---

## Types of Dependency Injection

<div class="grid grid-cols-3 gap-4 mt-8">
  <div>
    <h3>Constructor Injection</h3>
    <p class="text-sm">Dependencies passed via constructor</p>
  </div>
  <div>
    <h3>Property Injection</h3>
    <p class="text-sm">Dependencies set via properties</p>
  </div>
  <div>
    <h3>Method Injection</h3>
    <p class="text-sm">Dependencies passed to methods</p>
  </div>
</div>

---

layout: center
class: text-center

---

## Benefits

---

## 1. **Testability**

<div class="flex items-center justify-center h-full">

```typescript
import { describe, it, expect, vi } from "vitest";

// Easy to mock dependencies for testing
const mockEmailService: EmailService = {
  sendWelcomeEmail: vi.fn(),
};

const userService = new UserService(mockEmailService);

// Test only the UserService logic
await userService.registerUser("test@example.com", "John Doe");
expect(mockEmailService.sendWelcomeEmail).toHaveBeenCalled();
```

</div>

---

## 2. **Flexibility**

<div class="flex items-center justify-center h-full">

```typescript
// Switch implementations easily
const prodUserService = new UserService(
  new SMTPEmailService(), // Real email service
);

const testUserService = new UserService(
  new MockEmailService(), // Fake email service for testing
);

const devUserService = new UserService(
  new ConsoleEmailService(), // Log emails to console
);
```

</div>

---

## 3. **Single Responsibility**

<div class="flex items-center justify-center h-full">

```typescript
// Classes focus on their core responsibility
class UserService {
  // Only handles user registration logic
  // Doesn't worry about how emails are sent
  async registerUser(email: string, name: string) {
    /* ... */
  }
}

class EmailService {
  // Only handles email sending
  async sendWelcomeEmail(user: any): Promise<void> {
    /* ... */
  }
}
```

</div>

---

layout: center
class: text-center

---

## DI Containers

---

### Manual DI

<div class="flex items-center justify-center h-full">

```typescript
const emailService: EmailService = new SMTPEmailService(config.smtp);
const loggerService: Logger = new FileLogger();
const userService = new UserService(emailService);
const orderService = new OrderService(emailService, loggerService);
const paymentService = new PaymentService(emailService, loggerService);
const notificationService = new NotificationService(emailService);

// Can get hard to manage as app grows
```

</div>

---

### DI Container - Automatic Wiring

**More popular in Java and C# ecosystems** (enterprise applications)

**Benefits:**

- Automatic dependency resolution
- Lifecycle management
- Configuration in one place

---

## Example: InversifyJS

<div class="flex items-center justify-center h-full">

```typescript
import { Container, injectable, inject } from "inversify";

@injectable()
class EmailService {
  async sendWelcomeEmail(user: any) {
    /* implementation */
  }
}

@injectable()
class UserService {
  constructor(@inject("EmailService") private emailService: EmailService) {}

  async registerUser(email: string, name: string) {
    const user = { email, name, id: Math.random() };
    await this.emailService.sendWelcomeEmail(user);
    return user;
  }
}

const container = new Container();
container.bind("EmailService").to(EmailService);
container.bind("UserService").to(UserService);

const userService = container.get<UserService>("UserService");
```

</div>

---

layout: center
class: text-center

---

## Best Practices

---

## **Keep Dependencies Minimal**

**Avoid too many dependencies** - May indicate class is doing too much

**Prefer interfaces over concrete classes** - Enables flexibility

**Use constructor injection by default** - Makes dependencies explicit

**Avoid service locator pattern** - Hidden dependencies are harder to test

---

layout: center
class: text-center

---

## Summary

---

## Key Takeaways

| Benefit                   | Description                        |
| ------------------------- | ---------------------------------- |
| **Testability**           | Easy to mock dependencies          |
| **Flexibility**           | Swap implementations easily        |
| **Maintainability**       | Loose coupling, clear dependencies |
| **Single Responsibility** | Classes focus on core logic        |

---

layout: center
class: text-center

---

## Thank You!

### Questions?
