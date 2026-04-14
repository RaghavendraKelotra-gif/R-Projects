# Introduction to R — Course Portfolio
This repository showcases a series of technical projects completed as part of an Introduction to R course. It demonstrates a progression from basic vector arithmetic to complex data structures like data frames, factors, and lists, paired with professional data visualizations using ggplot2.


## Project 1 — Vegas Gambling Analysis
File: Project1_Vegas_Gambling_Vectors.R

### Description
This project analyzes a gambler's weekly results in Poker and Roulette across 7 days using vectors. It compares winnings, calculates totals, and visualizes daily and cumulative performance.

### R Concepts Demonstrated
Vector Construction: Creating data sequences using `c()`.
Naming: Assigning days of the week to vector elements with `names()`.
Arithmetic: Performing element-wise addition to find combined daily totals.
Statistical Functions: Using `sum()` for totals and `cumsum()` for running balances.
Logical Subsetting: Filtering data to show only profitable days.

### Visualizations
Chart 1 (Grouped Bar): Daily winnings/losses comparing Poker vs. Roulette.
Chart 2 (Line Chart): Cumulative running totals (Poker, Roulette, and Combined).
Chart 3 (Bar Chart): Total profit/loss summary per game.



##  Project 2 — Star Wars Box Office Analysis
File: Project2_StarWars_BoxOffice_Matrices.R

### Description
This project builds a matrix of box office earnings (US and Non-US) for six Star Wars films. It performs matrix operations to compare regional performance and identify the highest-grossing installments.

### R Concepts Demonstrated
Matrix Creation: Building 2D data structures using `matrix()`.
Data Binding: Adding new columns to existing structures with `cbind()`.
Labelling: Managing dimensions with `rownames()` and `colnames()`.
Aggregation: Using `rowSums()` and `colSums()` for movie-wise and region-wise totals.
Selection: Using `which.max()` to programmatically find the top-performing film.

### Visualizations
Chart 1 (Grouped Bar): Comparison of US vs. Non-US revenue per film.
Chart 2 (Stacked Bar): Worldwide total revenue with labels.
Chart 3 (Pie Chart): Each film's percentage share of the total box office.



##  Project 3 — Student Survey Analysis
File: Project3_StudentSurvey_DataFrames_Factors_Lists.R

### Description
A comprehensive analysis of a fictional survey of 20 students. It tracks exam scores, study hours, age, and subject preferences using data frames, ordered factors, and summary lists.

### R Concepts Demonstrated
Data Frames: Using `data.frame()` to store multiple data types.
Data Transformation: Categorizing numeric scores into levels using `cut()`.
Factors: Creating Ordered Factors to reflect rank-based performance (Failing < Average < Good < Excellent).
Subsetting & Sorting: Filtering rows based on scores and ranking the data frame using `order()`.
Lists: Creating a `survey_results` list to store text, numbers, tables, and the full data frame in one object.

### Visualizations
Chart 1 (Bar Chart): Count of students per performance level.
Chart 2 (Scatter Plot): Correlation between study hours and exam scores with a trend line.
Chart 3 (Pie Chart): Distribution of favorite subjects among the cohort.
Chart 4 (Box Plot): Score distribution categorized by favorite subject.
