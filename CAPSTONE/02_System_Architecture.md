# 2. System Architecture

## 2.1 Overview
The TRUEGUARD framework architecture consists of three main modules: Data Collection & Analysis, Hallucination Detection Engine, and Mitigation & Reporting. 

## 2.2 System Modules
1. **Data Visualization & Analysis Module (R/ggplot2)**
   - Processes extracted datasets from literature.
   - Generates comparative mathematical plots (Baseline vs. Proposed Models).
2. **LLM Interaction Module (Python/APIs)**
   - Interfaces with Cloud LLMs (e.g., GPT-4, Llama-3 via Groq API).
   - Submits prompts designed to trigger specific hallucination categories (e.g., Logical, Factual, Intent).
3. **TRUEGUARD Evaluation Engine (The Core Framework)**
   - **Input Verification:** Cross-checks prompt constraints and context.
   - **Response Analysis:** Evaluates generated output against a trusted knowledge base or secondary evaluator model.
   - **Scoring System:** Assigns an accuracy and hallucination probability score to the generated text.

## 2.3 Technology Stack
- **Data Analytics:** R, ggplot2, RStudio
- **Implementation & Logic:** Python 3.9+, Pandas, Requests
- **LLM Engine/APIs:** OpenAI / Groq / HuggingFace
- **Deployment & Testing Environment:** Google Colab (for any heavy compute operations), Local Windows environment for scripting and data plotting.
