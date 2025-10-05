---
theme: default
title: Cryptography 101
transition: slide-left
mdc: true
---

# Cryptography 101
## A Basic Introduction to Security Fundamentals

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next page <carbon:arrow-right class="inline"/>
  </span>
</div>

---
layout: default
---

# What is Cryptography?

Cryptography is the practice and study of techniques for secure communication in the presence of adversaries.

**Key Goals:**
- **Confidentiality**: Ensuring information is accessible only to authorized parties
- **Integrity**: Guaranteeing data hasn't been altered
- **Authentication**: Verifying the identity of parties
- **Non-repudiation**: Preventing denial of actions taken

---
layout: two-cols
---

# Basic Concepts

::left::

**Plaintext**
- Original readable message
- Before encryption

**Ciphertext**
- Encrypted message
- Unreadable without key

::right::

**Key**
- Secret information used in encryption/decryption
- Different types for different systems

**Algorithm**
- Mathematical procedure for encryption/decryption
- Should be publicly known (Kerckhoffs's principle)

---
layout: center
---

# Hashing
## One-Way Functions

---

# What is Hashing?

A hash function takes an input and produces a **fixed-size** output (hash/digest).

**Properties:**
- ✅ **Deterministic**: Same input always produces same output
- ✅ **Fast to compute**: Efficient calculation
- ✅ **One-way**: Cannot reverse the hash to get original input
- ✅ **Avalanche effect**: Small input change = completely different hash
- ✅ **Collision resistant**: Hard to find two inputs with same hash

**Common Uses:**
- Password storage
- Data integrity verification
- Digital signatures
- Blockchain

---

# Hashing Process

```mermaid {theme: 'neutral', scale: 0.9}
graph LR
    A["Input Data<br/>(any size)"] --> B[Hash Function<br/>SHA-256]
    B --> C["Hash Output<br/>(fixed size: 256 bits)"]
    style A fill:#e1f5ff
    style B fill:#fff4e1
    style C fill:#e8f5e9
```

**Example:**
```
Input:  "Hello, World!"
SHA-256: a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e

Input:  "Hello, World"  (removed !)
SHA-256: dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f
```

---

# Popular Hash Functions

| Algorithm | Output Size | Status | Use Cases |
|-----------|-------------|--------|-----------|
| **MD5** | 128 bits | ⚠️ Broken | Legacy systems (avoid) |
| **SHA-1** | 160 bits | ⚠️ Deprecated | Git commits (transitioning) |
| **SHA-256** | 256 bits | ✅ Secure | Bitcoin, certificates, general use |
| **SHA-3** | Variable | ✅ Secure | Modern applications |
| **bcrypt** | 184 bits | ✅ Secure | Password hashing |
| **Argon2** | Variable | ✅ Secure | Password hashing (latest) |

---
layout: center
---

# Symmetric Cryptography
## Same Key for Encryption & Decryption

---

# Symmetric Encryption

Both parties use the **same secret key** to encrypt and decrypt messages.

```mermaid {theme: 'neutral', scale: 0.85}
sequenceDiagram
    participant A as Alice
    participant K as Shared Secret Key
    participant B as Bob
    
    Note over A,B: Both have the same key
    A->>A: Encrypt with Key
    A->>B: Send Ciphertext
    B->>B: Decrypt with Key
    Note over B: Reads Plaintext
```

**Advantages:**
- ⚡ Fast and efficient
- 💪 Strong security with proper key length

**Challenges:**
- 🔑 Key distribution problem
- 🔢 Many keys needed (n×(n-1)/2 for n users)

---

# Symmetric Encryption Process

```mermaid {theme: 'neutral', scale: 0.9}
graph LR
    A["Plaintext<br/>Hello"] --> B["Encryption<br/>Algorithm<br/>(AES)"]
    K["Secret Key<br/>🔑"] --> B
    B --> C["Ciphertext<br/>7f3a..."]
    C --> D["Decryption<br/>Algorithm<br/>(AES)"]
    K2["Secret Key<br/>🔑"] --> D
    D --> E["Plaintext<br/>Hello"]
    
    style A fill:#e1f5ff
    style C fill:#ffe1e1
    style E fill:#e8f5e9
    style K fill:#fff9c4
    style K2 fill:#fff9c4
```

---

# Common Symmetric Algorithms

| Algorithm | Key Size | Block Size | Status |
|-----------|----------|------------|--------|
| **DES** | 56 bits | 64 bits | ❌ Insecure |
| **3DES** | 168 bits | 64 bits | ⚠️ Deprecated |
| **AES-128** | 128 bits | 128 bits | ✅ Secure |
| **AES-256** | 256 bits | 128 bits | ✅ Highly Secure |
| **ChaCha20** | 256 bits | Stream | ✅ Modern |

**AES** (Advanced Encryption Standard) is the most widely used today:
- Government approved
- Hardware acceleration available
- Used in HTTPS, VPNs, disk encryption

---
layout: center
---

# Asymmetric Cryptography
## Public Key Cryptography

---

# Asymmetric Encryption

Uses a **pair of keys**: public key (shareable) and private key (secret).

```mermaid {theme: 'neutral', scale: 0.8}
sequenceDiagram
    participant A as Alice
    participant B as Bob
    
    Note over B: Generates Key Pair
    B->>A: Sends Public Key 🔓
    Note over B: Keeps Private Key 🔑
    A->>A: Encrypts with Bob's Public Key
    A->>B: Sends Ciphertext
    B->>B: Decrypts with Private Key
    Note over B: Reads Plaintext
```

**Key Properties:**
- 🔓 Public key can be shared freely
- 🔑 Private key must remain secret
- 🔐 What's encrypted with public key can only be decrypted with private key

---

# Asymmetric Encryption Process

```mermaid {theme: 'neutral', scale: 0.85}
graph TB
    subgraph Sender
        A["Plaintext<br/>Hello"]
        A --> B["Encrypt with<br/>Recipient's Public Key 🔓"]
        B --> C["Ciphertext<br/>a4f2..."]
    end
    
    C --> D["Send over<br/>Insecure Channel"]
    
    subgraph Receiver
        D --> E["Ciphertext<br/>a4f2..."]
        E --> F["Decrypt with<br/>Own Private Key 🔑"]
        F --> G["Plaintext<br/>Hello"]
    end
    
    style A fill:#e1f5ff
    style C fill:#ffe1e1
    style E fill:#ffe1e1
    style G fill:#e8f5e9
```

---

# Asymmetric vs Symmetric

| Feature | Symmetric | Asymmetric |
|---------|-----------|------------|
| **Keys** | One shared key | Key pair (public + private) |
| **Speed** | ⚡ Very fast | 🐢 Slower (100-1000x) |
| **Key Distribution** | ⚠️ Difficult | ✅ Easy (public key) |
| **Key Management** | Many keys for many users | One key pair per user |
| **Use Cases** | Bulk data encryption | Key exchange, signatures |

**Hybrid Approach (SSL/TLS):**
1. Use asymmetric crypto to exchange a symmetric key
2. Use symmetric crypto for actual data encryption
3. Get best of both worlds! 🎯

---

# Common Asymmetric Algorithms

| Algorithm | Key Size | Based On | Use Cases |
|-----------|----------|----------|-----------|
| **RSA** | 2048-4096 bits | Factorization | Encryption, signatures |
| **DSA** | 2048-3072 bits | Discrete log | Digital signatures |
| **ECC** | 256-521 bits | Elliptic curves | Modern systems |
| **Diffie-Hellman** | 2048+ bits | Discrete log | Key exchange |
| **Ed25519** | 256 bits | Edwards curve | SSH keys, signing |

**Note:** ECC provides equivalent security with much smaller keys (256-bit ECC ≈ 3072-bit RSA)

---
layout: center
---

# Digital Signatures
## Authentication & Integrity

---

# What are Digital Signatures?

Digital signatures prove:
- ✍️ **Authentication**: Who created the message
- 🔒 **Integrity**: Message hasn't been modified
- 🚫 **Non-repudiation**: Sender can't deny sending it

```mermaid {theme: 'neutral', scale: 0.85}
sequenceDiagram
    participant A as Alice
    participant B as Bob
    
    Note over A: Has Private Key 🔑
    A->>A: Hash message
    A->>A: Encrypt hash with Private Key
    A->>B: Send message + signature
    B->>B: Hash received message
    B->>B: Decrypt signature with Alice's Public Key 🔓
    B->>B: Compare hashes
    Note over B: ✅ Signature Valid!
```

---

# Digital Signature Process

```mermaid {theme: 'neutral', scale: 0.8}
graph TB
    subgraph Signing
        A["Message"] --> B["Hash Function"]
        B --> C["Message Hash"]
        C --> D["Encrypt with<br/>Private Key 🔑"]
        D --> E["Digital Signature"]
    end
    
    F["Message + Signature"] --> G["Verification"]
    
    subgraph Verification
        G --> H["Hash Message"]
        G --> I["Decrypt Signature<br/>with Public Key 🔓"]
        H --> J["Compare"]
        I --> J
        J --> K["✅ Valid / ❌ Invalid"]
    end
    
    style A fill:#e1f5ff
    style E fill:#fff9c4
    style K fill:#e8f5e9
```

---

# Signature vs Encryption

**Common Confusion:**

```mermaid {theme: 'neutral', scale: 0.75}
graph LR
    subgraph Encryption
        A1["Encrypt with<br/>Recipient's Public Key 🔓"] --> B1["Decrypt with<br/>Recipient's Private Key 🔑"]
    end
    
    subgraph Signature
        A2["Sign with<br/>Sender's Private Key 🔑"] --> B2["Verify with<br/>Sender's Public Key 🔓"]
    end
    
    style A1 fill:#e3f2fd
    style B1 fill:#e3f2fd
    style A2 fill:#fff3e0
    style B2 fill:#fff3e0
```

**Remember:**
- **Encryption**: Private to decrypt (confidentiality)
- **Signature**: Private to sign (authentication)

---
layout: center
---

# Key Exchange
## Securely Sharing Secret Keys

---

# The Key Exchange Problem

How can two parties establish a shared secret over an insecure channel?

```mermaid {theme: 'neutral', scale: 0.85}
sequenceDiagram
    participant A as Alice
    participant E as Eve (Attacker)
    participant B as Bob
    
    Note over A,B: Problem: How to share key?
    A->>E: If Alice sends key directly...
    E->>B: ...Eve can intercept it!
    Note over E: 😈 Eve knows the key!
    Note over A,B: ❌ No confidentiality
```

**Solutions:**
- Diffie-Hellman key exchange
- RSA key transport
- Modern: ECDH (Elliptic Curve Diffie-Hellman)

---

# Diffie-Hellman Key Exchange

Allows two parties to establish a shared secret without ever transmitting it!

```mermaid {theme: 'neutral', scale: 0.75}
sequenceDiagram
    participant A as Alice
    participant B as Bob
    
    Note over A,B: Public: p (prime), g (generator)
    
    Note over A: Choose secret a
    A->>A: Compute A = g^a mod p
    A->>B: Send A (public)
    
    Note over B: Choose secret b
    B->>B: Compute B = g^b mod p
    B->>A: Send B (public)
    
    A->>A: Compute K = B^a mod p
    B->>B: Compute K = A^b mod p
    
    Note over A,B: Both have same K = g^(ab) mod p
    Note over A,B: 🔑 Shared Secret Established!
```

**Security:** Even if Eve sees A and B, she can't compute K without knowing a or b (discrete logarithm problem).

---
layout: center
---

# Certificates & PKI
## Public Key Infrastructure

---

# Digital Certificates

A certificate binds a public key to an identity.

**Certificate Contains:**
- Subject's name (domain, organization)
- Subject's public key
- Issuer (Certificate Authority)
- Validity period
- Digital signature from CA

```mermaid {theme: 'neutral', scale: 0.8}
graph TB
    A["Root CA<br/>🏛️ Trusted Authority"] --> B["Intermediate CA"]
    B --> C["example.com<br/>Certificate"]
    B --> D["another.com<br/>Certificate"]
    
    style A fill:#ffebee
    style B fill:#fff3e0
    style C fill:#e8f5e9
    style D fill:#e8f5e9
```

---

# How HTTPS Works

```mermaid {theme: 'neutral', scale: 0.7}
sequenceDiagram
    participant C as Client (Browser)
    participant S as Server
    
    C->>S: 1. Hello, I want HTTPS
    S->>C: 2. Here's my certificate + public key
    C->>C: 3. Verify certificate with CA
    C->>C: 4. Generate session key
    C->>S: 5. Send session key encrypted with server's public key
    Note over C,S: 6. Both have session key
    C->>S: 7. Encrypted data (symmetric)
    S->>C: 8. Encrypted data (symmetric)
    Note over C,S: 🔐 Secure Communication
```

**Key Points:**
- Asymmetric crypto for initial handshake
- Symmetric crypto for actual data transfer
- Certificate provides authentication

---
layout: center
---

# Best Practices
## Staying Secure

---

# Cryptography Best Practices

**DO:**
- ✅ Use well-established algorithms (AES, RSA, SHA-256)
- ✅ Use adequate key lengths (RSA ≥ 2048, AES ≥ 128)
- ✅ Use trusted libraries (OpenSSL, libsodium)
- ✅ Keep software updated
- ✅ Use authenticated encryption (AES-GCM)
- ✅ Generate truly random keys

**DON'T:**
- ❌ Roll your own crypto
- ❌ Use deprecated algorithms (MD5, DES, RC4)
- ❌ Reuse keys across different purposes
- ❌ Store keys in code or version control
- ❌ Use weak passwords
- ❌ Ignore warnings about certificates

---
layout: center
---

# Summary

---

# Key Takeaways

| Concept | Purpose | Example |
|---------|---------|---------|
| **Hashing** | Integrity, one-way | SHA-256 for passwords |
| **Symmetric** | Fast bulk encryption | AES for file encryption |
| **Asymmetric** | Key exchange, authentication | RSA for TLS handshake |
| **Signatures** | Authentication, non-repudiation | Sign software releases |
| **Certificates** | Identity verification | HTTPS websites |

**Remember:**
- Different tools for different jobs
- Security is a process, not a product
- Stay updated with current best practices
- When in doubt, use established libraries

---
layout: end
---

# Thank You!
## Questions?

<div class="abs-br m-6 text-xl">
  <carbon:security class="inline"/> Cryptography 101
</div>
