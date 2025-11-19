-- data cleaning
select * from layoffs;

-- How to clean data
-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null value or blank values
-- 4. Remove any coulumns

create table layoffs_staging like layoffs; #creating an identical table so that if columns are deleted accidentally you can easily get it back
-- now we use the new table 
select * from layoffs_staging;
insert layoffs_staging select * from layoffs; #insert the records into the new table

-- 1. Remove duplicates
select *, row_number()over(partition by company, industry, total_laid_off, percentage_laid_off, `date`) as rowNum from layoffs_staging;

with duplicate_cte as (
select *, row_number()over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as rowNum from layoffs_staging
)

select * from duplicate_cte 
where rowNum > 1;

select * from layoffs_staging
where company = 'casper';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` datetime DEFAULT NULL,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rowNum` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;
insert into layoffs_staging2(
select *, row_number()over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as rowNum from layoffs_staging
);

delete from layoffs_staging2
where rowNum > 1;


-- standardizing data
# removing spaces in the first column
select company, (trim(company)) from layoffs_staging2;

update layoffs_staging2 
set company = (trim(company));

ALTER TABLE layoffs
MODIFY COLUMN date DATE;

select date(date) as clean_date from layoffs_staging2;

update layoffs_staging2
set `date` = date(date);

describe layoffs;

select distinct industry from layoffs_staging2
order by 1;

select * from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%';

select distinct country from layoffs_staging2
where country like 'united states%';

select distinct country, trim(trailing '.'from country)
from layoffs_staging2 
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'united states%';

select distinct country from layoffs_staging2
where country like 'united states%';

select * from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging2
where company = 'airbnb';

select * from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null)
and t2.industry is not null;


delete from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

alter table layoffs_staging2
drop column rowNum;

select * from layoffs_staging2;
select * from layoffs;

select year(`date`) 
from layoffs_staging2
group by year(`date`)
order by sum(total_laid_off) asc
;

select company, lay
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

select substring(`date`, 1,7) as month_, sum(total_laid_off) from layoffs_staging2
where substring(`date`, 1,7) is not null
group by month_
order by 1 asc
;

with Rollingtotal as (
select substring(`date`, 1,7) as month_, sum(total_laid_off) as totaloff from layoffs_staging2
where substring(`date`, 1,7) is not null
group by month_
order by 1 asc
)
select month_ , sum(totaloff) over(order by month_) as rollingtotal
from Rollingtotal;

with company_year(company, years, total_laid_off)as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)),
company_year_rank as (
select *, dense_rank() over (partition by years order by total_laid_off desc) as ranking
 from company_year
 where years is not null
 order by ranking asc
 )

 select * from company_year_rank
;

select distinct company, date from layoffs
order by 1;
 

 
 