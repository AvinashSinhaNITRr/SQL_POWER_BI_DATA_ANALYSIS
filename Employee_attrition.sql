select * from employee_attrition


-- i. total employee--

select count(id) as Total_Employees_Worked from employee_attrition

-- ii. Total attrited and Non Attrited Employees--

SELECT 
    (SELECT COUNT(*) FROM employee_attrition WHERE Attrition = 'Yes') AS Total_Attrited_Employees,
    (SELECT COUNT(*) FROM employee_attrition WHERE Attrition = 'No') AS Total_Non_Attrited_Employees;


-- iii. Department wise Total Attrition -- 

SELECT Department, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Total_Attrited_Employees
FROM employee_attrition
GROUP BY Department;


-- iv. No. of Employees according to mode of working--

SELECT Mode_of_work, COUNT(ID) AS No_of_Employees
FROM employee_attrition
GROUP BY Mode_of_work;

-- v. No. of Employee by Gender--

SELECT Gender, COUNT(ID) AS No_of_Employees
FROM employee_attrition
GROUP BY Gender;

-- vi. Relation between employees, Attrition and age --

SELECT Age, Attrition, COUNT(ID) AS No_of_Employees
FROM employee_attrition
GROUP BY Age, Attrition
ORDER BY No_of_Employees;

-- vii. No. of Employees by Department And Attrition --

SELECT Department, Attrition, COUNT(ID) AS No_of_Employees
FROM employee_attrition
GROUP BY Department, Attrition
ORDER BY Department;



-- viii. No. of Employee by Job Role --

SELECT JobRole, Attrition, COUNT(ID) AS No_of_Employees
FROM employee_attrition
GROUP BY JobRole, Attrition
ORDER BY No_of_Employees;

-- ix. Top four Job roles getting attrition --

SELECT JobRole, COUNT(*) AS Attrition_Count
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY Attrition_Count DESC
LIMIT 4;

-- x. No. Of Employees by Distance From Home(in km) and Attrition --

SELECT DistanceFromHome AS Distance_from_home_in_km, COUNT(ID) AS No_of_Employees
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY DistanceFromHome, Attrition
ORDER BY DistanceFromHome ASC;


-- xi. No. Of Employees by Business Travel who have taken Attrition --

SELECT BusinessTravel, COUNT(*) AS Attrition_Count
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY BusinessTravel;

-- xii. No. Of Employees by Status Of Leaving who have taken Attrition--

SELECT Status_of_leaving, COUNT(*) AS Attrition_Count
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY Status_of_leaving;

-- xiii. Average Years at Company before attrition Of Employee --

SELECT AVG(YearsAtCompany) AS Average_Years_at_Company
FROM employee_attrition
WHERE Attrition = 'Yes';

-- xiv. No. Of Employees by Marital Status who have taken Attrition --

SELECT MaritalStatus, COUNT(*) AS Marital_Status
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY MaritalStatus;