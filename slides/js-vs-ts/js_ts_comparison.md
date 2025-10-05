---
theme: default
background: https://cover.sli.dev
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## JavaScript vs TypeScript
  Comparing the dynamic and static approaches to web development
  
  EAYL Academy 2025
drawings:
  persist: false
transition: slide-left
title: JavaScript vs TypeScript
mdc: true
---

# JavaScript vs TypeScript

<div class="flex justify-center items-center gap-8 mt-8">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/javascript/javascript-original.svg" alt="JavaScript" class="w-30 h-30" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/typescript/typescript-original.svg" alt="TypeScript" class="w-30 h-30" />
</div>

<div class="pt-12">
  <span class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    EAYL Academy 2025
  </span>
</div>

---

## Overview

<div class="grid grid-cols-2 gap-8">
  <div>
    <h3>JavaScript</h3>
    <ul>
      <li>Dynamic, interpreted programming language</li>
      <li>Foundation of web development</li>
      <li>Runtime type checking</li>
    </ul>
  </div>
  <div>
    <h3>TypeScript</h3>
    <ul>
      <li>Superset of JavaScript</li>
      <li>Static type checking</li>
      <li>Compiles down to regular JavaScript</li>
    </ul>
  </div>
</div>

---
layout: center
class: text-center
---

## 1. Type Annotations

---

### JavaScript - No Type Checking

<div class="flex items-center justify-center h-full">

```javascript
// No type checking - this will run but may cause runtime errors
function greet(name) {
    return "Hello, " + name.toUpperCase();
}

greet("Alice");      // Works fine
greet(123);          // Runtime error: name.toUpperCase is not a function
greet();             // Runtime error: Cannot read property 'toUpperCase' of undefined
```

</div>

---

### TypeScript - Compile-time Safety

<div class="flex items-center justify-center h-full">

```typescript
// Explicit type annotations prevent errors at compile time
function greet(name: string): string {
    return "Hello, " + name.toUpperCase();
}

greet("Alice");      // ✅ Works fine
greet(123);          // ❌ Compile error: Argument of type 'number' is not assignable...
greet();             // ❌ Compile error: Expected 1 arguments, but got 0
```

</div>

---
layout: center
class: text-center
---

## 2. Variable Type Checking

---

### JavaScript - Dynamic Typing

<div class="flex items-center justify-center h-full">

```javascript
// Variables can change types freely
let count = 42;
count = "forty-two";        // No problem
count = true;               // Also fine
count = { value: 42 };      // Still works

console.log(count.value); // Works, but could break if count isn't an object
```

</div>

---

### TypeScript - Static Typing

<div class="flex items-center justify-center h-full">

```typescript
// Type is inferred from initial assignment
let count = 42;         // TypeScript infers count is a number
count = "forty-two";    // ❌ Error: Type 'string' is not assignable to type 'number'

// Or you can explicitly declare types
let message: string = "Hello";
let isActive: boolean = true;
let score: number = 95;
```

</div>

---
layout: center
class: text-center
---

## 3. Object Structure Validation

---

### JavaScript - No Structure Enforcement

<div class="flex items-center justify-center h-full">

```javascript
// No structure enforcement
function processUser(user) {
    console.log(`Name: ${user.name}, Age: ${user.age}`);
    // What if user doesn't have these properties? Runtime error!
}

processUser({ name: "John" });           // Missing age - undefined
processUser({ firstName: "Jane" });      // Wrong property name - undefined
processUser("not an object");            // Runtime error
```

</div>

---

### TypeScript - Interface-based Validation

<div class="flex items-center justify-center h-full">

```typescript
// Define object structure with interfaces
interface User {
    name: string;
    age: number;
    email?: string;  // Optional property
}

function processUser(user: User): void {
    console.log(`Name: ${user.name}, Age: ${user.age}`);
}

processUser({ name: "John", age: 25 });              // ✅ Works
processUser({ name: "Jane" });                       // ❌ Error: Property 'age' is missing
processUser({ firstName: "Bob", age: 30 });          // ❌ Error: Object literal may only specify known properties
```

</div>

---
layout: center
class: text-center
---

## 4. Arrays and Generics

---

### JavaScript - Mixed Types Allowed

<div class="flex items-center justify-center h-full">

```javascript
// Arrays can contain mixed types
const mixedArray = [1, "hello", true, { id: 1 }];
mixedArray.push("another string");
mixedArray.push(999);

// No way to enforce array content types
function getFirstItem(items) {
    return items[0];
}
```

</div>

---

### TypeScript - Type-safe Arrays & Generics

<div class="flex items-center justify-center h-full">

```typescript
// Type-safe arrays
const numbers: number[] = [1, 2, 3, 4];
const strings: string[] = ["hello", "world"];

numbers.push(5);        // ✅ Works
numbers.push("text");   // ❌ Error: Argument of type 'string' is not assignable to parameter of type 'number'

// Generic functions for type safety
function getFirstItem<T>(items: T[]): T | undefined {
    return items[0];
}

const firstNumber = getFirstItem([1, 2, 3]);      // TypeScript knows this is number | undefined
const firstString = getFirstItem(["a", "b"]);     // TypeScript knows this is string | undefined
```

</div>

---
layout: center
class: text-center
---

## 5. Class Definitions and Access Modifiers

---

### JavaScript - No Access Control

<div class="flex items-center justify-center h-full">

```javascript
// ES6 classes - no built-in access control
class BankAccount {
    constructor(balance) {
        this.balance = balance;  // Anyone can access this
    }
    
    deposit(amount) {
        this.balance += amount;
    }
    
    withdraw(amount) {
        if (amount <= this.balance) {
            this.balance -= amount;
            return true;
        }
        return false;
    }
}

const account = new BankAccount(1000);
account.balance = -999999;  // Oops! Direct manipulation possible
```

</div>

---

### TypeScript - Access Modifiers & Type Safety

<div class="flex items-center justify-center h-full">

```typescript
// Classes with access modifiers and type safety
class BankAccount {
    private balance: number;           // Private - cannot be accessed from outside
    public readonly accountId: string; // Public and readonly
    
    constructor(initialBalance: number, accountId: string) {
        this.balance = initialBalance;
        this.accountId = accountId;
    }
    
    public deposit(amount: number): void {
        if (amount <= 0) {
            throw new Error("Amount must be positive");
        }
        this.balance += amount;
    }
    
    public withdraw(amount: number): boolean {
        if (amount <= 0 || amount > this.balance) {
            return false;
        }
        this.balance -= amount;
        return true;
    }
    
    public getBalance(): number {
        return this.balance;
    }
}

const account = new BankAccount(1000, "ACC123");
account.balance = -999;     // ❌ Error: Property 'balance' is private
account.deposit("50");      // ❌ Error: Argument of type 'string' is not assignable to parameter of type 'number'
```

</div>

---
layout: center
class: text-center
---

## 6. Error Catching at Development Time

---

### JavaScript - Runtime Bug Discovery

<div class="flex items-center justify-center h-full">

```javascript
// This code looks fine but has a subtle bug
function calculateTotal(items) {
    let total = 0;
    for (let item of items) {
        total += item.price * item.quantity;
    }
    return total;
}

// Bug only discovered at runtime
const cart = [
    { price: 10, qty: 2 },      // Oops! Should be 'quantity', not 'qty'
    { price: 15, quantity: 1 }
];

console.log(calculateTotal(cart)); // NaN - hard to debug
```

</div>

---

### TypeScript - Compile-time Error Detection

<div class="flex items-center justify-center h-full">

```typescript
// Interface catches the error before runtime
interface CartItem {
    price: number;
    quantity: number;
}

function calculateTotal(items: CartItem[]): number {
    let total = 0;
    for (let item of items) {
        total += item.price * item.quantity;
    }
    return total;
}

const cart: CartItem[] = [
    { price: 10, qty: 2 },      // ❌ Error: Object literal may only specify known properties
    { price: 15, quantity: 1 }
];
```

---
layout: center
class: text-center
---

## Key Takeaways

---

| Aspect | JavaScript | TypeScript |
|--------|------------|------------|
| **Type Safety** | Runtime errors | Compile-time error catching |
| **Learning Curve** | Easier to start | Requires understanding types |
| **Development Speed** | Fast prototyping | Slower initial setup, faster debugging |

---

| Aspect | JavaScript | TypeScript |
|--------|------------|------------|
| **Tooling Support** | Good | Excellent (autocomplete, refactoring) |
| **File Extension** | `.js` | `.ts` (compiles to `.js`) |
| **Browser Support** | Native | Requires compilation |

---

---
layout: center
class: text-center
---

## Thank You!

### Questions?