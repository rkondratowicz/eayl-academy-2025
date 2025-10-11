#!/usr/bin/env node

const crypto = require("node:crypto");

// Get command line arguments
const args = process.argv.slice(2);

if (args.length !== 2) {
  console.error("Usage: node crack-password.js <password_length> <target_hash>");
  console.error("Example: node crack-password.js 4 e7cf3ef4f17c3999a94f2c6f612e8a888e5b1026878e4e19398b23bd38ec221a");
  process.exit(1);
}

const passwordLength = parseInt(args[0], 10);
const targetHash = args[1].toLowerCase();

if (Number.isNaN(passwordLength) || passwordLength <= 0) {
  console.error("Error: Password length must be a positive number");
  process.exit(1);
}

if (!/^[a-f0-9]{64}$/i.test(targetHash)) {
  console.error("Error: Invalid SHA256 hash format");
  process.exit(1);
}

// Function to generate SHA256 hash
function sha256(str) {
  return crypto.createHash("sha256").update(str).digest("hex");
}

// Function to generate all possible passwords recursively
function* generatePasswords(length, current = "") {
  if (current.length === length) {
    yield current;
    return;
  }

  for (let charCode = 97; charCode <= 122; charCode++) {
    // 'a' to 'z'
    const char = String.fromCharCode(charCode);
    yield* generatePasswords(length, current + char);
  }
}

// Main function
function crackPassword() {
  console.log(`Starting brute-force attack...`);
  console.log(`Password length: ${passwordLength}`);
  console.log(`Target hash: ${targetHash}`);
  console.log(`Total combinations to try: ${(26 ** passwordLength).toLocaleString()}`);
  console.log("");

  const startTime = Date.now();
  let attempts = 0;
  let found = false;

  for (const password of generatePasswords(passwordLength)) {
    attempts++;
    const hash = sha256(password);

    // Show progress every 100,000 attempts
    if (attempts % 100000 === 0) {
      const _elapsed = ((Date.now() - startTime) / 1000).toFixed(2);
      const rate = ((attempts / (Date.now() - startTime)) * 1000).toFixed(0);
      process.stdout.write(`\rAttempts: ${attempts.toLocaleString()} | Rate: ${rate}/s | Current: ${password}`);
    }

    if (hash === targetHash) {
      const elapsed = ((Date.now() - startTime) / 1000).toFixed(2);
      console.log("\n");
      console.log("✓ PASSWORD FOUND!");
      console.log(`Password: ${password}`);
      console.log(`Hash: ${hash}`);
      console.log(`Attempts: ${attempts.toLocaleString()}`);
      console.log(`Time: ${elapsed} seconds`);
      found = true;
      break;
    }
  }

  if (!found) {
    const elapsed = ((Date.now() - startTime) / 1000).toFixed(2);
    console.log("\n");
    console.log("✗ Password not found");
    console.log(`Total attempts: ${attempts.toLocaleString()}`);
    console.log(`Time: ${elapsed} seconds`);
  }
}

// Run the cracker
crackPassword();
