# 📉 World Layoffs: End-to-End SQL Data Project

## Project Overview
This project demonstrates a complete **data analysis workflow**, starting from a raw dataset of global layoffs and transforming it into meaningful insights and visualizations.

The project is divided into three main phases:

1. Data Cleaning using SQL  
2. Exploratory Data Analysis (EDA)  
3. Data Visualization using Tableau  

The objective is to understand global layoffs trends across companies, industries, and countries.

---

# Phase 1: Data Cleaning

The raw dataset contained duplicates, inconsistencies, and missing values.  
This phase focused on transforming the dataset into a clean and reliable table called:

`layoffs_stagging2`

### Key Cleaning Steps

**Duplicate Removal**
- Used `ROW_NUMBER()` with window functions
- Partitioned across multiple columns
- Deleted redundant records

**Standardization**
- Cleaned company names using `TRIM()`
- Standardized industry labels (e.g., (Crypto,CryptoCurrency) → Crypto)
- Fixed country names by removing trailing punctuation

**Date Conversion**
- Converted the `date` column from text format to a proper SQL `DATE` format using `STR_TO_DATE()`

**Handling Missing Values**
- Filled missing `industry` values using a **self join** based on the company column

**Data Pruning**
- Removed rows where both:

`total_laid_off`  
`percentage_laid_off`

were `NULL`.

---

# Phase 2: Exploratory Data Analysis (EDA)

After cleaning the data, SQL queries were used to explore patterns and trends.

### Analysis Dimensions

**Geographic Analysis**
- Countries with the highest layoffs
- Distribution of layoffs across regions

**Industry Analysis**
- Industries most affected by layoffs
- Comparison across sectors

**Company Analysis**
- Companies with the largest layoffs
- Relationship between layoffs and company funding stage

**Time-Series Analysis**
- Layoffs trends across years
- Quarterly layoffs breakdown

**Company Failure Analysis**
- Identifying companies that reached **100% layoffs (shutdowns)**

### SQL Techniques Used

- Window Functions
- CTEs
- Aggregations
- Ranking Functions

---

# Phase 3: Data Visualization

The final phase focused on building an **interactive dashboard using Tableau** to present the insights visually.

The dashboard allows users to explore layoffs data in an intuitive and interactive way.

### Dashboard Highlights

**Total Layoffs Over Time**
- A time series showing layoffs trends across years

**Layoffs by Industry**
- Highlights industries with the highest layoffs

**Layoffs by Country**
- Displays the global distribution of layoffs

**Company Shutdown Analysis**
- Compares companies that fully shut down with those that continued operating

**Layoffs by Company Stage**
- Analyzes layoffs across funding stages such as:
  - Series A
  - Series B
  - Post-IPO companies

Interactive filters allow users to explore layoffs by **year, country, and industry**.

---

# 🖥️ Dashboard Preview

![Layoffs Dashboard](./Visualization/Dashboard.png)

---

# Dataset Description

The cleaned dataset contains the following columns:

| Column | Description |
|------|------|
| company | Name of the organization |
| location | Geographic location |
| industry | Business sector |
| total_laid_off | Number of employees laid off |
| percentage_laid_off | Layoff percentage |
| date | Date of the layoff event |
| stage | Company funding stage |
| country | Country of operation |
| funds_raised_millions | Total capital raised |

---

# Tools & Technologies

**Languages & Tools**

- SQL (MySQL)
- Tableau
- PowerPoint (Dashboard Layout)

**Techniques**

- Data Cleaning
- Window Functions
- CTEs
- Self Joins
- Data Type Conversion
- Aggregations
- Ranking Analysis

---

## 📁 Project Structure

```
World-Layoffs-Project
│
├── Data Cleaning
│   └── World Layoffs Story of Cleaning.sql
│
├── Exploratory Data Analysis
│   └── World Layoffs Data Exploratory.sql
│
├── Visualization
│   └── World Layoffs Dashboard.twb
│
├── Dataset
│   └── layoffs.csv
│
├── images
│   └── dashboard.png
│
└── README.md
```

---

# ▶️ How to Run the Project

1. Run the data cleaning script:

This prepares and cleans the dataset.

2. Run the exploratory analysis script:

This generates the analysis queries and insights.

3. Open the Tableau dashboard:

to explore the visualizations.

---

# 👨‍💻 Author

**Ahmed Rabie**

Electrical Power Engineer  
Aspiring Data Analyst
