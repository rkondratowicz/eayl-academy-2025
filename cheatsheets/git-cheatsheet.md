# 🚀 Git Cheatsheet

**Essential Git commands for apprentice developers**

---

## 👶 Your First Git Commands

### Getting Started
```bash
# 👀 See what's happening (use this A LOT!)
git status
```


```bash
# 📦 Stage all your changes for commit
git add .
```


```bash
# 💾 Save your changes with a message
git commit -m "Your message here"
```

> **🎯 Start Here:** These three commands will get you 80% of the way! Use `git status` constantly to see what's happening.

### Checking Your Work
```bash
# 📜 Show your recent commits (simple view)
git log --oneline
```


```bash
# 🔍 See what changes you've made
git diff
```

---

## 🛠️ One-Time Setup

### Tell Git Who You Are
```bash
# Set your name for commits
git config --global user.name "Your Name"
```


```bash
# Set your email for commits
git config --global user.email "your.email@example.com"
```

> **💡 Pro Tip:** Do this setup once on each new computer. Git needs to know who you are!

### Getting Code
```bash
# 📥 Download a project from GitHub
git clone https://github.com/user/repo.git
```


```bash
# ⬇️ Get latest changes from the team
git pull
```

---

## 🌿 Working with Branches (Intermediate)

> **🤔 What's a branch?** Think of it as a separate copy where you can experiment without breaking the main code.

> **⚠️ CRITICAL:** Always `git pull` after switching to main and BEFORE creating a new branch! This prevents complex merge conflicts later.

### Branch Basics
```bash
# 📋 See all your branches (* shows current)
git branch
```


```bash
# 🏠 Go back to the main branch
git checkout main
```


```bash
# ⬇️ Get latest changes BEFORE creating branch
git pull
```


```bash
# ✨ Create a new branch and switch to it
git checkout -b my-new-feature
```

### Simple Branch Management
```bash
# ⬆️ Send your new branch to GitHub
git push -u origin my-new-feature
```


```bash
# 🗑️ Delete a branch you're done with
git branch -d old-branch
```

---

## 🌐 Sharing Your Work

### Getting & Sending Changes
```bash
# ⬇️ Get latest changes from your team
git pull
```


```bash
# ⬆️ Send your commits to GitHub
git push
```


```bash
# ⬆️ First time pushing a new branch
git push -u origin branch-name
```

> **🔄 Daily Routine:** Always `git pull` before you start working, and `git push` after every commit!

---

## 😰 When Things Go Wrong

> **🆘 Don't Panic!** Everyone messes up Git. Here's how to fix common problems.

### Oops, I Made a Mistake!
```bash
# 👀 First, always check what's happening
git status
```


```bash
# ↩️ Undo changes to one file
git checkout -- filename.txt
```


```bash
# ↩️ Undo last commit (keeps your changes)
git reset HEAD~1
```

### Ask for Help
```bash
# 📜 Show recent commits (for asking questions)
git log --oneline -5
```


```bash
# 🔗 Show where your code is stored
git remote -v
```

---

## 🚀 Advanced (When You're Ready)

> **⏰ Come Back Later:** Focus on the basics first. These commands are for when you're more comfortable with Git.

### Merging & Rebasing
```bash
# 🔀 Combine branch into current branch
git merge branch-name
```


```bash
# 📏 Put your commits on top of main
git rebase main
```

### Stashing (Temporary Save)
```bash
# 💾 Temporarily save work in progress
git stash
```


```bash
# 📤 Get your stashed work back
git stash pop
```

### Dangerous Commands (Be Careful!)
```bash
# ⚠️ Undo last commit AND delete changes
git reset --hard HEAD~1
```


```bash
# ⚠️ Force push (safer version)
git push --force-with-lease
```

### Command Chaining (Advanced)
```bash
# 🔗 Run multiple commands in sequence (only if first succeeds)
git checkout main && git pull
```


```bash
# 🔗 Stage, commit, and push in one line
git add . && git commit -m "message" && git push
```

> **💡 The && Operator:** Runs the next command only if the previous one succeeded. Useful but can be confusing for beginners.

---

## 🏢 Application Development Workflow

> **🎓 Advanced Topic:** This is the complete workflow used in professional development. Master the basics above before attempting this!

### Complete Feature Development Process

1. **Switch to main branch**
   ```bash
   git checkout main
   ```

2. **Get latest changes from remote**
   ```bash
   git pull
   ```

3. **Update dependencies (if needed)**
   ```bash
   npm install
   ```

4. **Create and switch to new feature branch**
   ```bash
   git checkout -b "feature/descriptive-name"
   ```

5. **Make your changes and test them locally**
   - Write your code
   - Test thoroughly
   - Make sure everything works

6. **Stage all changes**
   ```bash
   git add .
   ```

7. **Commit with good message**
   ```bash
   git commit -m "Clear description of what you did"
   ```

8. **Push branch to remote**
   ```bash
   git push -u origin feature/descriptive-name
   ```

9. **Create a Pull Request on GitHub for code review**
   - Go to GitHub
   - Create PR from your branch to main
   - Add description of changes

10. **Address feedback and push additional commits if needed**
    ```bash
    # Make requested changes
    git add .
    git commit -m "Address review feedback"
    git push
    ```

11. **Merge PR after approval**
    - Merge via GitHub interface
    - Delete feature branch on GitHub

12. **Switch back and update**
    ```bash
    git checkout main
    git pull
    ```

13. **Clean up old branch**
    ```bash
    git branch -d feature/descriptive-name
    ```

### Branch Naming Conventions
- `feature/user-authentication`
- `bugfix/login-error`
- `hotfix/security-patch`
- Use descriptive, lowercase names with hyphens

---

## 💡 Quick Tips for Apprentices

### Daily Git Routine
1. Start of day: 
   ```bash
   git checkout main
   git pull
   ```
2. **ALWAYS pull first:** Never create a branch without pulling latest changes
3. Create feature branch: `git checkout -b feature/my-task`
4. Work on your code
5. **After EVERY meaningful change:**
   ```bash
   git add .
   git commit -m "Progress on feature"
   git push
   ```

> **☕ Coffee Spill Protection:** Push every commit! Don't wait until end of day - laptops break, coffee spills happen, and you'll lose hours of work.

### Good Commit Messages
✅ **Good:**
- "Add user login validation"
- "Fix navbar responsive layout"
- "Update API endpoint for user data"

❌ **Avoid:**
- "stuff"
- "changes"
- "fix"

### When to Ask for Help
- You see merge conflicts
- `git status` shows something confusing
- You accidentally deleted something important
- You're unsure about any Git command
- **Your laptop breaks and you haven't pushed recent commits**

### Essential Commands to Remember
```bash
# Check what's happening
git status          
```


```bash
# Stage your changes  
git add .           
```


```bash
# Save your changes
git commit -m ""    
```


```bash
# Send to GitHub
git push            
```


```bash
# Get latest changes
git pull            
```

---

**💻 Made for Engineering Academy Apprentices**

*Remember: Everyone struggles with Git at first. The key is to use `git status` frequently and don't be afraid to ask questions!*
