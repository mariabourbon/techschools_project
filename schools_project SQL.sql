create database project4;
/*COMMENTS DATAFRAME*/
select*
from project4.comments;
/*LOCATIONS DATAFRAME*/
select*
from project4.locations;
/*COURSES DATAFRAME*/
select*
from project4.courses;
/*BADGES DATAFRAME*/
select*
from project4.badges;
/*SHOOLS DATAFRAME*/
select*
from project4.schools;

/*QUESTIONS:
1.In Ironhack, over the X years, for data analysts, the overall score went (up or down), taking in consideration it's Alumni. (alumin, program, graduating year, overallscore, school)
2. Check relation between fake comments and overall score. (anynomous, overall score)
3. Check if the Alumni get a job and which job title. (Ironhack)
4. See how many schools per continent each school has, consider the online as a "continent"*/

/* create new column for CONTINENT - ALTER TABLE table_name ADD column_name data_type constraints*/
/*select name, anonymous, graduatingyear, isalumni, program, jobtitle, overallscore, school
from project4.comments
inner join (
			select school, school_id
            from project4.courses)
on project4.comments.school = project4.courses.school;*/

-- Question 1
-- First, filter data for Ironhack
SELECT *
FROM schools
WHERE school = 'ironhack';

-- Next, filter data for data analyst programs
SELECT *
FROM schools s
JOIN courses c
ON c.school = s.school
WHERE s.school = 'ironhack' AND c.courses LIKE '%Data Analytics%';

-- Group the data by graduating year and calculate the average overall score
SELECT graduatingYear, ROUND(AVG(overallScore), 1) AS average_score, isAlumni
FROM schools s
INNER JOIN comments co
ON s.school = co.school
INNER JOIN courses c
ON c.school = c.school
WHERE s.school = 'ironhack' AND c.courses LIKE '%Data Analytics%' AND isAlumni = false
GROUP BY co.graduatingYear, co.isAlumni
ORDER BY graduatingYear DESC, average_score DESC;

-- Question 2
-- Groups the data by the "anonymous" column and calculates the average overall score for each group

SELECT anonymous, AVG(overallScore) AS average_score
FROM comments
GROUP BY anonymous;

-- 3. Check if the Alumni get a job and which job title. (Ironhack)

SELECT isAlumni, jobTitle
FROM comments
WHERE school = 'Ironhack' AND isAlumni = true AND jobTitle = "%Data%" IS NOT NULL AND jobTitle <> '';

# 4. See how many schools per country each school has, consider the online as a "continent"*/

SELECT `country.name`, COUNT(DISTINCT(school_id)) AS number
FROM locations
GROUP BY `country.name`
ORDER BY number DESC;

