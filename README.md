# 📉 World Layoffs: End-to-End SQL Data Project

## Project Summary
This project represents a complete data pipeline using SQL, starting from a raw, messy dataset of global layoffs and ending with a deep exploratory analysis. It is divided into two main phases: **Data Cleaning** and **Exploratory Data Analysis (EDA)**.

---

## Phase 1: Data Cleaning 🛠️
The objective was to transform the raw `layoffs` table into a structured, reliable dataset named `layoffs_stagging2`.

### Key Steps:
* **Duplicate Removal:** Used `ROW_NUMBER()` over partitioning multiple columns to identify and delete redundant records.
* **Standardization:** * Cleaned `company` names by removing special characters and trimming spaces.
    * Unified `industry` labels (e.g., standardizing all variations to 'Crypto').
    * Fixed `country` names by removing trailing punctuation.
* **Date Conversion:** Converted the `date` column from text format to a proper SQL `DATE` type using `STR_TO_DATE`.
* **Null Handling:** Populated missing `industry` values by performing a self-join on the `company` column.
* **Data Pruning:** Removed irrelevant rows where key metrics like `total_laid_off` and `percentage_laid_off` were both null.

---

## Phase 2: Exploratory Data Analysis (EDA) 📊
With the data cleaned, the second phase focused on uncovering economic patterns and layoff trends.

### Analysis Dimensions:
* **Geographic & Industrial:** Rankings of countries and sectors most affected by layoffs.
* **Company Performance:** Identification of top companies by layoff volume and funding stage impact.
* **Time-Series Trends:** Annual and quarterly breakdowns to find peak layoff periods.
* **Failure Analysis:** A deep dive into companies that reached a 100% layoff rate (shutdowns).

---

## Dataset Description
The final cleaned dataset includes:
| Column | Description |
| :--- | :--- |
| **company** | Name of the organization |
| **location** | Geographic area |
| **industry** | Sector of business |
| **total_laid_off** | Number of staff let go |
| **percentage_laid_off** | Ratio of layoffs to total staff |
| **date** | Event date (Standardized) |
| **stage** | Funding stage (Post-IPO, Series A, etc.) |
| **country** | Country of operation |
| **funds_raised_millions** | Total capital raised |

---

## Tools & Technologies
* **Language:** SQL (MySQL)
* **Techniques:** Window Functions, CTEs, Self-Joins, Regex, Data Type Casting

---

## How to Run the Project
1.  Execute the **`World Layoffs Story of Cleanning.sql`** script to prepare the staging tables and clean the data.
2.  Execute the **`World Layoffs Data Exploratory.sql`** script to generate the insights and rankings.

---

## Author
**Ahmed Rabie** *Electrical Power Engineer & Data Analysis Enthusiast*
