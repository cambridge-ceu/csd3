#!/usr/bin/env Rscript

# Load required libraries
if (!require("tidyverse")) install.packages("tidyverse", repos = "https://cloud.r-project.org")
library(tidyverse)

# Input file (adjust as needed)
input_file <- "test.thetasWindow.gz.pestPG"

# Read the data
# Note: header is likely present but complex; we define column names manually:
col_names <- c("region_info", "chr", "WinCenter", 
               "tW", "tP", "tF", "tH", "tL",
               "Tajima", "FuF", "FuD", "FayH", "ZengE",
               "nSites")

df <- read.table(input_file, header = FALSE, comment.char = "#", stringsAsFactors = FALSE)
colnames(df) <- col_names

# Convert relevant columns to numeric
df <- df %>%
  mutate(across(c(WinCenter, tW, tP, Tajima), as.numeric)) %>%
  mutate(chr = as.factor(chr)) %>%
  arrange(chr, WinCenter)

# Plot 1: Pairwise Diversity (π) Across Windows
p1 <- ggplot(df, aes(x = WinCenter, y = tP, color = chr)) +
  geom_line(show.legend = FALSE) +
  facet_wrap(~ chr, scales = "free_x", ncol = 2) +
  labs(
    title = "Sliding-window Pairwise Diversity (θπ)",
    x = "Genomic Position (Window Center)",
    y = expression(theta[pi])
  ) +
  theme_minimal()

# Plot 2: Watterson's θ (tW)
p2 <- ggplot(df, aes(x = WinCenter, y = tW, color = chr)) +
  geom_line(show.legend = FALSE) +
  facet_wrap(~ chr, scales = "free_x", ncol = 2) +
  labs(
    title = "Sliding-window Watterson's θ",
    x = "Genomic Position",
    y = expression(theta[W])
  ) +
  theme_minimal()

# Plot 3: Tajima's D Across Windows
p3 <- ggplot(df, aes(x = WinCenter, y = Tajima, color = chr)) +
  geom_line(show.legend = FALSE) +
  facet_wrap(~ chr, scales = "free_x", ncol = 2) +
  labs(
    title = "Sliding-window Tajima's D",
    x = "Genomic Position",
    y = "Tajima's D"
  ) +
  theme_minimal()

# Save the plots
ggsave("theta_pi_sliding_window.png", p1, width = 10, height = 6)
ggsave("theta_w_sliding_window.png", p2, width = 10, height = 6)
ggsave("tajimasD_sliding_window.png", p3, width = 10, height = 6)

# Optional: Highlight extreme Tajima's D values
threshold <- 2
p4 <- ggplot(df, aes(x = WinCenter, y = Tajima)) +
  geom_point(aes(color = abs(Tajima) > threshold), alpha = 0.7) +
  scale_color_manual(values = c("grey50", "red"), labels = c("Normal", "Extreme")) +
  facet_wrap(~ chr, scales = "free_x", ncol = 2) +
  labs(
    title = paste("Tajima's D with |D| >", threshold),
    x = "Genomic Position",
    y = "Tajima's D",
    color = "Extreme"
  ) +
  theme_minimal()
ggsave("tajimasD_extremes.png", p4, width = 10, height = 6)

# Inform user
cat("Plots generated:\n",
    "- theta_pi_sliding_window.png\n",
    "- theta_w_sliding_window.png\n",
    "- tajimasD_sliding_window.png\n",
    "- tajimasD_extremes.png (optional highlighting)\n")
