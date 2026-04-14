# ============================================================
#   PROJECT 2: Star Wars Box Office Analysis
#   Topic: Matrices in R
#   Course: Introduction to R
# ============================================================
# WHAT THIS PROJECT DOES:
#   We build a matrix of box office earnings (US & non-US)
#   for 6 Star Wars films. We perform matrix operations like
#   row/column sums, comparisons, and create rich visualizations.
# ============================================================


# ----------------------------------------------------------
# STEP 1: Create the Box Office Matrix
# ----------------------------------------------------------

# Box office data in millions of dollars
# Columns: US Revenue, Non-US Revenue
# Rows: Each movie

# US earnings (millions $)
us_earnings <- c(461, 314, 379, 474, 572, 936)

# Non-US earnings (millions $)
non_us_earnings <- c(314, 247, 357, 552, 1056, 1132)

# Combine into a matrix: cbind = column-bind (side by side)
box_office <- matrix(
  c(us_earnings, non_us_earnings),
  nrow = 6,
  ncol = 2
)

# Name rows and columns
rownames(box_office) <- c(
  "A New Hope",
  "Empire Strikes Back",
  "Return of the Jedi",
  "The Phantom Menace",
  "Attack of the Clones",
  "Revenge of the Sith"
)
colnames(box_office) <- c("US Revenue ($M)", "Non-US Revenue ($M)")

cat("=== Star Wars Box Office Matrix ===\n")
print(box_office)


# ----------------------------------------------------------
# STEP 2: Matrix Calculations
# ----------------------------------------------------------

# rowSums: total worldwide revenue for each film
worldwide <- rowSums(box_office)
cat("\n=== Worldwide Revenue Per Film ===\n")
print(worldwide)

# colSums: total US vs Non-US across all films
totals_by_region <- colSums(box_office)
cat("\n=== Total Revenue by Region ===\n")
print(totals_by_region)

# Add worldwide column to our matrix
box_office_full <- cbind(box_office, "Worldwide ($M)" = worldwide)
cat("\n=== Full Matrix with Worldwide ===\n")
print(box_office_full)

# Which films earned more outside the US than inside?
cat("\n=== Films where Non-US > US ===\n")
print(rownames(box_office)[non_us_earnings > us_earnings])

# Best performing film overall
cat("\n=== Highest Grossing Film ===\n")
cat(names(which.max(worldwide)), "with $", max(worldwide), "M worldwide\n")


# ----------------------------------------------------------
# STEP 3: Visualizations (Colorful Charts)
# ----------------------------------------------------------

library(ggplot2)
library(tidyr)   # for reshaping data

# --- Chart 1: Grouped Bar Chart — US vs Non-US per Film ---

films <- rownames(box_office)
films_factor <- factor(films, levels = films)  # preserve order

bar_data <- data.frame(
  Film   = rep(films_factor, 2),
  Region = c(rep("US", 6), rep("Non-US", 6)),
  Revenue = c(us_earnings, non_us_earnings)
)

chart1 <- ggplot(bar_data, aes(x = Film, y = Revenue, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  scale_fill_manual(values = c("US" = "#F39C12", "Non-US" = "#8E44AD")) +
  labs(
    title    = "⭐ Star Wars Box Office: US vs Non-US Revenue",
    subtitle = "Revenue in millions of dollars per film",
    x        = NULL,
    y        = "Revenue ($ Millions)",
    fill     = "Region"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title    = element_text(face = "bold", size = 15, color = "#1A252F"),
    axis.text.x   = element_text(angle = 35, hjust = 1, size = 10),
    legend.position = "top",
    panel.grid.major.x = element_blank()
  )

print(chart1)
ggsave("Project2_Chart1_USvsNonUS.png", chart1, width = 10, height = 5, dpi = 150)
cat("Chart 1 saved: Project2_Chart1_USvsNonUS.png\n")


# --- Chart 2: Stacked Bar — Worldwide Total Breakdown ---

chart2 <- ggplot(bar_data, aes(x = Film, y = Revenue, fill = Region)) +
  geom_bar(stat = "identity", position = "stack", width = 0.6) +
  geom_text(
    data = data.frame(Film = films_factor, Total = worldwide),
    aes(x = Film, y = Total, label = paste0("$", Total, "M")),
    inherit.aes = FALSE,
    vjust = -0.5, size = 3.5, fontface = "bold", color = "#2C3E50"
  ) +
  scale_fill_manual(values = c("US" = "#E67E22", "Non-US" = "#9B59B6")) +
  labs(
    title    = "🌍 Star Wars Worldwide Revenue (Stacked)",
    subtitle = "Total worldwide gross shown above each bar",
    x        = NULL,
    y        = "Revenue ($ Millions)",
    fill     = "Region"
  ) +
  ylim(0, max(worldwide) * 1.12) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title  = element_text(face = "bold", size = 15, color = "#1A252F"),
    axis.text.x = element_text(angle = 35, hjust = 1, size = 10),
    legend.position = "top",
    panel.grid.major.x = element_blank()
  )

print(chart2)
ggsave("Project2_Chart2_WorldwideStacked.png", chart2, width = 10, height = 5, dpi = 150)
cat("Chart 2 saved: Project2_Chart2_WorldwideStacked.png\n")


# --- Chart 3: Pie Chart — Share of Total Box Office per Film ---

pie_data <- data.frame(
  Film    = films,
  Revenue = worldwide
)
pie_data$Percentage <- round(pie_data$Revenue / sum(pie_data$Revenue) * 100, 1)
pie_data$Label      <- paste0(pie_data$Film, "\n", pie_data$Percentage, "%")

star_wars_colors <- c("#FFD700", "#FF6347", "#7EC8E3",
                      "#90EE90", "#DDA0DD", "#FFA07A")

chart3 <- ggplot(pie_data, aes(x = "", y = Revenue, fill = Film)) +
  geom_bar(stat = "identity", width = 1, color = "white", linewidth = 0.5) +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = star_wars_colors) +
  geom_text(aes(label = paste0(Percentage, "%")),
            position = position_stack(vjust = 0.5),
            size = 4, fontface = "bold", color = "black") +
  labs(
    title    = "🥧 Share of Total Box Office by Film",
    fill     = "Film"
  ) +
  theme_void(base_size = 12) +
  theme(
    plot.title      = element_text(face = "bold", size = 15,
                                   hjust = 0.5, color = "#1A252F"),
    legend.position = "right",
    legend.text     = element_text(size = 9)
  )

print(chart3)
ggsave("Project2_Chart3_PieShare.png", chart3, width = 8, height = 6, dpi = 150)
cat("Chart 3 saved: Project2_Chart3_PieShare.png\n")

cat("\n✅ Project 2 Complete!\n")
