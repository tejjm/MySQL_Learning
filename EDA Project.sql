-- Exploratory Data Analysis

SELECT * 
FROM layoffs_staging2;

-- Q) Checking highest total laid off
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;
-- A) 12000

-- Q) Checking details where layoffs were 100%
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Q) Checking details where companies had raised highest funds but still laid off 100%
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Q) Companies that had highest layoffs
SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Q) Date range of layoffs
SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;
-- A) 2022-03-11 to 2023-03-06

-- Q) Layoffs as per industry
SELECT industry,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
-- A) Consumer, Retail, and Other were top 3.

-- Q) Layoffs as per country
SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
-- A) United States has the highest 256420 followed by India at 35793

-- Q) Layoffs as per year
SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;
-- A) 2023 with just first quarter had higher layoffs with a number of 125677

-- Q) Layoffs as per Stages 
SELECT stage,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;
-- A) Post-IPO had 204073 maximum.

-- Q) Checking layoffs as per month
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Creating rolling total using above query
WITH rolling_total AS(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) sum_total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC)
SELECT `MONTH`, sum_total_off
,SUM(sum_total_off) OVER(ORDER BY `MONTH`) AS Rolling_total
FROM rolling_total;

-- Q) Company, Year, and Total Laid off based on Ranking
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (company,years,total_laid_off) AS 
(
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(
SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5;