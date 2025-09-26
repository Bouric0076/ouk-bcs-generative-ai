# Week 1 Jac Assignment – Daily Motivation Journal

## 📖 Idea

This project implements a **Daily Motivation Journal** in [Jac](https://jaseci.org/).  
Instead of a number guessing game, the program allows the user to **record their mood** (e.g., "happy", "stressed", "tired") and then generates a **motivational or reflective response** using an AI model.

The goal is to demonstrate:
- Jac's **object model** (`walker`, `node`, `impl`) for structuring logic.
- **Scale-agnostic design**: the same program runs locally or as an API (`jac serve journal.jac`).
- **AI integration** with `byLLM`, showing how Jac can connect to language models to enhance interactivity.

---

## ⚙️ Implementation

The program consists of:
- **`node journal_entry`** → stores the user’s mood and AI-generated response.
- **`walker JournalWalker`** → handles the user’s input, spawns a journal entry, and calls the LLM for a reflection.
- **`motivate(mood)`** → an AI-powered function defined with `byLLM` that generates the motivational text.
- **`with entry:__main__`** → enables local CLI testing by prompting the user for their mood.

---

## 📂 File Breakdown

- `journal.jac`: Main Jac source code implementing the program.
- `requirements.txt`: Lists Jac and byLLM dependencies.
- `README.md`: This file, describing the idea, design, and instructions.

---

## ▶️ Running the Program

### 1. Clone the Repository
```bash
git clone https://github.com/<your-username>/week1-jac-assignment.git
cd week1-jac-assignment
