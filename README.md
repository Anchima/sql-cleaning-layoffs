Employee Layoffs Data Cleaning — SQL Project

Short Description
Cleaned and standardized the layoffs dataset to make it accurate and ready for exploratory data analysis. The project focuses on duplicates, inconsistent company names, missing values, date formats, whitespace issues, and incorrect industry labels.

Tools & SQL Commands Used
MySQL / MySQL Workbench

SQL commands: SELECT, UPDATE, DELETE, INSERT, ALTER TABLE, DROP, DISTINCT, GROUP BY, ORDER BY, WHERE, JOIN

Functions: TRIM(), LOWER(), UPPER(), STR_TO_DATE(), DATE(), ROW_NUMBER(), CTEs (WITH ...)

Problem Statement:
The dataset contained multiple issues that would prevent accurate analysis:
Duplicate rows
Inconsistent company names
NULL/missing values
Mixed or incorrect date formats
Extra whitespace in text fields
Blank rows
Incorrect industry labels
Text fields not properly formatted as dates
Steps Taken
Inspected the dataset to identify all data quality issues.
Removed duplicate rows using ROW_NUMBER() and CTEs.
Standardized company names and industry labels using TRIM(), LOWER(), UPPER(), and CASE statements.
Handled NULL values with appropriate replacements or removals.
Standardized date columns using STR_TO_DATE() and DATE().
Removed blank rows and trimmed extra whitespace.
Converted text fields to proper data types for analysis.
Verified data consistency and correctness with SELECT, GROUP BY, and ORDER BY queries.

Key Queries:
All SQL scripts are saved in sql/layoffs_cleaning.sql with comments explaining each step.

Results:
Duplicate rows removed → dataset now contains only unique entries
Company names and industry labels standardized
NULL values and blank rows handled
All date fields formatted as YYYY-MM-DD
Dataset is now fully cleaned and ready for EDA
Files in this Project
sql/layoffs_cleaning.sql — full SQL script
data/sample_cleaned.csv — small sample of cleaned data (optional)
screenshots/before_after.png — visual proof of cleaning results

Project Goal:
Clean the layoffs dataset to make it accurate and ready for exploratory data analysis.

Contact:
Your Name — www.linkedin.com/in/ani-chiemerie-237965299
