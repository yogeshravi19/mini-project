# TRUEGUARD: A Multi-Signal Framework for Real-Time Hallucination Detection, Explanation, and Mitigation in Large Language Models

## Mini Project — Literature Review & Problem Statement

---

## Part A: Abstracts of Base Papers (1–20)

---

### Paper 1: Unsupervised Real-Time Hallucination Detection based on the Internal States of Large Language Models
**Authors:** Weihang Su, Changyue Wang, Qingyao Ai et al. (Tsinghua University)

**Abstract:** Hallucinations in LLMs refer to the generation of coherent yet factually inaccurate responses, undermining their real-world utility. Existing post-processing detection techniques are computationally expensive and disconnected from the LLM's inference process. This paper introduces MIND, an unsupervised training framework that leverages the internal states (hidden representations) of LLMs for real-time hallucination detection without requiring manual annotations. The authors also present HELM, a benchmark for evaluating hallucination detection across multiple LLMs, featuring diverse outputs alongside the internal states captured during inference. Experiments demonstrate that MIND outperforms existing state-of-the-art methods in hallucination detection tasks.

---

### Paper 2: Prompt-Guided Internal States for Hallucination Detection of Large Language Models
**Authors:** Fujie Zhang, Peiqi Yu, Biao Yi et al. (Nankai University)

**Abstract:** LLMs occasionally generate logically coherent but factually incorrect responses—a phenomenon known as hallucination. While data-driven supervised methods train hallucination detectors using LLM internal states, detectors trained on specific domains often fail to generalize across domains. This paper proposes PRISM, a novel framework that uses carefully designed prompts to guide structural changes in LLMs' internal states related to text truthfulness. By making truthfulness-related structures more salient and consistent across domains, PRISM enhances cross-domain hallucination detection performance. Integration with existing detection methods and experiments across multiple domains confirm significant improvements in generalization.

---

### Paper 3: TrustLLM: Trustworthiness in Large Language Models — A Principle and Benchmark
**Authors:** Yue Huang, Lichao Sun, Haoran Wang et al. (Multi-institution collaboration)

**Abstract:** As LLMs become deeply integrated into society, establishing principles for their trustworthiness becomes critical. TrustLLM proposes a unified framework for studying LLM trustworthiness across eight key dimensions: truthfulness, safety, fairness, robustness, privacy, machine ethics, transparency, and accountability. The paper introduces a comprehensive benchmark encompassing over 30 datasets evaluated across 16+ mainstream LLMs. The study reveals that trustworthiness and functional capability are positively correlated, proprietary models generally outperform open-source models in trustworthiness, and excessive safety measures can compromise model utility. TrustLLM provides both a principled taxonomy and a practical evaluation toolkit for the research community.

---

### Paper 4: Semantic Energy: Detecting LLM Hallucination Beyond Entropy
**Authors:** Huan Ma, Jiadong Pan, Jing Liu et al. (Tianjin University, Baidu Inc.)

**Abstract:** LLMs are prone to hallucinations that produce fluent yet incorrect responses. Uncertainty estimation is a key approach for detecting hallucinations. While semantic entropy estimates uncertainty through semantic diversity across multiple sampled responses, it relies on post-softmax probabilities and fails to capture the model's inherent uncertainty. This paper introduces Semantic Energy, a novel uncertainty estimation framework that operates directly on penultimate-layer logits. By combining semantic clustering with a Boltzmann-inspired energy distribution, Semantic Energy captures uncertainty in cases where semantic entropy fails. Experiments across multiple benchmarks demonstrate consistent improvements over existing methods.

---

### Paper 5: Detecting Hallucination in Large Language Models Through Deep Internal Representation Analysis
**Authors:** Luan Zhang, Dandan Song, Zhijing Wu et al. (Beijing Institute of Technology)

**Abstract:** LLMs are prone to hallucinating non-factual responses, undermining reliability. Current detection methods suffer from external resource demands, time overhead, and insufficient modeling of internal dynamics. This paper proposes MHAD, an internal-representation-based hallucination detection method that uses linear probing to identify hallucination-aware neurons and layers within LLMs. The selected neurons exhibit significant hallucination awareness at initial and final generation steps. By concatenating outputs from selected neurons at these critical steps, a hallucination awareness vector is formed, enabling precise detection. Experiments show MHAD achieves superior performance compared to existing baselines.

---

### Paper 6: Entropy Spike Detection and Self-Confidence Calibration for Hallucination Mitigation
**Authors:** (Extended Abstract)

**Abstract:** LLMs frequently generate hallucinations during multi-step reasoning, yet most mitigation methods focus only on final answer correctness, ignoring mid-reasoning hallucination signals. This paper integrates two complementary uncertainty signals: entropy spike detection and self-confidence calibration. Entropy spikes are identified by computing token-level entropy during generation and applying z-score normalization to detect abrupt deviations that correspond to unstable or hallucinated reasoning steps. Self-confidence calibration encourages the model to introspectively assess its own confidence. The reward function penalizes unjustified certainty and significant entropy spikes, promoting faithful and stable reasoning trajectories through fine-grained reward shaping via reinforcement learning.

---

### Paper 7: Uncertainty Quantification for Hallucination Detection in Large Language Models: Foundations, Methodology, and Future Directions
**Authors:** Sungmin Kang, Yavuz Faruk Bakman et al. (University of Southern California)

**Abstract:** The rapid advancement of LLMs has enabled breakthroughs in question answering, machine translation, and text summarization, yet deployment in real-world applications raises concerns over reliability due to hallucinations. Uncertainty quantification (UQ) has emerged as a central approach to address this issue. This survey introduces the foundations of UQ—from formal definitions to the epistemic vs. aleatoric distinction—and examines how these concepts have been adapted for LLMs. The paper reviews UQ's role in hallucination detection, covering confidence-based, sampling-based, and ensemble-based methods, and identifies open challenges including computational efficiency, domain transfer, and calibration quality.

---

### Paper 8: Making Sense of the Unsensible: Reflection, Survey, and Challenges for XAI in Large Language Models Toward Human-Centered AI
**Authors:** Francisco Herrera (University of Granada, ADIA Lab)

**Abstract:** As LLMs become embedded in sensitive domains such as healthcare, law, and education, the need for transparent, interpretable, and accountable AI is paramount. This paper provides a comprehensive survey of Explainable AI (XAI) for LLMs, organized around four core dimensions: faithfulness (do explanations reflect actual model reasoning?), truthfulness (are explanations factually correct?), plausibility (do explanations seem reasonable to humans?), and contrastivity (can explanations show why one output was preferred over alternatives?). The survey explores how XAI supports epistemic clarity, regulatory compliance, and user-specific intelligibility, and addresses challenges in balancing these dimensions in real-world deployment.

---

### Paper 9: The Map of Misbelief: Tracing Intrinsic and Extrinsic Hallucinations Through Attention Patterns
**Authors:** Elyes Hajji, Aymen Bouguerra, Fabio Arnez (Université Paris-Saclay, CEA-List)

**Abstract:** LLMs deployed in safety-critical domains remain susceptible to hallucinations. Prior confidence-based detection methods rely on computationally expensive sampling and often disregard the distinction between hallucination types. This paper introduces a principled evaluation framework that differentiates between extrinsic hallucinations (fabricated information not in the source) and intrinsic hallucinations (contradictions with the source). The authors leverage attention-based uncertainty quantification with novel attention aggregation strategies. Key findings reveal that sampling-based methods like Semantic Entropy are effective for extrinsic hallucinations but fail on intrinsic ones, while attention-based aggregation over input tokens is better suited for intrinsic hallucinations.

---

### Paper 10: On A Scale From 1 to 5: Quantifying Hallucination in Faithfulness Evaluation
**Authors:** Xiaonan Jing, Srinivas Billa, Danny Godbout (Expedia Group)

**Abstract:** In real-world NLG applications, unfaithful content causes poor data quality and erodes user trust, making automated faithfulness checking essential. This paper investigates automated faithfulness evaluation in guided NLG by developing a rubric template and using LLMs to score generation on quantifiable scales. The authors compare popular LLMs and NLI models in scoring quality and sensitivity, and develop methods for generating synthetic unfaithful data alongside heuristics to quantify hallucination percentages. Results on 4 travel-domain industry datasets show that GPT-4 provides accurate faithfulness judgments, and fine-tuning NLI models on synthetic data improves detection performance.

---

### Paper 11: Efficient Hallucination Detection for LLMs Using Uncertainty-Aware Attention Heads
**Authors:** Anonymous (Under review at ICLR 2026)

**Abstract:** LLMs produce text with remarkable fluency but remain prone to factual hallucinations. Existing uncertainty quantification approaches are computationally intensive or require supervision. This paper proposes RAUQ (Recurrent Attention-based Uncertainty Quantification), an unsupervised, efficient framework for hallucination detection. RAUQ exploits a key observation: when incorrect information is generated, certain "uncertainty-aware" attention heads reduce their focus on preceding tokens. The method automatically detects these heads and combines their activation patterns with token-level confidence measures in a recurrent scheme, producing a sequence-level uncertainty estimate in a single forward pass. Experiments across 12 tasks and 4 LLMs demonstrate competitive or superior performance.

---

### Paper 12: LLM-Check: Investigating Detection of Hallucinations in Large Language Models
**Authors:** Gaurang Sriramanan, Siddhant Bharti et al. (University of Maryland)

**Abstract:** LLMs are prone to producing hallucinations—outputs that are fabricated yet appear plausible. Prior detection approaches rely on consistency checks or retrieval-based methods that assume access to multiple responses or large databases, making them computationally expensive. This paper conducts a comprehensive investigation into hallucination detection within a single response in both white-box and black-box settings by analyzing internal hidden states, attention maps, and output prediction probabilities of an auxiliary LLM. Additionally, the paper studies detection in Retrieval-Augmented Generation settings. The proposed methods achieve speedups of up to 45× and 450× over baselines while improving detection accuracy.

---

### Paper 13: HALLUSHIFT: Measuring Distribution Shifts towards Hallucination Detection in LLMs
**Authors:** Sharanya Dasgupta, Sujoy Nath, Arkaprabha Basu et al.

**Abstract:** LLMs often suffer from hallucinations, generating incorrect information while maintaining coherent responses. This paper hypothesizes that hallucinations stem from internal dynamics of LLMs—during response generation, models deviate from factual accuracy in subtle parts, gradually shifting toward misinformation. This phenomenon resembles human cognition, where individuals may hallucinate while maintaining logical coherence. The authors introduce HALLUSHIFT, an approach that analyzes distribution shifts in the internal state space and token probabilities of LLM-generated responses. HALLUSHIFT achieves superior performance compared to existing baselines across various benchmark datasets.

---

### Paper 14: Semantic Entropy Probes: Robust and Cheap Hallucination Detection in LLMs
**Authors:** Jannik Kossen, Jiatong Han, Muhammed Razzak et al. (University of Oxford)

**Abstract:** Hallucinations present a major challenge to practical LLM adoption. Semantic entropy (SE) can detect hallucinations by estimating uncertainty in semantic meaning across multiple generations, but incurs a 5-to-10-fold computation cost. This paper proposes Semantic Entropy Probes (SEPs), which directly approximate SE from the hidden states of a single generation. SEPs are simple to train and eliminate the need for multiple sampling at test time, reducing uncertainty quantification overhead to near zero. Results across models and tasks show that SEPs retain high detection performance and generalize better to out-of-distribution data than previous probing methods. Ablation studies reveal insights into which token positions and model layers best capture semantic entropy.

---

### Paper 15: Mitigating LLM Hallucination via Behaviorally Calibrated Reinforcement Learning
**Authors:** Jiayun Wu, Jiashuo Liu et al. (ByteDance Seed, Carnegie Mellon University)

**Abstract:** Hallucination in LLMs is not merely a stochastic error but a predictable consequence of training objectives that prioritize mimicking data distributions over epistemic honesty. Standard RLVR paradigms with binary reward signals incentivize models to be "good test-takers" rather than "honest communicators." This paper presents behavioral calibration, which incentivizes models to abstain when uncertain by optimizing strictly proper scoring rules for calibrated correctness probabilities. Empirical analysis using Qwen3-4B shows that behaviorally calibrated RL allows smaller models to surpass frontier models in uncertainty quantification. The approach demonstrates that calibration is a transferable meta-skill decoupled from raw predictive accuracy.

---

### Paper 16: HALLUSHIFT++: Bridging Language and Vision through Internal Representation Shifts for Hierarchical Hallucinations in MLLMs
**Authors:** Sujoy Nath, Arkaprabha Basu, Sharanya Dasgupta, Swagatam Das

**Abstract:** Multimodal Large Language Models (MLLMs) demonstrate remarkable vision-language capabilities but suffer from hallucinations—generating descriptions factually inconsistent with visual content. Current assessment methodologies depend on external LLM evaluators, which are themselves susceptible to hallucinations. This paper proposes HALLUSHIFT++, which hypothesizes that hallucination manifests as measurable irregularities within internal layer dynamics of MLLMs, extending beyond simple distributional shifts to layer-wise analysis. By incorporating these modifications, HALLUSHIFT++ broadens hallucination detection from text-only LLMs to multimodal scenarios, providing an evaluation method free from external LLM dependency.

---

### Paper 17: Learned Hallucination Detection in Black-Box LLMs using Token-level Entropy Production Rate
**Authors:** Charles Moslonka, Hicham Randrianarivo et al. (Artefact Research Center, CentraleSupélec)

**Abstract:** Hallucinations in LLM outputs for Question Answering can critically undermine real-world reliability. This paper introduces a methodology for robust, one-shot hallucination detection designed for black-box LLM APIs that expose only a few top candidate log-probabilities per token. The approach derives an Entropy Production Rate (EPR) from readily available log-probabilities during non-greedy decoding, later augmented with supervised learning. The learned model leverages entropic contributions of accessible top-ranked tokens within a single generated sequence, without requiring multiple re-runs. Evaluation across diverse QA datasets and multiple LLMs shows significant improvements in token-level hallucination detection.

---

### Paper 18: Large Language Models Hallucination: A Comprehensive Survey
**Authors:** Aisha Alansari, Hamzah Luqman (KFUPM)

**Abstract:** LLMs have transformed NLP but frequently produce hallucinations—fluent, syntactically correct content that is factually inaccurate or unsupported. This comprehensive survey reviews hallucination research across the entire LLM lifecycle. The paper presents a taxonomy of hallucination types and root causes spanning data collection, architecture design, and inference. It examines hallucinations in key NLG tasks and introduces structured taxonomies for both detection approaches and mitigation strategies. The survey analyzes strengths and limitations of current methods, reviews evaluation benchmarks and metrics, and identifies key open challenges and promising future directions for the field.

---

### Paper 19: Why Would You Suggest That? Human Trust in Language Model Responses
**Authors:** Manasi Sharma, Ho Chit Siu, Rohan Paleja, Jaime D. Peña (MIT Lincoln Laboratory)

**Abstract:** The emergence of LLMs has revealed a growing need for human-AI collaboration, where trust and reliance are paramount. Through human studies on the News Headline Generation task from the LaMP benchmark, this paper analyzes how the framing and presence of explanations affect user trust and model performance. Key findings show that adding explanations to justify reasoning significantly increases user trust when users compare multiple responses. However, these trust gains disappear when responses are shown in isolation—users trust all responses, including deceptive ones, equally when shown independently. The paper highlights the importance of explanation positioning, faithfulness, and the critical distinction between comparative and independent evaluation contexts.

---

### Paper 20: ExpandR: Teaching Dense Retrievers Beyond Queries with LLM Guidance
**Authors:** Sijia Yao, Pengcheng Huang, Zhenghao Liu et al. (Northeastern University, Tsinghua University)

**Abstract:** LLMs have demonstrated significant potential in enhancing dense retrieval through query augmentation. However, most existing methods treat the LLM and retriever as separate modules, overlooking alignment between generation and ranking objectives. This paper proposes ExpandR, a unified LLM-augmented dense retrieval framework that jointly optimizes both the LLM and the retriever. ExpandR employs the LLM to generate semantically rich query expansions for retriever training, while simultaneously training the LLM using Direct Preference Optimization (DPO) with a reward function balancing retrieval effectiveness and generation consistency. This joint optimization enables mutual adaptation, achieving over 5% improvement in retrieval performance on multiple benchmarks.

---

## Part B: Unified Problem Statement

---

### Problem Statement

> **Title:** *TRUEGUARD: A Unified Multi-Signal Framework for Real-Time Hallucination Detection, Explainability, and Mitigation in Large Language Models*

#### Background

Large Language Models (LLMs) have revolutionized natural language processing, demonstrating remarkable capabilities across question answering, summarization, translation, reasoning, and creative generation tasks. However, their deployment in critical real-world applications—healthcare, law, education, and finance—is fundamentally impeded by the persistent phenomenon of **hallucination**: the generation of fluent, syntactically correct, and plausible-sounding outputs that are factually inaccurate, fabricated, or unsupported by evidence.

Recent research has made significant progress in addressing hallucination through several **independent** lines of investigation:

- **Internal state analysis** has revealed that hallucination leaves detectable footprints in a model's hidden representations (Papers 1, 2, 5, 13, 14, 16), with specific neurons and layers exhibiting heightened hallucination awareness.
- **Uncertainty quantification** via entropy-based methods (Papers 4, 7, 17), attention pattern analysis (Papers 9, 11), and distribution shift tracking (Papers 13, 16) has demonstrated that model uncertainty strongly correlates with hallucination risk.
- **Behavioral calibration** through reinforcement learning (Papers 6, 15) can train models to abstain when uncertain, aligning model confidence with actual accuracy.
- **Retrieval augmentation** (Paper 20) provides a pathway to ground LLM outputs in factual evidence, reducing hallucination at source.
- **Explainability** research (Paper 8) has established dimensions for transparent AI—faithfulness, truthfulness, plausibility, and contrastivity—while human trust studies (Paper 19) reveal that explanation quality directly impacts user trust.
- **Benchmarking** efforts (Papers 3, 10, 12) have provided evaluation frameworks spanning trustworthiness, faithfulness scoring, and multi-setting detection.

#### The Core Problem

Despite this rich body of individual contributions, a critical gap persists: **no existing work unifies these complementary signals into a single, cohesive framework that can simultaneously detect, explain, and mitigate hallucinations in real time.** Current approaches suffer from the following limitations:

1. **Signal Isolation**: Detection methods rely on only one or two signals (e.g., entropy alone, or internal states alone), missing complementary information that other signals provide. Papers 9 and 11 show that attention-based methods excel at detecting intrinsic hallucinations while entropy-based methods excel at extrinsic ones—yet no system leverages both.

2. **Computational Overhead**: Many effective methods (e.g., semantic entropy) require multiple sampling passes per query (5–10× overhead), making them impractical for real-time deployment (Papers 4, 14). Single-pass methods exist but sacrifice detection quality.

3. **Detection–Mitigation Disconnect**: Hallucination detection and mitigation operate as separate, sequential pipelines. Detection flags problems post-hoc, with no closed-loop mechanism to trigger corrective actions (retrieval augmentation, abstention) in real time.

4. **Explainability Deficit**: Detection systems produce binary hallucination labels or scalar confidence scores but offer no human-interpretable explanations for *why* a specific claim is flagged as unreliable—a critical requirement for user trust (Papers 8, 19) and regulatory compliance.

5. **Trust Calibration Gap**: Even when explanations are provided, their effectiveness depends heavily on presentation context (Paper 19). No existing system calibrates its trust indicators to align with actual human trust dynamics.

#### Proposed Solution

We propose **TRUEGUARD** (Trustworthy, Unified, Real-time, Explainable Guard), a novel framework that addresses these limitations by:

1. **Multi-Signal Fusion**: Combining four complementary detection signals—internal state probes, attention anomaly detection, entropy/energy monitoring, and distribution shift tracking—through a learned fusion mechanism that dynamically weights signals based on query type and context.

2. **Single-Pass Efficiency**: Operating entirely within a single forward pass by extracting all signals from the model's existing computation (hidden states, attention maps, logits), achieving real-time detection without additional sampling overhead.

3. **Closed-Loop Mitigation**: Creating a detection-to-action pipeline where high hallucination risk triggers retrieval-augmented grounding, and persistent uncertainty triggers calibrated abstention, enabling the model to self-correct or honestly communicate its limitations.

4. **Human-Centered Explainability**: Generating token-level confidence annotations and contrastive explanations derived directly from detection signals, providing users with interpretable justifications for trust scores rather than opaque binary labels.

#### Objectives

1. To develop and evaluate a multi-signal hallucination detection system that fuses internal state probes, attention-based anomaly detection, and entropy monitoring within a single forward pass.
2. To design a real-time explainability module that converts detection signals into human-interpretable trust indicators with token-level granularity.
3. To implement a closed-loop mitigation pipeline integrating retrieval-augmented self-correction and calibrated abstention mechanisms.
4. To benchmark the proposed framework against state-of-the-art baselines across standard hallucination detection datasets (TruthfulQA, HaluEval, HELM) on multiple open-source LLMs.

#### Expected Contributions

- A **unified multi-signal hallucination detection architecture** that outperforms individual signal methods by leveraging complementary uncertainty information.
- A **real-time explainability engine** bridging the gap between technical detection and human trust, aligning with XAI principles of faithfulness, plausibility, and contrastivity.
- A **closed-loop detection-mitigation pipeline** that reduces hallucination rates through active self-correction rather than passive post-hoc flagging.
- **Comprehensive empirical evaluation** demonstrating improvements in detection accuracy, computational efficiency, explanation quality, and downstream task reliability.

---

### References (Base Papers)

| # | Title | Key Focus |
|---|-------|-----------|
| 1 | Unsupervised Real-Time Hallucination Detection (MIND) | Internal states, real-time detection |
| 2 | Prompt-Guided Internal States (PRISM) | Cross-domain generalization |
| 3 | TrustLLM: Trustworthiness Benchmark | Multi-dimensional trust evaluation |
| 4 | Semantic Energy | Logit-space energy-based UQ |
| 5 | Deep Internal Representation Analysis (MHAD) | Neuron/layer selection for detection |
| 6 | Entropy Spike + Self-Confidence Calibration | RL-based reward shaping |
| 7 | UQ for Hallucination Detection (Survey) | Foundations of uncertainty in LLMs |
| 8 | XAI in LLMs (Survey) | Explainability dimensions |
| 9 | Map of Misbelief | Attention-based intrinsic vs extrinsic detection |
| 10 | Quantifying Hallucination in Faithfulness | LLM-as-judge evaluation |
| 11 | RAUQ: Uncertainty-Aware Attention Heads | Efficient single-pass detection |
| 12 | LLM-Check | White-box & black-box detection |
| 13 | HALLUSHIFT | Distribution shift detection |
| 14 | Semantic Entropy Probes (SEPs) | Cheap SE approximation |
| 15 | Behaviorally Calibrated RL | Abstention & calibration |
| 16 | HALLUSHIFT++ | Multimodal hallucination detection |
| 17 | Entropy Production Rate | Black-box token-level detection |
| 18 | LLM Hallucination (Comprehensive Survey) | End-to-end taxonomy |
| 19 | Human Trust in LLM Responses | Explanation framing & trust |
| 20 | ExpandR: LLM-Augmented Retrieval | Joint LLM-retriever optimization |
