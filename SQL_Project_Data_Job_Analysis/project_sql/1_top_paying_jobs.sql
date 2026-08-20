/*
Question: What are the top paying Data Analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focus on job postings with specified salaries and exclude those without salary information.
- Why? Highlight the top-paying opportunities for Data Analysts seeking remote work, providing insights into employment opportunties for Data Analysts in the current job market.
*/
SELECT
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date:: DATE,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_work_from_home = 'True'
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
