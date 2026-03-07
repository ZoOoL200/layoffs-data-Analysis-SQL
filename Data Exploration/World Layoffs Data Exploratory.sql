USE world_layoff;

-- Date  Range of Data
SELECT  MIN(`date`) AS `Start`, MAX(`date`) AS `End`
FROM layoffs_stagging2; 

-- Ranking By countries
WITH top_country AS(
SELECT country , SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY country
having total IS NOT NULL
ORDER BY total DESC)
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking 
FROM top_country ;

-- select top 5 countries
WITH top_country AS(
SELECT country , SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY country
having total IS NOT NULL
ORDER BY total DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking 
FROM top_country )
SELECT * FROM ranking_table
WHERE Ranking <=5;

-- Top 5 countries for each year
WITH top_country AS(
SELECT country , YEAR(`date`) AS years , SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY country , years
having total IS NOT NULL AND years IS NOT NULL
ORDER BY total DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY total DESC) AS Ranking 
FROM top_country )
SELECT * FROM ranking_table
WHERE Ranking <=5;

-- Ranking by industry
WITH top_idustry AS(
SELECT industry , SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY industry
having total IS NOT NULL
ORDER BY total DESC)
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking 
FROM top_idustry ;

-- top 5 industries 
WITH top_idustry AS(
SELECT industry , SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY industry
having total IS NOT NULL
ORDER BY total DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking 
FROM top_idustry)
SELECT * FROM ranking_table WHERE Ranking <=5 ;

-- top 5 industries for each year
WITH top_idustry AS(
SELECT industry , YEAR(`date`) AS years, SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY industry , years
having total IS NOT NULL AND years IS NOT NULL
ORDER BY total DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY total DESC) AS Ranking 
FROM top_idustry)
SELECT * FROM ranking_table WHERE Ranking <=5 ;

-- Ranking By Year
WITH layoff_by_years AS(
SELECT YEAR(`date`) AS years, SUM(total_laid_off) AS total 
FROM layoffs_stagging2
GROUP BY  years 
HAVING years IS NOT NULL
)
SELECT * ,DENSE_RANK() OVER( ORDER BY  total DESC ) AS Ranking
FROM layoff_by_years;


-- Ranking By Companies
WITH top_company AS(
SELECT company, SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY company
) 
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking FROM top_company;

-- Top 5 Ranking by companies
WITH top_company AS(
SELECT company, SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY company
), ranking_table AS(
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking FROM top_company
)
SELECT * FROM ranking_table 
WHERE Ranking <=5; 

-- Top 5 Companies for each year
WITH top_company AS(
SELECT company,YEAR(`date`) AS years , SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY company ,years 
HAVING years IS NOT NULL
), ranking_table AS(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY total DESC) AS Ranking FROM top_company
)
SELECT * FROM ranking_table 
WHERE Ranking <=5; 

-- Relation between Funds and layoffs
SELECT funds_raised_millions , AVG(total_laid_off)
FROM layoffs_stagging2 
WHERE funds_raised_millions IS NOT NULL AND total_laid_off IS NOT NULL 
GROUP BY funds_raised_millions
ORDER BY 1 ASC;

-- Ranking by Stage
WITH top_stage AS(
SELECT stage, SUM(total_laid_off) AS total
FROM layoffs_stagging2
WHERE stage IS NOT NULL
GROUP BY stage 
HAVING total IS NOT NULL
) 
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking FROM top_stage;

-- Top 5 stages for each year
WITH top_stage AS(
SELECT stage, YEAR(`date`) AS years, SUM(total_laid_off) AS total
FROM layoffs_stagging2
WHERE stage IS NOT NULL 
GROUP BY stage , years
HAVING total IS NOT NULL AND years IS NOT NULL
) , 
ranking_table AS(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY total DESC) AS Ranking FROM top_stage)
SELECT * FROM ranking_table
WHERE Ranking <= 5  ;


-- Top 5 stages 
WITH top_stage AS(
SELECT stage, SUM(total_laid_off) AS total
FROM layoffs_stagging2
WHERE stage IS NOT NULL
GROUP BY stage 
HAVING total IS NOT NULL
) , 
ranking_table AS(
SELECT * , DENSE_RANK() OVER(ORDER BY total DESC) AS Ranking FROM top_stage)
SELECT * FROM ranking_table
WHERE Ranking <= 5  ;

-- Top layoff Quarter for each year
WITH Quater_layoff AS(
SELECT YEAR(`date`) AS years, QUARTER(`date`) AS `Quarter`, SUM(total_laid_off) AS total
FROM layoffs_stagging2
GROUP BY years , `Quarter`
HAVING years IS NOT NULL
ORDER BY years
) ,
ranking_table AS
(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY total) AS Ranking
FROM Quater_layoff
)
SELECT years, `Quarter`, total FROM ranking_table 
WHERE Ranking =1;

-- Ranking Years by the Number of Company Shutdowns
SELECT YEAR(`date`) AS years, COUNT(Percentage_laid_off) AS `No.Shutdown`
FROM layoffs_stagging2
WHERE Percentage_laid_off =1
GROUP BY years 
HAVING years IS NOT NULL
ORDER BY `No.Shutdown` DESC;

-- Ranking Countires by Number of Company Shutdowns
WITH shutdown_table AS(
SELECT country , COUNT(Percentage_laid_off) AS `No.Shutdown`
FROM layoffs_stagging2
WHERE Percentage_laid_off =1
GROUP BY country 
ORDER BY `No.Shutdown` DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(ORDER BY `No.Shutdown` DESC) AS Ranking FROM shutdown_table)
SELECT * FROM ranking_table 
WHERE Ranking <=5;

-- Top 3 Rank of Countries by Number of Company Shutdowns for each year
WITH shutdown_table AS(
SELECT  country , YEAR(`date`) AS years, COUNT(Percentage_laid_off) AS `No.Shutdown`
FROM layoffs_stagging2
WHERE Percentage_laid_off =1 
GROUP BY country , years
HAVING years IS NOT NULL
ORDER BY `No.Shutdown` DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY `No.Shutdown` DESC) AS Ranking FROM shutdown_table)
SELECT * FROM ranking_table 
WHERE Ranking <=3;



-- Ranking Indusstry by Number of Company Shutdowns
WITH shutdown_table AS(
SELECT industry , COUNT(Percentage_laid_off) AS `No.Shutdown`
FROM layoffs_stagging2
WHERE Percentage_laid_off =1
GROUP BY industry 
ORDER BY `No.Shutdown` DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(ORDER BY `No.Shutdown` DESC) AS Ranking FROM shutdown_table)
SELECT * FROM ranking_table 
WHERE Ranking <=5;

-- Top 3 Rank of Industries by Number of Company Shutdowns for each year
WITH shutdown_table AS(
SELECT  industry , YEAR(`date`) AS years, COUNT(Percentage_laid_off) AS `No.Shutdown`
FROM layoffs_stagging2
WHERE Percentage_laid_off =1 
GROUP BY industry , years
HAVING years IS NOT NULL
ORDER BY `No.Shutdown` DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY `No.Shutdown` DESC) AS Ranking FROM shutdown_table)
SELECT * FROM ranking_table 
WHERE Ranking <=3;

-- Ranking Stage by Number of Company Shutdowns
WITH shutdown_table AS(
SELECT stage , COUNT(Percentage_laid_off) AS `No.Shutdown`
FROM layoffs_stagging2
WHERE Percentage_laid_off =1
GROUP BY stage 
ORDER BY `No.Shutdown` DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(ORDER BY `No.Shutdown` DESC) AS Ranking FROM shutdown_table)
SELECT * FROM ranking_table 
WHERE Ranking <=5;

-- Top 3 Rank of stages by Number of Company Shutdowns for each year
WITH shutdown_table AS(
SELECT  stage , YEAR(`date`) AS years, COUNT(Percentage_laid_off) AS `No.Shutdown`
FROM layoffs_stagging2
WHERE Percentage_laid_off =1 
GROUP BY stage , years
HAVING years IS NOT NULL
ORDER BY `No.Shutdown` DESC)
, ranking_table AS(
SELECT * , DENSE_RANK() OVER(PARTITION BY years ORDER BY `No.Shutdown` DESC) AS Ranking FROM shutdown_table)
SELECT * FROM ranking_table 
WHERE Ranking <=3;
