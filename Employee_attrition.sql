USE employee

ALTER TABLE `employee-attrition`
RENAME TO  `employee_attrition` ;

select * from employee_attrition


alter table employee_attrition
rename column ï»¿EmployeeID to EmployeeID;


update employee_attrition
set Gender = 'Male'
where Gender = 'M';

update employee_attrition
set Gender = 'Female'
where Gender = 'F';

describe employee_attrition

ALTER TABLE employee_attrition
MODIFY Age INT;


-- i. total employee--

select count(EmployeeID) as Total_Employees_Worked 
from employee_attrition

-- ii. Total attrited and Non Attrited Employees--

SELECT 
    (SELECT COUNT(*) FROM employee_attrition WHERE Attrition = 'Yes') AS Total_Attrited_Employees,
    (SELECT COUNT(*) FROM employee_attrition WHERE Attrition = 'No') AS Total_Non_Attrited_Employees;



-- iii. No. of Employee by Gender--

SELECT Gender, COUNT(EmployeeID) AS No_of_Employees, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Total_Attrited_Employees, COUNT(CASE WHEN Attrition = 'No' THEN 1 END) AS Total_Retention_Employees
FROM employee_attrition
GROUP BY Gender;


-- iv. No. of Employees by Department And Attrition --

SELECT Department, COUNT(EmployeeID) AS No_of_Employees, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Total_Attrited_Employees, COUNT(CASE WHEN Attrition = 'No' THEN 1 END) AS Total_Retention_Employees
FROM employee_attrition
GROUP BY Department
ORDER BY Department;



-- v. Top four Job roles getting attrition --

SELECT JobRole, COUNT(EmployeeID) AS No_of_Employees, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrition_Count
FROM employee_attrition
GROUP BY JobRole
ORDER BY Attrition_Count DESC
LIMIT 4;

-- vi. No. Of Employees by Distance From Home(in km) and Attrition --

SELECT DistanceFromHome AS Distance_from_home_in_km, COUNT(EmployeeID) AS No_of_Employees, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Total_Attrited_Employees, COUNT(CASE WHEN Attrition = 'No' THEN 1 END) AS Total_Retention_Employees
FROM employee_attrition
GROUP BY DistanceFromHome
ORDER BY DistanceFromHome ASC;


-- vii. Average Years at Company before attrition Of Employee --

SELECT AVG(YearsAtCompany) AS Average_Years_at_Company, MAX(YearsAtCompany) AS Maximum_Years_at_Company, MIN(YearsAtCompany) AS Minimum_Years_at_Company
FROM employee_attrition
WHERE Attrition = 'Yes';

-- viii. No. Of Employees by Marital Status who have taken Attrition --

SELECT MaritalStatus, COUNT(EmployeeID) AS No_of_Employees, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Total_Attrited_Employees, COUNT(CASE WHEN Attrition = 'No' THEN 1 END) AS Total_Retention_Employees
FROM employee_attrition
GROUP BY MaritalStatus;

-- ix. Find the details of employees under attrition having 5+ years of experience in between the age group of 27-35.

select * 
from employee_attrition
where age between 27 and 35
and TotalWorkingYears > 5
and Attrition = 'Yes';

select count(*) 
from employee_attrition
where age between 27 and 35
and TotalWorkingYears > 5
and Attrition = 'Yes';

-- x. The details of employees having maximum and minimum salary working in different department who receives less than 13% salary hike

select department,
	max(MonthlyIncome),
    min(MonthlyIncome),
    sum(attrition = 'Yes')as attrition,
    sum(attrition = 'No') as Retention
from employee_attrition
where percentsalaryhike < 13
group by department
order by max(MonthlyIncome) desc;

-- xi. The total number of male and female under attrition whose marital status is married and haven't received promotion in the last 2 years

SELECT gender , count(EmployeeID) as Married_Employee, sum(attrition = 'Yes')as attrition
from employee_attrition
where MaritalStatus = 'Married'
and YearsSinceLastPromotion = 2
group by gender;

-- xii. Employees with max performance rating but no promotion for 4 years above

select max(PerformanceRating) from employee_attrition

select *
from employee_attrition
where PerformanceRating = (select max(PerformanceRating) from employee_attrition)
and YearsSinceLastPromotion >= 4;


select count(*) 
from employee_attrition
where PerformanceRating = (select max(PerformanceRating) from employee_attrition)
and YearsSinceLastPromotion >= 4;

-- xiii. Who has mac and min percentage of salary hike

select YearsAtCompany, PerformanceRating, YearsSinceLastPromotion,
	max(PercentSalaryHike),
    min(PercentSalaryHike)
from employee_attrition
group by YearsAtCompany, PerformanceRating, YearsSinceLastPromotion
order by max(PercentSalaryHike) desc, min(PercentSalaryHike) asc;

-- xiv. Employees working overtime but given min salary hike and are working from more than 5 years with company

select *
from employee_attrition
where OverTime = 'Yes'
and PercentSalaryHike = (select min(PercentSalaryHike) from employee_attrition)
and YearsAtCompany > 5
order by Attrition desc;

select *
from employee_attrition
where OverTime = 'No'
and PercentSalaryHike = (select max(PercentSalaryHike) from employee_attrition)
and YearsAtCompany < 5
order by Attrition desc;
