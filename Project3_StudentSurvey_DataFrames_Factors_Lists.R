# ============================================================
#   PROJECT 3: Student Survey Analysis
#   Topics: Data Frames + Factors + Lists
#   Course: Introduction to R
# ============================================================
# WHAT THIS PROJECT DOES:
#   We analyze a fictional class survey of 20 students.
#   Data includes: age, grade, study hours, subject preference,
#   and performance level (factor).
#   We store summary results in a LIST, and use DATA FRAMES
#   for all analysis and visualization.
# ============================================================


# ----------------------------------------------------------
# STEP 1: Create the Data Frame
# ----------------------------------------------------------

# Set random seed so results are reproducible
set.seed(42)

student_df <- data.frame(
  StudentID     = paste0("S", sprintf("%02d", 1:20)),
  Name          = c("Alice", "Bob", "Carla", "David", "Emma",
                    "Faisal", "Grace", "Hiro", "Isla", "Jake",
                    "Kira", "Leo", "Mia", "Noor", "Omar",
                    "Priya", "Quinn", "Ravi", "Sofia", "Tom"),
  Age           = c(19, 21, 20, 22, 19, 23, 20, 21, 19, 22,
                    20, 21, 19, 20, 22, 21, 23, 20, 19, 21),
  StudyHours    = c(6, 3, 7, 4, 8, 5, 9, 3, 7, 2,
                    6, 4, 8, 5, 3, 7, 6, 4, 9, 5),
  Score         = c(85, 60, 90, 70, 95, 75, 92, 55, 88, 48,
                    82, 65, 91, 78, 62, 87, 80, 68, 94, 73),
  FavSubject    = c("Math", "English", "Science", "Math", "Science",
                    "History", "Science", "English", "Math", "History",
                    "Math", "English", "Science", "History", "English",
                    "Math", "Science", "History", "Science", "Math"),
  stringsAsFactors = FALSE
)

# ----------------------------------------------------------
# STEP 2: Add a Factor Column — Performance Level
# ----------------------------------------------------------

# Categorize scores into performance levels (ordered factor)
student_df$Performance <- cut(
  student_df$Score,
  breaks = c(0, 59, 74, 89, 100),
  labels = c("Failing", "Average", "Good", "Excellent"),
  right  = TRUE
)

# Make it an ordered factor (Failing < Average < Good < Excellent)
student_df$Performance <- factor(
  student_df$Performance,
  levels  = c("Failing", "Average", "Good", "Excellent"),
  ordered = TRUE
)

# Make FavSubject a factor too
student_df$FavSubject <- factor(student_df$FavSubject)

cat("=== Student Survey Data Frame (First 6 Rows) ===\n")
print(head(student_df))

cat("\n=== Data Frame Structure ===\n")
str(student_df)


# ----------------------------------------------------------
# STEP 3: Explore the Data Frame
# ----------------------------------------------------------

cat("\n=== Summary Statistics ===\n")
print(summary(student_df[, c("Age", "StudyHours", "Score")]))

# Select only high-performing students (Score >= 85)
top_students <- student_df[student_df$Score >= 85, ]
cat("\n=== Top Students (Score >= 85) ===\n")
print(top_students[, c("Name", "Score", "Performance")])

# Order data frame by Score (descending)
ranked_df <- student_df[order(-student_df$Score), ]
cat("\n=== Students Ranked by Score ===\n")
print(ranked_df[, c("Name", "Score", "Performance", "StudyHours")])


# ----------------------------------------------------------
# STEP 4: Store Results in a LIST
# ----------------------------------------------------------

# A list can hold different types: vectors, data frames, numbers, text
survey_results <- list(
  title          = "Student Survey Analysis — Introduction to R",
  total_students = nrow(student_df),
  average_score  = round(mean(student_df$Score), 2),
  average_hours  = round(mean(student_df$StudyHours), 2),
  top_student    = student_df$Name[which.max(student_df$Score)],
  performance_table = table(student_df$Performance),
  subject_table     = table(student_df$FavSubject),
  full_data         = student_df
)

# Access list elements using $ or [[]]
cat("\n=== Survey Results List ===\n")
cat("Title:           ", survey_results$title, "\n")
cat("Total Students:  ", survey_results$total_students, "\n")
cat("Average Score:   ", survey_results$average_score, "\n")
cat("Average Study Hours:", survey_results$average_hours, "\n")
cat("Top Student:     ", survey_results$top_student, "\n")

cat("\n=== Performance Distribution ===\n")
print(survey_results$performance_table)

cat("\n=== Favourite Subject Distribution ===\n")
print(survey_results$subject_table)


# ----------------------------------------------------------
# STEP 5: Visualizations (Colorful Charts)
# ----------------------------------------------------------

library(ggplot2)

# --- Chart 1: Bar Chart — Performance Level Distribution ---

perf_df <- as.data.frame(survey_results$performance_table)
colnames(perf_df) <- c("Level", "Count")

perf_colors <- c("Failing"   = "#E74C3C",
                 "Average"   = "#F39C12",
                 "Good"      = "#3498DB",
                 "Excellent" = "#2ECC71")

chart1 <- ggplot(perf_df, aes(x = Level, y = Count, fill = Level)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = Count), vjust = -0.5, size = 5, fontface = "bold") +
  scale_fill_manual(values = perf_colors) +
  labs(
    title    = "📊 Student Performance Distribution",
    subtitle = "Number of students in each performance category",
    x        = "Performance Level",
    y        = "Number of Students"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title      = element_text(face = "bold", size = 16, color = "#2C3E50"),
    legend.position = "none",
    panel.grid.major.x = element_blank()
  )

print(chart1)
ggsave("Project3_Chart1_Performance.png", chart1, width = 7, height = 5, dpi = 150)
cat("Chart 1 saved: Project3_Chart1_Performance.png\n")


# --- Chart 2: Scatter Plot — Study Hours vs Score ---

chart2 <- ggplot(student_df, aes(x = StudyHours, y = Score,
                                  color = Performance, size = Score)) +
  geom_point(alpha = 0.85) +
  geom_smooth(method = "lm", se = TRUE, color = "gray40",
              linetype = "dashed", linewidth = 1, inherit.aes = FALSE,
              aes(x = StudyHours, y = Score)) +
  geom_text(aes(label = Name), vjust = -1, size = 3, color = "gray30") +
  scale_color_manual(values = perf_colors) +
  scale_size_continuous(range = c(3, 8)) +
  labs(
    title    = "📚 Study Hours vs Exam Score",
    subtitle = "Each dot = one student. Trend line shows correlation.",
    x        = "Daily Study Hours",
    y        = "Exam Score",
    color    = "Performance",
    size     = "Score"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title  = element_text(face = "bold", size = 16, color = "#2C3E50"),
    legend.position = "right"
  )

print(chart2)
ggsave("Project3_Chart2_ScatterStudyVsScore.png", chart2, width = 10, height = 6, dpi = 150)
cat("Chart 2 saved: Project3_Chart2_ScatterStudyVsScore.png\n")


# --- Chart 3: Pie Chart — Favourite Subject ---

subj_df <- as.data.frame(survey_results$subject_table)
colnames(subj_df) <- c("Subject", "Count")
subj_df$Pct <- round(subj_df$Count / sum(subj_df$Count) * 100, 1)

subj_colors <- c("English" = "#E74C3C", "History" = "#F39C12",
                 "Math"    = "#3498DB", "Science" = "#2ECC71")

chart3 <- ggplot(subj_df, aes(x = "", y = Count, fill = Subject)) +
  geom_bar(stat = "identity", width = 1, color = "white", linewidth = 0.8) +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = subj_colors) +
  geom_text(aes(label = paste0(Subject, "\n", Pct, "%")),
            position = position_stack(vjust = 0.5),
            size = 4.5, fontface = "bold", color = "white") +
  labs(
    title = "📚 Students' Favourite Subjects",
    fill  = "Subject"
  ) +
  theme_void(base_size = 13) +
  theme(
    plot.title      = element_text(face = "bold", size = 16,
                                   hjust = 0.5, color = "#2C3E50"),
    legend.position = "none"
  )

print(chart3)
ggsave("Project3_Chart3_FavSubject.png", chart3, width = 6, height = 6, dpi = 150)
cat("Chart 3 saved: Project3_Chart3_FavSubject.png\n")


# --- Chart 4: Box Plot — Score by Favourite Subject ---

chart4 <- ggplot(student_df, aes(x = FavSubject, y = Score, fill = FavSubject)) +
  geom_boxplot(width = 0.5, alpha = 0.8, outlier.colour = "red",
               outlier.size = 3) +
  geom_jitter(width = 0.15, size = 2.5, alpha = 0.7, color = "gray20") +
  scale_fill_manual(values = subj_colors) +
  labs(
    title    = "🎯 Exam Score by Favourite Subject",
    subtitle = "Box = interquartile range, dots = individual students",
    x        = "Favourite Subject",
    y        = "Exam Score"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title      = element_text(face = "bold", size = 16, color = "#2C3E50"),
    legend.position = "none",
    panel.grid.major.x = element_blank()
  )

print(chart4)
ggsave("Project3_Chart4_BoxPlotSubject.png", chart4, width = 8, height = 5, dpi = 150)
cat("Chart 4 saved: Project3_Chart4_BoxPlotSubject.png\n")

cat("\n✅ Project 3 Complete!\n")
