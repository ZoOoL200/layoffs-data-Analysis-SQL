# World Layoffs Data Cleaning Project (SQL)

## Project Overview
This project focuses on **cleaning and preparing a global layoffs dataset using SQL**.  
The main objective is to transform raw and inconsistent data into a **clean, structured, and analysis-ready dataset**.

The cleaning process includes several important data preprocessing steps such as:

- Removing duplicate records
- Standardizing text values
- Converting date formats
- Handling NULL and blank values
- Removing unnecessary columns

After the cleaning process, the dataset becomes suitable for **data analysis, visualization, and business intelligence applications**.

---

# Dataset Description

The dataset contains information about layoffs across different companies and industries worldwide.

| Column | Description |
|------|------|
| company | Name of the company |
| location | Company location |
| industry | Industry sector |
| total_laid_off | Total number of employees laid off |
| percentage_laid_off | Percentage of layoffs |
| date | Date of the layoffs |
| stage | Company funding stage |
| country | Country of the company |
| funds_raised_millions | Total funding raised in millions |

---

# Technologies Used

- **SQL**
- **MySQL**
- **Window Functions**
- **Common Table Expressions (CTE)**
- **Data Cleaning Techniques**

---

# Data Cleaning Steps

## 1️. Creating a Staging Table

To preserve the original dataset, a staging table was created to perform all cleaning operations.

```sql
CREATE TABLE layoffs_stagging LIKE layoffs;

INSERT INTO layoffs_stagging
SELECT * FROM layoffs;
```

---

## 2️. Removing Duplicate Records

Duplicates were identified using the `ROW_NUMBER()` window function.

```sql
ROW_NUMBER() OVER(
PARTITION BY company, location, industry,
total_laid_off, percentage_laid_off,
stage, date, country, funds_raised_millions
)
```

Rows with `row_num > 1` were considered duplicates and removed.

---

## 3️. Standardizing Data

Several columns were standardized to ensure consistency.

### Company Column
Removed special characters and unnecessary spaces.

```sql
REGEXP_REPLACE(TRIM(company),'^[&#]','')
```

---

### Industry Column
Grouped similar industry names under a unified label.

Example:

```
Crypto 
CryptoCurrency
Crypto Currency
```

Standardized to:

```
Crypto
```

---

### Country Column
Removed trailing punctuation marks.

Example:

```
United States.
```

Converted to:

```
United States
```

---

### Date Column
Converted text-based dates into proper SQL `DATE` format.

```sql
STR_TO_DATE(date,"%m/%d/%Y")
```

Then the column datatype was modified:

```sql
ALTER TABLE layoffs_stagging2
MODIFY COLUMN date DATE;
```

---

## 4️. Handling NULL and Blank Values

Some records contained missing values in the `industry` column.

These values were filled using information from other rows belonging to the same company.

```sql
UPDATE layoffs_stagging2 t1
JOIN layoffs_stagging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND (t2.industry IS NOT NULL);
```

---

## 5️. Removing Irrelevant Rows

Rows containing no meaningful information were removed.

```sql
DELETE FROM layoffs_stagging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
AND funds_raised_millions IS NULL;
```

---

## 6️. Dropping Temporary Columns

The helper column used for identifying duplicates was removed.

```sql
ALTER TABLE layoffs_stagging2
DROP COLUMN row_num;
```

---

# 📊 Final Clean Dataset

After completing the cleaning process, the dataset is:

- Free from duplicates
- Standardized
- Properly formatted
- Ready for analysis

```sql
SELECT *
FROM world_layoff.layoffs_stagging2;
```

---

# 📈 Future Analysis Possibilities

Once the data is cleaned, it can be used for further analysis such as:

- Layoffs trends over time
- Layoffs by industry
- Layoffs by country
- Companies with the largest layoffs
- Economic impact analysis

The dataset can also be used for building dashboards using tools such as:

- **Power BI**
- **Tableau**
- **Python (Pandas / Matplotlib)**
- **R**

---

# Author

**Ahmed Rabie**

Electrical Power Engineer  
Interested in **Data Analysis, SQL, and Data Science**
