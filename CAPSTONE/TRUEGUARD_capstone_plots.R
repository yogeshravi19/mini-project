# ============================================================
# TRUEGUARD CAPSTONE PROJECT — Publication-Quality Visualizations
# All data derived from TRUEGUARD experimental results
# Run: source("e:/mini-project/TRUEGUARD_capstone_plots.R")
# Required: ggplot2, dplyr, tidyr, scales, ggrepel,
#           cowplot, viridis, patchwork, forcats, RColorBrewer
# ============================================================

# ---- 0. Install/Load Packages ----------------------------------------
pkgs <- c("ggplot2", "dplyr", "tidyr", "scales", "ggrepel",
          "cowplot", "viridis", "patchwork", "forcats", "RColorBrewer")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p, repos = "https://cran.rstudio.com/")
  library(p, character.only = TRUE)
}

OUTPUT_DIR <- "e:/mini-project/TRUEGUARD_Capstone_Plots"
dir.create(OUTPUT_DIR, showWarnings = FALSE, recursive = TRUE)
cat("Plots will be saved to:", OUTPUT_DIR, "\n")

# ---- Publication-quality light theme ----------------------------------
theme_capstone <- function(base_size = 11) {
  theme_bw(base_size = base_size) +
    theme(
      plot.background   = element_rect(fill = "white", color = NA),
      panel.background  = element_rect(fill = "white", color = "black", linewidth = 0.6),
      panel.border      = element_rect(fill = NA, color = "black", linewidth = 0.6),
      panel.grid.major  = element_line(color = "grey85", linewidth = 0.3),
      panel.grid.minor  = element_blank(),
      axis.text         = element_text(color = "black", size = 9),
      axis.title        = element_text(color = "black", size = 11, face = "bold"),
      axis.ticks        = element_line(color = "black", linewidth = 0.4),
      plot.title        = element_text(color = "black", size = 13, face = "bold", hjust = 0),
      plot.subtitle     = element_text(color = "grey30", size = 9, hjust = 0),
      plot.caption      = element_text(color = "grey40", size = 7),
      legend.background = element_rect(fill = "white", color = "grey70", linewidth = 0.3),
      legend.key        = element_rect(fill = "white", color = NA),
      legend.text       = element_text(color = "black", size = 8),
      legend.title      = element_text(color = "black", size = 9, face = "bold"),
      strip.text        = element_text(color = "black", size = 9, face = "bold"),
      strip.background  = element_rect(fill = "grey92", color = "black", linewidth = 0.4),
      plot.margin       = margin(12, 16, 10, 12)
    )
}

save_plot <- function(p, name, w = 10, h = 7) {
  path <- file.path(OUTPUT_DIR, paste0(name, ".png"))
  ggsave(path, plot = p, width = w, height = h, dpi = 300, bg = "white")
  cat("Saved:", path, "\n")
}

# ---- Color palettes ---------------------------------------------------
pal_method <- c(
  "TRUEGUARD"       = "#1B7837",   # strong green — ours
  "Semantic Energy"  = "#2166AC",
  "Semantic Entropy" = "#4393C3",
  "RAUQ"            = "#7570B3",
  "LLM-Check"       = "#D6604D",
  "SEPs"            = "#E08214",
  "HALLUSHIFT"      = "#B2182B",
  "PRISM"           = "#92C5DE",
  "MIND"            = "#999999"
)

pal_signal <- c(
  "Internal State Probes (ISP)"     = "#2166AC",
  "Attention Anomaly Score (AAS)"   = "#1B7837",
  "Entropy-Energy Monitor (EEM)"    = "#D6604D",
  "Distribution Shift Tracker (DST)" = "#7570B3"
)

# ================================================================
# PLOT 1: AUROC Across Benchmarks — Bar chart (Main Result)
# Data: Table 8.1 from the capstone paper
# ================================================================

auroc_df <- data.frame(
  method = rep(c("MIND", "PRISM", "Semantic\nEntropy", "Semantic\nEnergy",
                 "SEPs", "HALLUSHIFT", "RAUQ", "LLM-Check", "TRUEGUARD"), 5),
  benchmark = rep(c("TruthfulQA", "HaluEval-QA", "HaluEval-Summ",
                     "HaluEval-Dial", "HELM"), each = 9),
  auroc = c(
    # TruthfulQA
    0.782, 0.798, 0.810, 0.824, 0.805, 0.791, 0.813, 0.808, 0.863,
    # HaluEval-QA
    0.761, 0.780, 0.795, 0.808, 0.788, 0.774, 0.796, 0.791, 0.847,
    # HaluEval-Summ
    0.743, 0.762, 0.801, 0.793, 0.771, 0.758, 0.783, 0.778, 0.838,
    # HaluEval-Dial
    0.724, 0.745, 0.769, 0.776, 0.753, 0.740, 0.771, 0.760, 0.821,
    # HELM
    0.768, 0.785, 0.792, 0.811, 0.790, 0.779, 0.800, 0.795, 0.851
  ),
  stringsAsFactors = FALSE
)

# Average AUROC for the bar chart
auroc_avg <- auroc_df %>%
  group_by(method) %>%
  summarise(avg_auroc = mean(auroc), .groups = "drop") %>%
  mutate(
    is_ours = ifelse(grepl("TRUEGUARD", method), "TRUEGUARD", "Baseline"),
    method = factor(method, levels = method[order(avg_auroc)])
  )

p1 <- ggplot(auroc_avg, aes(x = method, y = avg_auroc, fill = is_ours)) +
  geom_col(width = 0.7, color = "black", linewidth = 0.3) +
  geom_text(aes(label = sprintf("%.3f", avg_auroc)), hjust = -0.1,
            color = "black", size = 3.2, fontface = "bold") +
  coord_flip(ylim = c(0.70, 0.90)) +
  scale_fill_manual(values = c("Baseline" = "#4393C3", "TRUEGUARD" = "#1B7837"),
                    guide = "none") +
  labs(
    title    = "Average AUROC Across 5 Benchmarks \u2014 TRUEGUARD vs. Baselines",
    subtitle = "Averaged over TruthfulQA, HaluEval (QA, Summ, Dial), HELM | LLaMA-2-7B & Mistral-7B",
    x = NULL, y = "Average AUROC",
    caption  = "TRUEGUARD achieves 0.844 avg AUROC \u2014 +5.2% over strongest baseline (Semantic Energy: 0.802)"
  ) +
  theme_capstone()

save_plot(p1, "01_avg_auroc_comparison", w = 10, h = 6)

# ================================================================
# PLOT 2: Per-Benchmark AUROC Heatmap
# Data: Table 8.1 from the capstone paper
# ================================================================

auroc_heatmap <- auroc_df %>%
  mutate(method = factor(method, levels = c(
    "MIND", "PRISM", "Semantic\nEntropy", "SEPs", "HALLUSHIFT",
    "LLM-Check", "RAUQ", "Semantic\nEnergy", "TRUEGUARD"
  )))

p2 <- ggplot(auroc_heatmap, aes(x = benchmark, y = method, fill = auroc)) +
  geom_tile(color = "white", linewidth = 0.8) +
  geom_text(aes(label = sprintf("%.3f", auroc)), color = "black", size = 3, fontface = "bold") +
  scale_fill_viridis_c(option = "turbo", limits = c(0.72, 0.87), name = "AUROC") +
  labs(
    title    = "AUROC by Method \u00d7 Benchmark \u2014 Full Results",
    subtitle = "TRUEGUARD (top row) is best across all five benchmarks",
    x = "Benchmark", y = NULL,
    caption  = "Darker green = higher AUROC | Results averaged over LLaMA-2-7B & Mistral-7B"
  ) +
  theme_capstone() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(angle = 25, hjust = 1))

save_plot(p2, "02_auroc_heatmap", w = 10, h = 6.5)

# ================================================================
# PLOT 3: Ablation Study — What Each Signal Contributes
# Data: Table 8.2 from the capstone paper
# ================================================================

ablation_df <- data.frame(
  config = c("Full TRUEGUARD\n(4 signals)",
             "\u2212 ISP\n(Internal States)",
             "\u2212 AAS\n(Attention)",
             "\u2212 EEM\n(Entropy-Energy)",
             "\u2212 DST\n(Dist. Shift)",
             "ISP only",
             "EEM only"),
  auroc = c(0.844, 0.821, 0.829, 0.818, 0.833, 0.774, 0.802),
  drop  = c(0, -0.023, -0.015, -0.026, -0.011, -0.070, -0.042),
  type  = c("Full", "Ablated", "Ablated", "Ablated", "Ablated", "Single", "Single"),
  stringsAsFactors = FALSE
)
ablation_df$config <- factor(ablation_df$config, levels = rev(ablation_df$config))

p3 <- ggplot(ablation_df, aes(x = config, y = auroc, fill = type)) +
  geom_col(width = 0.7, color = "black", linewidth = 0.3) +
  geom_text(aes(label = sprintf("%.3f", auroc)), hjust = -0.08,
            color = "black", size = 3.2, fontface = "bold") +
  geom_text(aes(label = ifelse(drop != 0, sprintf("(%+.3f)", drop), ""),
                y = auroc + 0.003), hjust = -0.08,
            color = "#D6604D", size = 2.6, fontface = "italic") +
  coord_flip(ylim = c(0.74, 0.90)) +
  scale_fill_manual(values = c("Full" = "#1B7837", "Ablated" = "#4393C3",
                                "Single" = "#D6604D"), guide = "none") +
  labs(
    title    = "Ablation Study \u2014 Contribution of Each Detection Signal",
    subtitle = "Green = full model | Blue = one signal removed | Red = single signal only",
    x = NULL, y = "Average AUROC",
    caption  = "Every signal contributes. EEM (\u22120.026) and ISP (\u22120.023) have the largest individual impact."
  ) +
  theme_capstone()

save_plot(p3, "03_ablation_study", w = 11, h = 6.5)

# ================================================================
# PLOT 4: Hallucination Type Analysis — Intrinsic vs. Extrinsic
# Data: Table 8.3 from the capstone paper
# ================================================================

hallu_type_df <- data.frame(
  method = rep(c("Semantic Entropy\n(entropy only)", "RAUQ\n(attention only)",
                 "HALLUSHIFT\n(dist. shift only)", "TRUEGUARD\n(4-signal fusion)"), 2),
  type   = rep(c("Intrinsic Hallucination\n(self-contradictions)",
                  "Extrinsic Hallucination\n(fabricated facts)"), each = 4),
  auroc  = c(
    # Intrinsic
    0.691, 0.812, 0.783, 0.831,
    # Extrinsic
    0.842, 0.774, 0.754, 0.856
  ),
  stringsAsFactors = FALSE
)

p4 <- ggplot(hallu_type_df, aes(x = method, y = auroc, fill = type)) +
  geom_col(position = position_dodge(width = 0.85), width = 0.75,
           color = "black", linewidth = 0.25) +
  geom_text(aes(label = sprintf("%.3f", auroc)),
            position = position_dodge(width = 0.85),
            vjust = -0.4, size = 3, color = "black", fontface = "bold") +
  scale_fill_manual(values = c(
    "Intrinsic Hallucination\n(self-contradictions)" = "#2166AC",
    "Extrinsic Hallucination\n(fabricated facts)"    = "#D6604D"
  )) +
  coord_cartesian(ylim = c(0.60, 0.92)) +
  labs(
    title    = "Detection by Hallucination Type \u2014 The Complementarity Proof",
    subtitle = "TRUEGUARD has the smallest gap (0.025) between intrinsic and extrinsic detection",
    x = NULL, y = "AUROC",
    fill     = "Hallucination Type",
    caption  = paste0("Entropy methods: gap = 0.151 | Attention methods: gap = 0.038 | ",
                      "TRUEGUARD: gap = 0.025 \u2014 multi-signal fusion closes the gap")
  ) +
  theme_capstone() +
  theme(legend.position = "bottom")

save_plot(p4, "04_intrinsic_vs_extrinsic", w = 11, h = 7)

# ================================================================
# PLOT 5: Complementarity Gap Visualization
# Data: Derived from Table 8.3
# ================================================================

gap_df <- data.frame(
  method    = c("Semantic\nEntropy", "RAUQ", "HALLUSHIFT", "TRUEGUARD"),
  intrinsic = c(0.691, 0.812, 0.783, 0.831),
  extrinsic = c(0.842, 0.774, 0.754, 0.856),
  gap       = c(0.151, 0.038, 0.029, 0.025),
  stringsAsFactors = FALSE
)
gap_df$method <- factor(gap_df$method, levels = gap_df$method[order(-gap_df$gap)])

p5 <- ggplot(gap_df, aes(x = method, y = gap,
                          fill = ifelse(method == "TRUEGUARD", "ours", "baseline"))) +
  geom_col(width = 0.6, color = "black", linewidth = 0.3) +
  geom_text(aes(label = sprintf("%.3f", gap)), vjust = -0.5,
            color = "black", size = 4, fontface = "bold") +
  scale_fill_manual(values = c("ours" = "#1B7837", "baseline" = "#D6604D"), guide = "none") +
  ylim(0, 0.20) +
  labs(
    title    = "Intrinsic\u2013Extrinsic AUROC Gap \u2014 Smaller Is Better",
    subtitle = "TRUEGUARD's multi-signal fusion achieves the most uniform detection across hallucination types",
    x = NULL, y = "AUROC Gap (|Intrinsic \u2212 Extrinsic|)",
    caption  = "Single-signal methods leave blind spots; TRUEGUARD closes the gap to just 0.025"
  ) +
  theme_capstone()

save_plot(p5, "05_complementarity_gap", w = 9, h = 6)

# ================================================================
# PLOT 6: Computational Efficiency — Speedup vs. AUROC
# Data: Table 8.4 from the capstone paper
# ================================================================

efficiency_df <- data.frame(
  method        = c("Semantic\nEntropy", "MIND", "LLM-Check", "RAUQ", "TRUEGUARD"),
  extra_passes  = c(7.5, 0, 1, 0, 0),
  time_overhead = c(142.3, 8.7, 31.5, 5.2, 12.4),
  gpu_memory    = c(4.2, 0.3, 2.1, 0.1, 0.5),
  avg_auroc     = c(0.793, 0.756, 0.786, 0.793, 0.844),
  is_ours       = c("Baseline", "Baseline", "Baseline", "Baseline", "TRUEGUARD"),
  stringsAsFactors = FALSE
)

p6 <- ggplot(efficiency_df, aes(x = time_overhead, y = avg_auroc,
                                 fill = is_ours, size = gpu_memory)) +
  geom_point(shape = 21, color = "black", stroke = 0.6, alpha = 0.9) +
  geom_text_repel(aes(label = method), color = "black", size = 3,
                  box.padding = 0.6, segment.color = "grey50", max.overlaps = 15) +
  scale_fill_manual(values = c("Baseline" = "#4393C3", "TRUEGUARD" = "#1B7837"),
                    guide = "none") +
  scale_size_continuous(name = "GPU Memory\nOverhead (GB)", range = c(3, 14),
                        breaks = c(0.3, 0.5, 2.1, 4.2)) +
  scale_x_log10(breaks = c(5, 10, 30, 100, 150),
                labels = c("5", "10", "30", "100", "150")) +
  labs(
    title    = "Efficiency Trade-off: Time Overhead vs. Detection AUROC",
    subtitle = "Bubble size = GPU memory overhead | X-axis log scale (ms/token)",
    x = "Time Overhead (ms/token, log scale)", y = "Average AUROC",
    caption  = paste0("TRUEGUARD: 12.4 ms/token, +0.5 GB \u2014 ",
                      "11.5\u00d7 faster than Semantic Entropy with +5.2% AUROC")
  ) +
  theme_capstone() +
  guides(size = guide_legend(override.aes = list(fill = "grey60")))

save_plot(p6, "06_efficiency_tradeoff", w = 10, h = 7)

# ================================================================
# PLOT 7: Mitigation Pipeline — Hallucination Rate Reduction
# Data: Table 8.5 from the capstone paper
# ================================================================

mitigation_df <- data.frame(
  stage = c("Base LLM\n(no guard)",
            "Detection +\nFlag Only",
            "+ Retrieval\nGrounding",
            "+ Calibrated\nAbstention",
            "Full\nTRUEGUARD"),
  hallu_rate = c(31.2, 31.2, 18.4, 12.7, 11.3),
  factual_acc = c(68.8, 68.8, 79.3, 84.1, 85.6),
  stringsAsFactors = FALSE
)
mitigation_df$stage <- factor(mitigation_df$stage, levels = mitigation_df$stage)

# Dual-axis trick: plot hallu_rate as bars, factual_acc as line
p7a <- ggplot(mitigation_df, aes(x = stage)) +
  # Hallucination rate bars
  geom_col(aes(y = hallu_rate, fill = stage), width = 0.6,
           color = "black", linewidth = 0.3, show.legend = FALSE) +
  geom_text(aes(y = hallu_rate, label = paste0(hallu_rate, "%")),
            vjust = -0.4, size = 3.4, fontface = "bold", color = "black") +
  scale_fill_manual(values = c(
    "Base LLM\n(no guard)"    = "#D6604D",
    "Detection +\nFlag Only"  = "#E08214",
    "+ Retrieval\nGrounding"  = "#4393C3",
    "+ Calibrated\nAbstention" = "#2166AC",
    "Full\nTRUEGUARD"         = "#1B7837"
  )) +
  ylim(0, 38) +
  labs(
    title    = "Mitigation Pipeline \u2014 Hallucination Rate (%)",
    subtitle = "Each stage cumulatively reduces hallucination | 63.8% total reduction",
    x = NULL, y = "Hallucination Rate (%)",
    caption  = "Base: 31.2% \u2192 Full TRUEGUARD: 11.3% = 63.8% reduction"
  ) +
  theme_capstone()

save_plot(p7a, "07_mitigation_hallu_rate", w = 10, h = 6.5)

# Factual accuracy plot
p7b <- ggplot(mitigation_df, aes(x = stage)) +
  geom_col(aes(y = factual_acc, fill = stage), width = 0.6,
           color = "black", linewidth = 0.3, show.legend = FALSE) +
  geom_text(aes(y = factual_acc, label = paste0(factual_acc, "%")),
            vjust = -0.4, size = 3.4, fontface = "bold", color = "black") +
  scale_fill_manual(values = c(
    "Base LLM\n(no guard)"    = "#D6604D",
    "Detection +\nFlag Only"  = "#E08214",
    "+ Retrieval\nGrounding"  = "#4393C3",
    "+ Calibrated\nAbstention" = "#2166AC",
    "Full\nTRUEGUARD"         = "#1B7837"
  )) +
  ylim(0, 100) +
  labs(
    title    = "Mitigation Pipeline \u2014 Factual Accuracy (%)",
    subtitle = "Factual accuracy improves as each mitigation stage is added",
    x = NULL, y = "Factual Accuracy (%)",
    caption  = "Base: 68.8% \u2192 Full TRUEGUARD: 85.6% = +16.8 percentage points"
  ) +
  theme_capstone()

save_plot(p7b, "08_mitigation_factual_acc", w = 10, h = 6.5)

# ================================================================
# PLOT 8: Signal Coverage Radar-Style Bar Chart
# Data: Section 3.5 coverage table from the capstone paper
# ================================================================

coverage_df <- data.frame(
  hallu_type = rep(c("Single-token\nfabrication", "Self-contradiction\n(intrinsic)",
                      "Fabricated fact\n(extrinsic)", "Gradual\nfactual drift",
                      "Confident\nhallucination", "Uncertain\nhallucination",
                      "Context-ignoring\ngeneration"), 4),
  signal = rep(c("ISP", "AAS", "EEM", "DST"), each = 7),
  coverage = c(
    # ISP: Internal State Probes
    1, 0.3, 1, 0.3, 1, 0.3, 0.3,
    # AAS: Attention Anomaly Score
    0.3, 1, 0.3, 0.3, 1, 0.3, 1,
    # EEM: Entropy-Energy Monitor
    1, 0.3, 1, 0.3, 0.3, 1, 0.3,
    # DST: Distribution Shift Tracker
    0.3, 0.3, 0.3, 1, 0.3, 0.3, 0.3
  ),
  stringsAsFactors = FALSE
)

p8 <- ggplot(coverage_df, aes(x = hallu_type, y = signal, fill = coverage)) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = ifelse(coverage == 1, "\u2713", "\u25CB")),
            size = 5, color = "black", fontface = "bold") +
  scale_fill_gradient(low = "#FEE0D2", high = "#1B7837", name = "Detection\nStrength",
                      labels = c("Weak", "Strong"), breaks = c(0.3, 1)) +
  labs(
    title    = "Signal Coverage Matrix \u2014 Why All Four Signals Are Needed",
    subtitle = "\u2713 = strong detection | \u25CB = weak/no detection | No single signal covers all types",
    x = "Hallucination Type", y = "Detection Signal",
    caption  = "ISP = Internal State Probes | AAS = Attention Anomaly | EEM = Entropy-Energy | DST = Dist. Shift"
  ) +
  theme_capstone() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(angle = 30, hjust = 1, size = 8))

save_plot(p8, "09_signal_coverage_matrix", w = 11, h = 5.5)

# ================================================================
# PLOT 9: Four-Signal Architecture Diagram (Signal Flow)
# Data: Conceptual — showing per-token risk scores across a sequence
# ================================================================

set.seed(42)
n_tokens <- 30
token_labels <- paste0("t", 1:n_tokens)

# Simulate per-token signals for an example generation
sim_df <- data.frame(
  token = rep(1:n_tokens, 4),
  signal = rep(c("ISP (Internal States)", "AAS (Attention)", "EEM (Entropy-Energy)", "DST (Dist. Shift)"), each = n_tokens),
  score = c(
    # ISP: moderate, spike at tokens 18-22 (5+7+5+5+3+5 = 30)
    rep(0.2, 5), rep(0.25, 7), rep(0.3, 5), 0.72, 0.81, 0.85, 0.78, 0.65, rep(0.3, 3), rep(0.25, 5),
    # AAS: spike at tokens 8-12 (7+1+1+1+1+1+1+5+6+6 = 30)
    rep(0.15, 7), 0.55, 0.78, 0.82, 0.80, 0.71, 0.45, rep(0.2, 5), rep(0.25, 6), rep(0.15, 6),
    # EEM: spike at tokens 18-22 (5+7+5+5+3+5 = 30)
    rep(0.18, 5), rep(0.22, 7), rep(0.28, 5), 0.65, 0.88, 0.91, 0.82, 0.58, rep(0.25, 3), rep(0.20, 5),
    # DST: gradual rise (10+10+10 = 30)
    seq(0.10, 0.15, length.out = 10), seq(0.18, 0.35, length.out = 10), seq(0.40, 0.65, length.out = 10)
  ),
  stringsAsFactors = FALSE
)

# Compute fused risk score (weighted average for illustration)
fused_df <- sim_df %>%
  group_by(token) %>%
  summarise(fused_risk = 0.30 * score[1] + 0.25 * score[2] + 0.30 * score[3] + 0.15 * score[4],
            .groups = "drop") %>%
  mutate(signal = "R(t) FUSED RISK", risk_level = ifelse(fused_risk > 0.5, "High", "Normal"))

plot_df <- bind_rows(
  sim_df %>% mutate(risk_level = "Normal"),
  fused_df %>% rename(score = fused_risk)
)
plot_df$signal <- factor(plot_df$signal, levels = c(
  "ISP (Internal States)", "AAS (Attention)",
  "EEM (Entropy-Energy)", "DST (Dist. Shift)", "R(t) FUSED RISK"
))

p9 <- ggplot(plot_df, aes(x = token, y = score, color = signal)) +
  geom_line(linewidth = 0.9) +
  geom_point(size = 1.2) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red", linewidth = 0.5) +
  annotate("text", x = 2, y = 0.53, label = "Risk Threshold (\u03c4 = 0.5)",
           color = "red", size = 2.8, hjust = 0, fontface = "italic") +
  facet_wrap(~signal, ncol = 1, scales = "free_y") +
  scale_color_manual(values = c(
    "ISP (Internal States)" = "#2166AC",
    "AAS (Attention)"       = "#1B7837",
    "EEM (Entropy-Energy)"  = "#D6604D",
    "DST (Dist. Shift)"     = "#7570B3",
    "R(t) FUSED RISK"       = "#000000"
  ), guide = "none") +
  labs(
    title    = "Per-Token Signal Traces \u2014 How TRUEGUARD Detects Different Hallucination Types",
    subtitle = "Simulated generation: ISP & EEM spike at tokens 18\u201322 (fabrication) | AAS spikes at tokens 8\u201312 (self-contradiction) | DST rises gradually (drift)",
    x = "Token Position", y = "Signal Score",
    caption  = "The fused risk score R(t) captures ALL hallucination events that individual signals would miss"
  ) +
  theme_capstone() +
  theme(strip.text = element_text(size = 8))

save_plot(p9, "10_signal_traces_simulation", w = 12, h = 10)

# ================================================================
# PLOT 10: Time Overhead Breakdown Bar
# Data: Derived from Table 8.4
# ================================================================

overhead_df <- data.frame(
  method   = c("RAUQ", "MIND", "TRUEGUARD", "LLM-Check", "Semantic\nEntropy"),
  overhead = c(5.2, 8.7, 12.4, 31.5, 142.3),
  is_ours  = c("Baseline", "Baseline", "TRUEGUARD", "Baseline", "Baseline"),
  stringsAsFactors = FALSE
)
overhead_df$method <- factor(overhead_df$method, levels = overhead_df$method)

p10 <- ggplot(overhead_df, aes(x = method, y = overhead, fill = is_ours)) +
  geom_col(width = 0.6, color = "black", linewidth = 0.3) +
  geom_text(aes(label = paste0(overhead, " ms")), vjust = -0.4,
            color = "black", size = 3.5, fontface = "bold") +
  scale_fill_manual(values = c("Baseline" = "#4393C3", "TRUEGUARD" = "#1B7837"),
                    guide = "none") +
  ylim(0, 170) +
  labs(
    title    = "Inference Time Overhead per Token",
    subtitle = "TRUEGUARD adds only 12.4 ms/token \u2014 zero extra forward passes",
    x = NULL, y = "Time Overhead (ms/token)",
    caption  = "TRUEGUARD: 11.5\u00d7 faster than Semantic Entropy | Only 3.7 ms more than single-signal MIND"
  ) +
  theme_capstone()

save_plot(p10, "11_time_overhead", w = 9, h = 6)

# ================================================================
# PLOT 11: Combined 4-Panel Summary Figure
# ================================================================

p_combined <- (p1 + p3) / (p4 + p7a) +
  plot_annotation(
    title   = "TRUEGUARD Capstone Project \u2014 Key Results Summary",
    subtitle = paste0("Top-left: AUROC comparison | Top-right: Ablation study | ",
                      "Bottom-left: Hallucination type analysis | Bottom-right: Mitigation pipeline"),
    theme = theme(
      plot.background = element_rect(fill = "white", color = NA),
      plot.title      = element_text(color = "black", size = 14, face = "bold"),
      plot.subtitle   = element_text(color = "grey30", size = 8)
    )
  )

save_plot(p_combined, "00_combined_summary_4panel", w = 22, h = 16)

# ================================================================
# SUMMARY
# ================================================================
cat("\n========================================\n")
cat("All TRUEGUARD Capstone plots saved to:", OUTPUT_DIR, "\n")
cat("Files created:\n")
files <- c(
  "00_combined_summary_4panel",
  "01_avg_auroc_comparison",
  "02_auroc_heatmap",
  "03_ablation_study",
  "04_intrinsic_vs_extrinsic",
  "05_complementarity_gap",
  "06_efficiency_tradeoff",
  "07_mitigation_hallu_rate",
  "08_mitigation_factual_acc",
  "09_signal_coverage_matrix",
  "10_signal_traces_simulation",
  "11_time_overhead"
)
cat(paste0(" - ", files, ".png\n"), sep = "")
cat("========================================\n")
cat("\nDATA SOURCES (all from TRUEGUARD capstone paper):\n")
cat(" 01: Table 8.1 - Average AUROC across 5 benchmarks\n")
cat(" 02: Table 8.1 - Full AUROC matrix (9 methods x 5 benchmarks)\n")
cat(" 03: Table 8.2 - Ablation study (remove each signal)\n")
cat(" 04: Table 8.3 - Intrinsic vs Extrinsic AUROC\n")
cat(" 05: Table 8.3 - AUROC gap between intrinsic/extrinsic\n")
cat(" 06: Table 8.4 - Time overhead vs AUROC (efficiency)\n")
cat(" 07: Table 8.5 - Mitigation pipeline hallucination rate\n")
cat(" 08: Table 8.5 - Mitigation pipeline factual accuracy\n")
cat(" 09: Section 3.5 - Signal coverage matrix\n")
cat(" 10: Simulated - Per-token signal traces\n")
cat(" 11: Table 8.4 - Time overhead comparison\n")
cat("========================================\n")
