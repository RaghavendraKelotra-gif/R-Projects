#  Introduction to R — Projects Portfolio

##  Repository Structure

```
intro-to-r-projects/
│
├── README.md                          ← You are here
│
├── Project1_Vegas_Gambling/
│   ├── Project1_Vegas_Gambling_Vectors.R
│   └── output/
│       ├── Project1_Chart1_DailyWinnings.png
│       ├── Project1_Chart2_CumulativeWinnings.png
│       └── Project1_Chart3_Summary.png
│
├── Project2_StarWars_BoxOffice/
│   ├── Project2_StarWars_BoxOffice_Matrices.R
│   └── output/
│       ├── Project2_Chart1_USvsNonUS.png
│       ├── Project2_Chart2_WorldwideStacked.png
│       └── Project2_Chart3_PieShare.png
│
└── Project3_Student_Survey/
    ├── Project3_StudentSurvey_DataFrames_Factors_Lists.R
    └── output/
        ├── Project3_Chart1_Performance.png
        ├── Project3_Chart2_ScatterStudyVsScore.png
        ├── Project3_Chart3_FavSubject.png
        └── Project3_Chart4_BoxPlotSubject.png
```

---

##  Projects at a Glance

| # | Project | Core R Topics | Charts |
|---|---------|--------------|--------|
| 1 |  Vegas Gambling Analysis | Vectors, named vectors, vector arithmetic | 3 |
| 2 |  Star Wars Box Office | Matrices, rowSums/colSums, cbind | 3 |
| 3 |  Student Survey Analysis | Data Frames, Factors, Lists | 4 |

---

##  Project 1 — Vegas Gambling Analysis

**File:** `Project1_Vegas_Gambling/Project1_Vegas_Gambling_Vectors.R`

**Description:**  
Analyzes a week of casino results for Poker and Roulette across 7 days using **vectors**.

**R Concepts Demonstrated:**
- Creating vectors with `c()`
- Naming vector elements with `names()`
- Element-wise arithmetic (adding two vectors)
- `sum()` and `cumsum()` for totals and running totals
- Logical subsetting: `vector[vector > 0]`

**Charts Produced:**

| Chart | Type | Description |
|-------|------|-------------|
| Chart 1 | Grouped Bar | Daily winnings: Poker vs Roulette |
| Chart 2 | Line Chart | Cumulative running totals across the week |
| Chart 3 | Bar Chart | Total profit/loss summary per game |

---

##  Project 2 — Star Wars Box Office Analysis

**File:** `Project2_StarWars_BoxOffice/Project2_StarWars_BoxOffice_Matrices.R`

**Description:**  
Builds a matrix of box office earnings (US and Non-US) for 6 Star Wars films and performs matrix operations to compare performance.

**R Concepts Demonstrated:**
- Creating a matrix with `matrix()`
- `cbind()` to add columns to a matrix
- `rownames()` and `colnames()` for labelling
- `rowSums()` and `colSums()` for totals
- `which.max()` to find the best-performing film
- Logical comparison across rows

**Charts Produced:**

| Chart | Type | Description |
|-------|------|-------------|
| Chart 1 | Grouped Bar | US vs Non-US revenue per film |
| Chart 2 | Stacked Bar | Worldwide total with labels |
| Chart 3 | Pie Chart | Each film's % share of total box office |

---

##  Project 3 — Student Survey Analysis

**File:** `Project3_Student_Survey/Project3_StudentSurvey_DataFrames_Factors_Lists.R`

**Description:**  
Analyzes a fictional class survey of 20 students. Tracks exam scores, study hours, age, and subject preferences using a **data frame**, ordered **factors**, and a summary **list**.

**R Concepts Demonstrated:**
- Creating a data frame with `data.frame()`
- Adding new columns: `df$NewColumn <- ...`
- `cut()` to bin numeric scores into categories
- Ordered factors: `factor(..., ordered = TRUE)`
- Subsetting rows: `df[df$Score >= 85, ]`
- Sorting with `order()`
- Creating and accessing a `list()` with `$` and `[[]]`

**Charts Produced:**

| Chart | Type | Description |
|-------|------|-------------|
| Chart 1 | Bar Chart | Count of students per performance level |
| Chart 2 | Scatter Plot | Study hours vs exam score with trend line |
| Chart 3 | Pie Chart | Distribution of favourite subjects |
| Chart 4 | Box Plot | Score distribution by favourite subject |
