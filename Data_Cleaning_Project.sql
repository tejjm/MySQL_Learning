-- Data Cleaning
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022

SELECT * FROM layoffs;
-- Things Done:
-- 1. Remove Duplicates
-- 2.Standardize the Data
-- 3. Null values evaluation and Deletion if needed 
-- 4. Remove any Columns necessary 

-- Creating a staging table and inserting layoffs data in it.

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT * 
FROM layoffs;
-- Duplicate Check with CTE 
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,'date') AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- Create another stage table for deleting duplicates

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting Data into Staging 2 table
INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE
FROM layoffs_staging2
WHERE row_num>1;

SELECT * FROM layoffs_staging2;

-- Standardizing rows of data

SELECT TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company)
;
SELECT DISTINCT(industry)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET industry = 'Cryto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United Stat%';

-- Converting Date(str) to Date type
SELECT `date`, STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` =  STR_TO_DATE(`date`,'%m/%d/%Y')
;

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

-- Changes blanks('') to Null for easier operations
UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL
;
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Fillinf Null values with available suitable data
SELECT t1.industry,t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;
    
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Deleting values which provide no information of layoffs
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- Removing row_num
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
