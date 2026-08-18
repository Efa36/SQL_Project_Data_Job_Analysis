/*
Question: what are the top demanded skills for data analysts?
-Join job postings to most in-demand skills for data analysts?
-Identify the 5 in-demand skills fora a data analyst.
-Foucs on all job postings.
-Why? Retrives the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for jpb seekers.
*/
 SELECT 
     skills,
     COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 'True'
    GROUP BY
       skills
    ORDER BY
       demand_count DESC
    LIMIT 5; 