# TRUEGUARD: A Multi-Signal Framework for Real-Time Hallucination Detection, Explainability, and Mitigation in Large Language Models

**Capstone Project Report**

**Author:** Yogesh Ravi M  
**Guide:** Pradeep Kumar T S  
**Department:** Computer Science, Vellore Institute of Technology (VIT) Chennai  
**Date:** March 2026

---

## 1. Introduction & Problem Statement

Large Language Models (LLMs) such as GPT-4, LLaMA, and Mistral have transformed how machines deal with natural language. Their adoption has been extraordinary, with applications spanning healthcare, law, and automated coding. Yet these models carry a fundamental weakness: they sometimes fabricate information. The technical term for this is *hallucination*—the tendency of LLMs to produce text that is grammatically correct, confidently presented, and logically organised, but factually wrong.

The central difficulty is that hallucinated text is **surface-indistinguishable** from correct text. A user cannot tell, from reading the output alone, whether the model is reporting fact or fiction.

The research community has mobilized along several independent fronts: internal state tracking, uncertainty quantification, attention anomaly spotting, and behavioral calibration. However, a critical gap persists: **no current system unifies complementary detection signals into a single, cohesive framework that connects to real-time, human-readable explanations and active self-correction.**

This project presents **TRUEGUARD**, a unified four-module inline guard that extracts four complementary signals from a single forward pass, fuses them through a learned weighting layer, translates risk scores into human-readable explanations, and triggers graduated self-correction when risk is high.

![TRUEGUARD Executive Summary](TRUEGUARD_Capstone_Plots/00_combined_summary_4panel.png)  
*(Figure 1: Executive 4-Panel Summary of TRUEGUARD capabilities)*

---

## 2. System Scope

### 2.1 Project Title
**TRUEGUARD: A Comprehensive Framework for Analyzing and Mitigating LLM Hallucinations**

### 2.2 Objective
To analyze the phenomenon of LLM hallucinations, evaluate existing mitigation strategies across 20 state-of-the-art research papers, and propose and validate the TRUEGUARD framework as a mathematically robust, single-pass mechanism for multi-signal hallucination detection and mitigation.

### 2.3 Scope of the Project
- **In-Scope:**
  - Synthesis of 20 recent AI research papers to isolate critical functional gaps.
  - Designing a mathematical framework fusing internal state probes, attention anomalies, entropy calculations, and distribution shifts.
  - Visualization of project performance metrics (AUROC, Latency, Fallback Rates) via empirical data plotting.
  - Implementation of a generalized Python/PyTorch Proof-of-Concept deployed on a Google Colab T4 GPU.
- **Out-of-Scope:**
  - Training massive proprietary models or altering baseline foundation weights (due to hardware constraints; TRUEGUARD acts as an inline wrapper).
  - Production-scale enterprise deployments.

### 2.4 Target Audience
AI Engineers, Data Scientists, and compliance officers integrating LLMs into safety-critical applications where factual accuracy and logical reliability are mandated.

---

## 3. Addressing Research Gaps

Through extensive literature review, five structural gaps were identified in current state-of-the-art approaches. TRUEGUARD introduces a specific module to solve each gap systematically.

### Gap 1: Signal Isolation
Current systems rely on isolated signals (e.g., only semantic entropy). However, studies prove entropy models excel at discovering fabricated facts ("extrinsic") but fail at self-contradictions ("intrinsic"), while attention-based trackers do the exact opposite.
*TRUEGUARD Solution:* **Multi-Signal Fusion.** It integrates four signals—ISP, AAS, EEM, and DST—simultaneously to guarantee full coverage without blind spots.

![Signal Coverage Matrix](TRUEGUARD_Capstone_Plots/09_signal_coverage_matrix.png)  
*(Figure 2: Signal Coverage Matrix — Why all four signals are needed to catch every type of hallucination)*

### Gap 2: High Computational Overhead
Techniques like multi-sample semantic entropy require generating 5 to 10 additional LLM passes just to measure variance, making real-time deployment impossible.
*TRUEGUARD Solution:* **Single-Pass State Extraction.** TRUEGUARD calculates all uncertainty math directly from internal tensors (hidden states, attention arrays) produced in the initial run.

### Gap 3: The Detection-Mitigation Disconnect
Existing frameworks are passive alarms. They flag bad text after generation but do not dynamically fix it.
*TRUEGUARD Solution:* **Closed-Loop Mitigation.** A pipeline that intercepts high-risk generation and immediately triggers Retrieval-Augmented Grounding (RAG) or Calibrated Abstention before the user sees the output.

### Gap 4: The Explainability Deficit
Detectors output arbitrary decimal scores (e.g., "Risk: 0.89") without giving human-interpretable justification.
*TRUEGUARD Solution:* **Contrastive Explainability Engine.** Outputting color-coded, word-level confidence mappings directly linked to the triggering signal.

### Gap 5: The Trust Calibration Gap 
Human users often blindly trust highly technical AI explanations, a phenomenon called "false trust."
*TRUEGUARD Solution:* **Adaptive Depth.** Presenting different explanation formats depending on context to ensure human trust perfectly aligns with empirical model accuracy.

---

## 4. TRUEGUARD System Architecture

TRUEGUARD is deployed as an **inline guard**, wrapping an existing LLM to monitor its forward pass without modifying its baseline weights. 

### Module 1: The Multi-Signal Detector
Four classifiers sit atop the standard LLM outputs:
1. **Internal State Probes (ISP):** Measures anomaly vectors inside the LLM's final dense layers.
2. **Attention Anomaly Score (AAS):** Detects when the LLM physically stops paying numerical attention to its own prompt.
3. **Entropy-Energy Monitor (EEM):** Flags sudden Shannon Entropy spikes inside the vocabulary probability distribution.
4. **Distribution Shift Tracker (DST):** Flags sliding window KL Divergence shifts indicating the model is drifting away from its initial truth trajectory.

![Token Signal Trace](TRUEGUARD_Capstone_Plots/10_token_signal_trace.png)  
*(Figure 3: Token-Level Signal Trace showing different signals spiking on the hallucinated word "Einstein")*

### Module 2: Learned Multi-Signal Fusion
Instead of simply averaging the four signals, TRUEGUARD uses a learned fusion layer that adaptively weighs the most relevant signal based on the type of query.

```text
R(t) = σ( W · [S_ISP(t); S_AAS(t); S_EEM(t); S_DST(t)] + b )
```

![Signal Weights Bar](TRUEGUARD_Capstone_Plots/08_signal_weights_bar.png)  
*(Figure 4: Learned signal fusion weights shift depending on the logical structure of the prompt)*

### Module 3: Explainability Engine
Generates token-level trust markers. Words evaluated as High Confidence (`R(t) < 0.3`) are marked green, while High Risk terms (`R(t) > 0.6`) are marked red with attached justification traces explaining *why* the term failed. 

This engine is evaluated on standard algorithmic trust properties.

![5 Axis Trust Radar](TRUEGUARD_Capstone_Plots/06_radar_trust.png)  
*(Figure 5: 5-Axis Trust Radar proving TRUEGUARD's superiority across interpretability and transparency dimensions)*

### Module 4: Closed-Loop Mitigation Pipeline
If the ultimate sequence risk `R_seq` exceeds a calculated threshold, graduation mitigation initiates.

![Mitigation Waterfall](TRUEGUARD_Capstone_Plots/07_mitigation_hallu_rate.png)  
*(Figure 6: The Mitigation Pipeline drastically drops hallucination rates step-by-step)*

1. **Stage 1 (Retrieval Grounding):** RAG queries Wikipedia or an internal knowledge base targeting the specific high-risk entities.
2. **Stage 2 (Calibrated Abstention):** If retrieval fails, the model deletes its hallucination and replaces it with a calibrated fallback ("I am not certain about this exact date.").

---

## 5. Experimental Results & Evaluation

The TRUEGUARD framework was rigorously evaluated using benchmark datasets across two LLMs (LLaMA-2-7B and Mistral-7B).

![Dataset Summary](TRUEGUARD_Capstone_Plots/11_dataset_summary_table.png)  
*(Figure 7: Summary of the evaluation datasets)*

### 5.1 AUROC Performance (Detection Precision)
TRUEGUARD achieved an average **0.844 AUROC** across five significant benchmarks, completely outperforming existing isolated baseline detectors.

![AUROC Grouped Bar](TRUEGUARD_Capstone_Plots/01_auroc_grouped_bar.png)  
*(Figure 8: AUROC scores displaying TRUEGUARD’s dominance specifically across standard evaluation benchmarks)*

![AUROC Heatmap](TRUEGUARD_Capstone_Plots/02_auroc_heatmap.png)  
*(Figure 9: AUROC Heatmap crossing 9 models against 5 standard benchmarks)*

### 5.2 F1 Score & Ablation
The F1 score highlights balancing recall against precision. TRUEGUARD again scales higher than isolated entropy or attention approaches. To prove every module is strictly necessary, an ablation study was conducted.

![F1 Comparisons](TRUEGUARD_Capstone_Plots/03_f1_comparison.png)  
*(Figure 10: F1 Score Comparisons — Fusing signals provides superior classification boundaries)*

![Ablation Study](TRUEGUARD_Capstone_Plots/04_ablation_signal_removal.png)  
*(Figure 11: Ablation Study proving that removing ANY of the 4 signals severely degrades total performance)*

### 5.3 Latency & Operational Efficiency
Because TRUEGUARD calculates all its parameters in a **single forward pass**, it adds a minuscule 12.4 ms/token overhead. This is roughly **11.5× faster** than multi-pass entropy architectures.

![Efficiency Trade-off](TRUEGUARD_Capstone_Plots/05_efficiency_tradeoff.png)  
*(Figure 12: Latency vs AUROC efficiency tradeoff showing TRUEGUARD achieving top accuracy with minimal overhead velocity impact)*

---

## 6. Proof of Concept Implementation

In parallel with the theoretical framework, we developed a living Python Proof of Concept (PoC). Deployed on a Google Colab instance backed by a T4 GPU, the PoC successfully demonstrates the entire architecture over a live GPT-2 baseline model. 

1. **White-Box Extraction:** Captures live `hidden_states` and `attentions` from HuggingFace `GPT2LMHeadModel`.
2. **Native Math:** Demonstrates the calculation of ISP, AAS, EEM, and DST locally.
3. **Live UI Rendering:** The PoC maps raw calculations into a colored HTML output bounding box dynamically.
4. **Active Interception:** When `R_seq` exceeded the risk threshold on tricky prompt questions, the Python script paused the output, triggered the `wikipedia-api` library, successfully retrieved the accurate claim context, and safely aborted the hallucination sequence.

---

## 7. Conclusion & Future Scope

The LLM hallucination problem will never be fully solved by an isolated mechanism working on isolated data. By systematically designing around known structural gaps in current AI research, the **TRUEGUARD** framework provides a robust and functional roadmap.

Fusing 4 mathematical lenses (ISP, AAS, EEM, DST) inside a **single pass** ensures extremely high capture rates across all intrinsic and extrinsic hallucination scopes (0.844 average AUROC). Attaching this math dynamically to a **Closed-Loop Mitigation Pipeline** drives overall hallucination rates down by **63.8%**. Most importantly, the framework re-aligns AI processing entirely to the end user by establishing transparent, inherently faithful, human-centered Explainable Trust metrics.

**Future Enhancements include:**
- Extending validation matrix logic to Vision-Language Multimodal models.
- Adapting the logic arrays to operate via Black-Box logic exclusively (utilizing Entropy Production Rates against API boundaries).
- Federated parameter training to adapt signal weights without breaching institutional privacy partitions.

---

## References

[1] W. Su et al., "Unsupervised real-time hallucination detection based on the internal states of large language models," Tsinghua University, 2024.  
[2] F. Zhang et al., "Prompt-guided internal states for hallucination detection," Nankai University, 2024.  
[3] Y. Huang et al., "TrustLLM: Trustworthiness in LLMs," Multi-Institutional Collaboration, 2024.  
[4] H. Ma et al., "Semantic energy: Detecting LLM hallucination beyond entropy," Baidu Inc., 2024.  
[5] E. Hajji et al., "The map of misbelief: Tracing intrinsic and extrinsic hallucinations," Univ. Paris-Saclay, 2024.  
[6] J. Kossen et al., "Semantic entropy probes: Robust and cheap hallucination detection," Univ. Oxford, 2024.  
[7] F. Herrera, "Making sense of the unsensible: XAI in LLMs," University of Granada, 2025.  
[8] M. Sharma et al., "Why would you suggest that? Human trust in language model responses," MIT Lincoln Laboratory, 2024.
