-- Use the schema  
USE world_layoff;

-- Cheak for Data  
SELECT * FROM layoffs;
-- Creat a stagging table and move Data 	 
CREATE TABLE layoffs_stagging LIKE layoffs;
INSERT INTO  layoffs_stagging (SELECT * FROM layoffs);
SELECT * FROM layoffs_stagging;

-- Step one Duplicate 
	-- CHECK for doublicate 
	WITH duplicate_cte AS
	(SELECT * , 
	ROW_NUMBER() OVER(PARTITION BY company,
	 location, 
	 industry,
	 total_laid_off,
	 percentage_laid_off,
	 stage,`date`,
	 country, 
	 funds_raised_millions) AS row_num
	FROM layoffs_stagging
	)
	SELECT * FROM duplicate_cte WHERE row_num >1;

	-- Remove duplicate 
	 CREATE TABLE `layoffs_stagging2` (
	  `company` text,
	  `location` text,
	  `industry` text,
	  `total_laid_off` int DEFAULT NULL,
	  `percentage_laid_off` text,
	  `date` text,
	  `stage` text,
	  `country` text,
	  `funds_raised_millions` int DEFAULT NULL,
	  `row_num` INT 
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

	INSERT INTO layoffs_stagging2 
	(
	SELECT * , 
	ROW_NUMBER() OVER(PARTITION BY company,
	 location, 
	 industry,
	 total_laid_off,
	 percentage_laid_off,
	 stage,`date`,
	 country, 
	 funds_raised_millions) AS row_num
	FROM layoffs_stagging);

DELETE FROM layoffs_stagging2 WHERE row_num >1;

-- Standardizing Data
UPDATE layoffs_stagging2 SET company = REGEXP_REPLACE(TRIM(company),'^[&#]','') ,
location = TRIM(location) ,
industry = REGEXP_REPLACE(TRIM(industry),"^Crypto.*",'Crypto'),
country =  REGEXP_REPLACE(TRIM(country),"\\.$",'') ,
`date`= STR_TO_DATE(`date`,"%m/%d/%Y")  ;

ALTER TABLE layoffs_stagging2 
MODIFY COLUMN `date` DATE;
DESCRIBE layoffs_stagging2;
  
-- Null and Blanks Values
UPDATE layoffs_stagging2 t1 
JOIN layoffs_stagging2 t2 
	ON  t1.company = t2.company
SET t1.industry = t2.industry 
WHERE (t1.industry  IS NULL OR t1.industry = '')
		AND (t2.industry IS NOT NULL AND t2.industry != '');

-- Remove thes Rows
DELETE  FROM layoffs_stagging2  WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL AND funds_raised_millions IS NULL;

-- Reomve unncessry Columns
ALTER TABLE layoffs_stagging2 
DROP COLUMN row_num;
  
-- Data After Cleaned 
SELECT * FROM world_layoff.layoffs_stagging2 ;