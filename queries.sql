-- 1. Report:
-- How many rows do we have in each table in the employees database?
-- SQL Statement: 

`SELECT table_name, table_rows
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA ='employees';`

-- 2. Report:
-- How many employees with the first name "Mark" do we have in our company?
-- SQL Statement:

`SELECT employees.first_name, COUNT(employees.first_name) AS "amount"
FROM employees
WHERE employees.first_name ="Mark";`

-- 3. Report:
-- How many employees with the first name "Eric" and the last name beginning with "A" do we have in
-- our company?
-- SQL Statement:

`SELECT employees.first_name, COUNT(employees.first_name) AS "amount"
FROM employees
WHERE employees.first_name ="Eric" and employees.last_name LIKE "A%"
;`
-- CHECK –>

`SELECT employees.first_name, employees.last_name
FROM employees
WHERE employees.first_name ="Eric" and employees.last_name LIKE "A%"
;`
-- 4. Report:
-- How many employees do we have that are working for us since 1985 and who are they?
-- SQL Statement:

`SELECT COUNT(employees.hire_date) AS "amount"
FROM employees
WHERE YEAR(employees.hire_date) >="1985"
;`

`SELECT employees.*
FROM employees
WHERE YEAR(employees.hire_date) >="1985"
ORDER BY employees.hire_date;`

-- `5. Report:
-- How many employees got hired from 1990 until 1997 and who 'are they?
-- SQL Statement:`

`SELECT COUNT(employees.hire_date) AS "amount"
FROM employees
WHERE YEAR(employees.hire_date) >="1990" AND YEAR(employees.hire_date) <="1997"
;`
`SELECT employees.*
FROM employees
WHERE YEAR(employees.hire_date) >="1990" AND YEAR(employees.hire_date) <="1997"
ORDER BY employees.hire_date, employees.birth_date;`

-- `6. Report:
-- How many employees have salaries higher than EUR 70 000,00 and who are they?
-- SQL Statement:`

`SELECT COUNT(*) AS "employees_at_least_70000_salaray"
FROM (
SELECT COUNT(salaries.emp_no) AS "amount"
FROM salaries
WHERE salaries.salary >70000
GROUP BY salaries.emp_no
ORDER BY salaries.emp_no
) a;`

`SELECT employees.*, salaries.salary
FROM salaries
JOIN employees ON employees.emp_no =salaries.emp_no
WHERE salaries.salary >70000
ORDER BY salaries.emp_no
;`

-- `7. Report:
-- How many employees do we have in the Research Department, who are working for us since 1992
-- and who are they?
-- TIP:You can use the CURRENT_DATE() FUNCTION to access todays date
-- SQL Statement:`

`SELECT COUNT(*) AS "amount_working_in_research_since_1992"
FROM dept_emp
JOIN employees ON employees.emp_no =dept_emp.emp_no
WHERE dept_emp.dept_no ="d008" AND YEAR(employees.hire_date) >="1992"
;`

`SELECT employees.first_name, employees.last_name, employees.hire_date,
departments.dept_name AS "department"
FROM dept_emp
JOIN employees ON employees.emp_no =dept_emp.emp_no JOIN departments ON
departments.dept_no =dept_emp.dept_no
WHERE dept_emp.dept_no ="d008" AND YEAR(employees.hire_date) >="1992"
ORDER BY employees.hire_date
;`

-- `8. Report:
-- How many employees do we have in the Finance Department, who are working for us since 1985
-- until now and who have salaries higher than EUR 75 000,00 -who are they?
-- SQL Statement:`

`SELECT COUNT(*) AS "quantity_working_finance_since_1985_til_now_salaray_higher_75000"
FROM (
SELECT employees.first_name, employees.last_name, salaries.salary, employees.hire_date,
departments.dept_name AS "finances"
FROM dept_emp
JOIN employees ON employees.emp_no =dept_emp.emp_no JOIN departments ON
departments.dept_no =dept_emp.dept_no JOIN salaries ON salaries.emp_no =
employees.emp_no
WHERE dept_emp.dept_no ="d002" AND salaries.salary >75000 AND
(YEAR(employees.hire_date) BETWEEN "1985" AND YEAR(CURRENT_DATE())) AND
(YEAR(dept_emp.to_date) BETWEEN "1985" AND YEAR(CURRENT_DATE()))
GROUP BY employees.emp_no
ORDER BY employees.hire_date) a;
`
`SELECT employees.first_name, employees.last_name, salaries.salary, employees.hire_date,
departments.dept_name AS "finances"
FROM dept_emp
JOIN employees ON employees.emp_no =dept_emp.emp_no JOIN departments ON
departments.dept_no =dept_emp.dept_no JOIN salaries ON salaries.emp_no =
employees.emp_no
WHERE dept_emp.dept_no ="d002" AND salaries.salary >75000 AND
(YEAR(employees.hire_date) BETWEEN "1985" AND YEAR(CURRENT_DATE())) AND
(YEAR(dept_emp.to_date) BETWEEN "1985" AND YEAR(CURRENT_DATE()))
GROUP BY employees.emp_no
ORDER BY employees.hire_date
;`

-- `9. Report:
-- We need a table with employees, who are working for us at this moment: first and last name, date
-- of birth, gender, hire_date, title and salary.
-- SQL Statement:`

`SELECT employees.first_name, employees.last_name, employees.birth_date,
employees.gender, employees.hire_date, titles.title, salaries.salary
FROM employees
JOIN salaries ON salaries.emp_no =employees.emp_no JOIN titles ON titles.emp_no =
employees.emp_no
WHERE YEAR(titles.to_date) >=YEAR(CURRENT_DATE)
GROUP BY employees.emp_no
ORDER BY employees.hire_date
;`

-- `10. Report:
-- We need a table with managers, who are working for us at this moment: first and last name, date
-- of birth, gender, hire_date, title, department name and salary.
-- SQL Statement:`

`SELECT employees.first_name, employees.last_name, employees.birth_date,
employees.gender, employees.hire_date, titles.title, departments.dept_name, salaries.salary
FROM employees
JOIN titles ON titles.emp_no =employees.emp_no JOIN dept_emp ON dept_emp.emp_no =
employees.emp_no JOIN departments ON departments.dept_no =dept_emp.dept_no JOIN
salaries ON salaries.emp_no =employees.emp_no
WHERE YEAR(titles.to_date) >=YEAR(CURRENT_DATE) AND titles.title ="Manager"
GROUP BY employees.emp_no
ORDER BY employees.hire_date
;`

-- `Bonus query:
-- Create a query that will join all tables and show all data from all tables.
-- SQL Statement:`

`SELECT employees.first_name, employees.last_name, employees.gender,
employees.hire_date, departments.dept_name, dept_manager.from_date,
dept_manager.to_date, dept_emp.from_date, dept_emp.to_date, titles.title, titles.from_date,
titles.to_date, salaries.salary, salaries.from_date, salaries.to_date
FROM employees
JOIN dept_emp ON dept_emp.emp_no =employees.emp_no
JOIN departments ON departments.dept_no =dept_emp.dept_no
JOIN dept_manager ON (dept_manager.emp_no =employees.emp_no AND
dept_manager.dept_no =departments.dept_no)
JOIN titles ON titles.emp_no =employees.emp_no
JOIN salaries ON salaries.emp_no =employees.emp_no
ORDER BY employees.emp_no
;`

-- `Next step:
-- Now you should create at least 5 queries on your own, try to use data from more than 2 tables.
-- SQL Statement:`
