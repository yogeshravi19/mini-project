# TRUEGUARD Capstone: Comparative R Plots for LLM Hallucination Metrics
# This script generates ggplot2 visualizations comparing Baseline models vs TrueGuard

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# 1. Create a sample dataset based on extracted paper metrics
# Note: You can replace this with your actual CSV data once finalized.
metrics_data <- data.frame(
  Model = c("Llama-2 (Baseline)", "GPT-3.5 (Baseline)", "Mistral (Baseline)", 
            "Llama-2 + TrueGuard", "GPT-3.5 + TrueGuard", "Mistral + TrueGuard"),
  Type = c("Baseline", "Baseline", "Baseline", "TrueGuard", "TrueGuard", "TrueGuard"),
  F1_Score = c(65.2, 72.4, 68.9, 84.5, 89.1, 86.3),
  AUROC = c(0.68, 0.75, 0.71, 0.88, 0.92, 0.89),
  Hallucination_Rate_Percent = c(22.4, 15.6, 18.2, 5.1, 3.2, 4.8)
)

# Set the factor levels for rendering in plots
metrics_data$Model <- factor(metrics_data$Model, levels = metrics_data$Model)

# 2. Plot 1: F1 Score Comparison
f1_plot <- ggplot(metrics_data, aes(x = Model, y = F1_Score, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", alpha = 0.8) +
  scale_fill_manual(values = c("Baseline" = "#fc8d62", "TrueGuard" = "#8da0cb")) +
  theme_minimal(base_size = 14) +
  labs(title = "F1 Score Comparison: Baseline vs TRUEGUARD",
       x = "Language Model Configuration",
       y = "F1 Score (%)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold")) +
  geom_text(aes(label = F1_Score), vjust = -0.5, fontface = "bold")

# 3. Plot 2: Hallucination Rate Reduction
hr_plot <- ggplot(metrics_data, aes(x = Model, y = Hallucination_Rate_Percent, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", alpha = 0.8) +
  scale_fill_manual(values = c("Baseline" = "#e78ac3", "TrueGuard" = "#a6d854")) +
  theme_minimal(base_size = 14) +
  labs(title = "Hallucination Rate Reduction by TRUEGUARD",
       x = "Language Model Configuration",
       y = "Hallucination Rate (%)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold")) +
  geom_text(aes(label = paste0(Hallucination_Rate_Percent, "%")), vjust = -0.5, fontface = "bold")

# 4. Save the plots to the CAPSTONE directory
ggsave("e:/MINI PROJECT/CAPSTONE/F1_Score_Comparison.png", plot = f1_plot, width = 10, height = 6, dpi = 300)
ggsave("e:/MINI PROJECT/CAPSTONE/Hallucination_Rate_Comparison.png", plot = hr_plot, width = 10, height = 6, dpi = 300)

print("Plots generated successfully and saved to d:/MINI PROJECT/CAPSTONE/ folder.")
