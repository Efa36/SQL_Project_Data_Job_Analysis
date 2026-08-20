# Introduction
Ever wondered which Data Analyst skills actually lead to higher-paying opportunities? 🤔💰

In this project, I explored the Data Analyst job market using SQL to uncover the skills and roles that stand out.

🔎 I analyzed:

- Top-paying Data Analyst jobs
-  Skills required for top-paying roles
-  Most in-demand Data Analyst skills
-  Highest-paying skills
-  Optimal skills — skills that offer a strong balance between demand and salary

The goal is simple: to understand which skills are most valuable in the Data Analyst job market and what aspiring Data Analysts should focus on developing. 🚀

🔍 Curious how I uncovered these insights? Explore the SQL queries behind the analysis [sql project data job analysis folder](/SQL_Project_Data_Job_Analysis/project_sql/).

# 📚 Background

This project was inspired by **Luke Barousse's SQL for Data Analytics project**, which helped me learn how SQL can be used to explore real-world job market data and answer practical career questions.

Rather than simply following along, I wanted to take the concepts I learned and build my own analysis around the questions I was curious about — **What skills are employers looking for? Which skills are associated with higher salaries? And which skills provide the best balance between demand and earning potential?** 🤔

Using SQL, I explored these questions step by step and turned the results into visualizations and insights. This project is part of my journey toward becoming a Data Analyst and a way to practice turning raw job-posting data into something meaningful. 📊🚀


# Tools I Used
To bring this analysis to life, I worked with a few key tools, each playing an important role in the project:

- **SQL** — The backbone of my analysis, allowing me to query the data, uncover patterns, and answer key questions about salaries, job roles, and skills.

- **PostgreSQL** — The database management system I used to store, organize, 
and work with the job posting data efficiently.

- **Visual Studio Code** — My go-to development environment for writing, organizing, and executing my SQL queries and managing the project files.

- **Git & GitHub** — Used for version control, tracking my progress, and sharing my SQL scripts, analysis, and project results.

Together, these tools helped me move from raw job-posting data → SQL analysis → insights → visualizations. 📊➡️💡

# The Analysis
Now that the data is prepared and the tools are in place, it’s time to dive into the analysis. 📊

I broke the project down into five key questions, with each SQL query focusing on a different part of the Data Analyst job market. Together, these queries help build a clearer picture of what skills are in demand, which skills are associated with higher salaries, and where aspiring Data Analysts can focus their efforts. 🚀 

1️⃣ What are the top-paying Data Analyst jobs?

First, I looked at the highest-paying Data Analyst positions to see which roles stood out in terms of annual salary.
 ```sql
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
```
The query returned the 10 highest-paying remote Data Analyst-related positions in the dataset, with salaries ranging from $184,000 to $650,000 annually. 💰

A few results stand out:

- Data Analyst at Mantys — $650,000
- Director of Analytics at Meta — $336,500
- Associate Director – Data Insights at AT&T — $255,829.50
- Data Analyst, Marketing at Pinterest — $232,423
- The remaining positions range from $184,000 to $217,000

Interestingly, the $650K Mantys position is a significant outlier compared with the other roles. Most of the remaining positions are concentrated between roughly $184K and $256K.

Overall, the results show that the highest-paying opportunities aren't limited to traditional Data Analyst titles. More senior roles such as Director, Associate Director, and Principal Data Analyst also appear among the highest earners. 🚀

<img width="768" height="432" alt="Top 10 Highest-Paying Data Analyst Jobs" src="https://github.com/user-attachments/assets/d96cb629-cb5e-442c-a9f8-cf170fc11135" />


2️⃣ What skills are required for the top-paying jobs?

Next, I looked at the skills associated with those high-paying roles to understand what employers are looking for in candidates earning the most.
```sql
WITH top_paying_jobs AS (  
    SELECT
        job_id,
        job_title,
        salary_year_avg, 
        company_dim.name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_work_from_home IS TRUE
        AND job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
  )
SELECT
     top_paying_jobs.*,
     skills_dim.skills AS skill_name
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim    
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
     top_paying_jobs.salary_year_avg DESC;
```
📊 Results Breakdown

This query connects the top-paying Data Analyst roles with the specific skills required for each position, giving a closer look at what skills are associated with higher-paying opportunities. 🛠️💰

A few patterns stand out:

- **SQL** and **Python** appear in all 8 roles, making them the most consistent skills across these high-paying positions.

- **Tableau** appears in 6 of the 8 roles, making it the most common visualization tool in this group.

- **R** appears in 4 roles, while Excel, Pandas, and Snowflake each appear in 3 roles.

- **AWS** and Azure appear in 2 roles each, showing that cloud technologies are also present in several higher-paying positions.

- Tools such as **Git**, **GitLab**, **Jira**, **Bitbucket**, **Atlassian**, and **Confluence** appear in some of the more senior roles, suggesting that collaboration and software-development workflows can also be part of Data Analyst positions.

Interestingly, the skills vary quite a bit between roles. For example, the Associate Director at AT&T requires a broad mix of SQL, Python, R, cloud technologies, data-processing tools, and visualization software, while the ERM Data Analyst has a much smaller skill set consisting of SQL, Python, and R.

<img width="768" height="432" alt="Top 10 Skills Required by High-Paying Data Analyst Roles" src="https://github.com/user-attachments/assets/c5bd2f11-a71f-4d1e-ad02-ac29a4980539" />


3️⃣ What are the most in-demand skills?

I then shifted the focus from salary to demand, identifying which skills appear most frequently across Data Analyst job postings.
```sql
 SELECT 
     skills,
     COUNT(skills_job_dim.job_id) AS demand_count
FROM
     job_postings_fact
INNER JOIN skills_job_dim 
     ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
     ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
     job_title_short = 'Data Analyst' 
     AND job_work_from_home = 'True'
GROUP BY
       skills
ORDER BY
       demand_count DESC
LIMIT 5; 
```
📊 Results Breakdown

This query highlights the 5 most in-demand skills across the Data Analyst job market, based on how many job postings listed each skill. 📈

A few results stand out:

| Skill    | Demand Count |
| -------- | -----------: |
| SQL      |        7,291 |
| Excel    |        4,611 |
| Python   |        4,330 |
| Tableau  |        3,745 |
| Power BI |        2,609 |


SQL clearly stands out as the most demanded skill, appearing in significantly more job postings than the other skills. Excel comes in second, followed closely by Python, while Tableau and Power BI round out the top five.

Overall, the results show that employers continue to place strong emphasis on core data analysis and business intelligence tools, with SQL being the most consistently requested skill.

4️⃣ Which skills are associated with the highest salaries?

After looking at demand, I wanted to see the other side of the equation: which skills are linked to the highest average salaries?
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0)  AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_work_from_home = 'True'
    AND salary_year_avg IS NOT NULL 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
```
📊 Results Breakdown

This query looks at the average salary associated with different skills, helping identify which skills are linked to the highest-paying Data Analyst opportunities. 📈

A few results stand out:

| Skill      | Average Salary |
|------------|---------------:|
| PySpark    | $208,172       |
| Bitbucket  | $189,155       |
| Couchbase  | $160,515       |
| Watson     | $160,515       |
| DataRobot  | $155,486       |

Several other technical skills also stand out, including GitLab ($154,500), Jupyter ($152,777), Pandas ($151,821), and NumPy ($143,513). These results show a strong presence of data engineering, programming, machine learning, and development tools among the higher-paying skills.

Interestingly, PySpark stands out by a significant margin, with an average salary of $208K, making it the highest-paying skill in this result.

Overall, the results suggest that skills connected to big data, data engineering, machine learning, and technical development workflows can be associated with higher-paying opportunities. 🚀

5️⃣ What are the optimal skills to learn?

Finally, I combined demand and salary to identify the skills that offer the best balance between being frequently requested by employers and providing strong earning potential.
```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS demand_count,
    ROUND(AVG (job_postings_fact.salary_year_avg), 0)AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = 'True'
    AND salary_year_avg IS NOT NULL   
GROUP BY
    skills_dim.skill_id
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC
LIMIT 25;
```
📊 Results Breakdown

This query combines skill demand and average salary to identify skills that offer a strong balance between how often they are requested and how much they pay. 🎯

A few results stand out:

| Skill    | Job Postings | Average Salary |
|----------|-------------:|---------------:|
| Go       | 27           | $115,320       |
| Snowflake| 37           | $112,948       |
| Azure    | 34           | $111,225       |
| AWS      | 32           | $108,317       |
| Python   | 236          | $101,397       |
| Tableau  | 230          | $99,288        |

One interesting pattern is the difference between demand and salary. Python and Tableau appear in many more job postings than skills such as Go or Snowflake, while some of the less frequently requested skills have higher average salaries.

Overall, the results show that the most demanded skills aren't always the highest-paying skills. Skills such as Go, Snowflake, Azure, and AWS combine relatively strong salaries with moderate demand, while Python and Tableau stand out for their much higher demand. 🚀
# What I learned
🐣 From Zero to SQL

Started with no prior SQL experience and built a solid foundation through Luke Barousse’s clear, practical teaching style.
Learned SQL fundamentals including filtering, comparisons, wildcards, aliases, operations, aggregations, NULL values, and joins.

🚀 Advanced SQL & Databases

- Worked with PostgreSQL and VS Code and learned data types, date functions, CASE statements, subqueries, CTEs, and UNION.
Practiced solving problems hands-on instead of simply memorizing syntax.

📊 Real-World Data Analysis

- Applied SQL to a real Data Analyst project using job-posting data.
Analyzed top-paying jobs, in-demand skills, highest-paying skills, and the most optimal skills to learn.

💻 GitHub & Project Workflow

- Created and organized a GitHub repository for my project.
Learned how to document and present my SQL work professionally and share it on GitHub and LinkedIn.

🎯 The Biggest Takeaway

- Went from “I don’t know SQL” → actually using SQL to answer real-world questions.

# Conclusions
### Insights

From the analysis, several key insights emerged:

- **Top-Paying Data Analyst Jobs**: Remote Data Analyst positions offer a wide range of salaries, with the highest-paying roles reaching exceptionally high levels.
- **Skills for Top-Paying Jobs**: SQL appears consistently among the skills associated with higher-paying Data Analyst positions, highlighting its importance for earning potential.
- **Most In-Demand Skills**: SQL is also one of the most demanded skills in the Data Analyst job market, making it an essential skill for job seekers.
- **Skills with Higher Salaries**: Specialized skills, such as PySpark, Bitbucket, Couchbase, Watson, and DataRobot, are associated with some of the highest average salaries, indicating a premium on specialized expertise.
- **Optimal Skills for Job Market Value**: SQL stands out by combining strong demand with competitive salary potential, positioning it as one of the most valuable skills for aspiring Data Analysts to learn.

# Closing Thoughts

This project gave me the opportunity to go beyond learning SQL syntax and actually use SQL to explore a real-world dataset and answer meaningful questions. Starting from the basics and gradually working toward a complete Data Analyst project showed me how SQL can turn raw job-market data into useful insights.

The biggest takeaway for me is that SQL is not just a technical skill—it is a tool for asking better questions, finding patterns, and making data-driven decisions. This project also helped me become more comfortable working with PostgreSQL, VS Code, GitHub, and presenting my analysis.

Most importantly, it took me from learning SQL from zero to building and sharing my first data analysis project. 🚀
