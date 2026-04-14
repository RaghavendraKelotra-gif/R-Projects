# ============================================================
#   PROJECT 1: Vegas Gambling Analysis
#   Topic: Vectors in R
#   Course: Introduction to R
# ============================================================
# WHAT THIS PROJECT DOES:
#   We analyze a gambler's weekly results in two casinos
#   (Poker & Roulette) across 7 days using vectors.
#   We compare winnings, calculate totals, and visualize results.
# ============================================================


# ----------------------------------------------------------
# STEP 1: Create Vectors for Daily Winnings/Losses
# ----------------------------------------------------------

# Each value represents money won (+) or lost (-) per day
poker_vector <- c(140, -50, 20, -120, 240, -50, 80)
roulette_vector <- c(-24, -50, 100, -350, 10, -90, 45)

# Name each element with the day of the week
days_of_week <- c("Monday", "Tuesday", "Wednesday",
                  "Thursday", "Friday", "Saturday", "Sunday")

names(poker_vector)    <- days_of_week
names(roulette_vector) <- days_of_week

# Print the vectors to see them
cat("=== Poker Winnings Per Day ===\n")
print(poker_vector)

cat("\n=== Roulette Winnings Per Day ===\n")
print(roulette_vector)


# ----------------------------------------------------------
# STEP 2: Calculations with Vectors
# ----------------------------------------------------------

# Total winnings for each game (sum of all days)
total_poker    <- sum(poker_vector)
total_roulette <- sum(roulette_vector)

# Combined daily total (element-wise addition)
total_daily <- poker_vector + roulette_vector

# Overall total across both games
grand_total <- sum(total_daily)

cat("\n=== Summary ===\n")
cat("Total Poker Winnings:    $", total_poker, "\n")
cat("Total Roulette Winnings: $", total_roulette, "\n")
cat("Grand Total:             $", grand_total, "\n")

# Which days were profitable? (Logical comparison)
cat("\n=== Profitable Days (Combined) ===\n")
print(total_daily[total_daily > 0])


# ----------------------------------------------------------
# STEP 3: Visualizations (Colorful Charts)
# ----------------------------------------------------------

# Load ggplot2 for beautiful charts
library(ggplot2)

# --- Chart 1: Bar Chart — Daily Poker vs Roulette Winnings ---

# Prepare data frame for ggplot
days_factor <- factor(days_of_week, levels = days_of_week)  # keep day order

plot_data <- data.frame(
  Day    = rep(days_factor, 2),
  Game   = c(rep("Poker", 7), rep("Roulette", 7)),
  Amount = c(poker_vector, roulette_vector)
)

chart1 <- ggplot(plot_data, aes(x = Day, y = Amount, fill = Game)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  geom_hline(yintercept = 0, color = "black", linewidth = 0.8) +
  scale_fill_manual(values = c("Poker" = "#E74C3C", "Roulette" = "#3498DB")) +
  labs(
    title    = "🎰 Vegas Weekly Winnings: Poker vs Roulette",
    subtitle = "Daily performance across both casino games",
    x        = "Day of the Week",
    y        = "Amount Won / Lost ($)",
    fill     = "Game"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title    = element_text(face = "bold", size = 16, color = "#2C3E50"),
    plot.subtitle = element_text(color = "gray40"),
    axis.text.x   = element_text(angle = 30, hjust = 1),
    legend.position = "top",
    panel.grid.major.x = element_blank()
  )

print(chart1)
ggsave("Project1_Chart1_DailyWinnings.png", chart1, width = 9, height = 5, dpi = 150)
cat("\nChart 1 saved: Project1_Chart1_DailyWinnings.png\n")


# --- Chart 2: Line Chart — Running Total Over the Week ---

# Cumulative sum shows how the balance grows/shrinks each day
cumulative_poker    <- cumsum(poker_vector)
cumulative_roulette <- cumsum(roulette_vector)
cumulative_total    <- cumsum(total_daily)

cum_data <- data.frame(
  Day    = rep(days_factor, 3),
  Game   = c(rep("Poker", 7), rep("Roulette", 7), rep("Combined", 7)),
  Amount = c(cumulative_poker, cumulative_roulette, cumulative_total)
)

chart2 <- ggplot(cum_data, aes(x = Day, y = Amount, color = Game, group = Game)) +
  geom_line(linewidth = 1.5) +
  geom_point(size = 3.5) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  scale_color_manual(values = c(
    "Poker"    = "#E74C3C",
    "Roulette" = "#3498DB",
    "Combined" = "#27AE60"
  )) +
  labs(
    title    = "📈 Cumulative Winnings Throughout the Week",
    subtitle = "Running total for Poker, Roulette, and Combined",
    x        = "Day of the Week",
    y        = "Cumulative Amount ($)",
    color    = "Game"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title  = element_text(face = "bold", size = 16, color = "#2C3E50"),
    axis.text.x = element_text(angle = 30, hjust = 1),
    legend.position = "top"
  )

print(chart2)
ggsave("Project1_Chart2_CumulativeWinnings.png", chart2, width = 9, height = 5, dpi = 150)
cat("Chart 2 saved: Project1_Chart2_CumulativeWinnings.png\n")


# --- Chart 3: Summary Bar — Total per Game ---

summary_data <- data.frame(
  Game   = c("Poker", "Roulette", "Grand Total"),
  Amount = c(total_poker, total_roulette, grand_total)
)

chart3 <- ggplot(summary_data, aes(x = Game, y = Amount, fill = Amount > 0)) +
  geom_bar(stat = "identity", width = 0.5) +
  geom_text(aes(label = paste0("$", Amount)),
            vjust = ifelse(summary_data$Amount >= 0, -0.5, 1.5),
            size = 5, fontface = "bold") +
  scale_fill_manual(values = c("TRUE" = "#2ECC71", "FALSE" = "#E74C3C"),
                    labels = c("Loss", "Profit")) +
  labs(
    title = "💰 Total Winnings Summary",
    x = "Game", y = "Total Amount ($)", fill = "Result"
  ) +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold", size = 16, color = "#2C3E50"))

print(chart3)
ggsave("Project1_Chart3_Summary.png", chart3, width = 6, height = 5, dpi = 150)
cat("Chart 3 saved: Project1_Chart3_Summary.png\n")

cat("\n✅ Project 1 Complete!\n")
