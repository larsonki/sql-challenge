-- Confirm data imported.

SELECT *
FROM titles;

-- (1) List the following details of each employee: employee number, 
-- last name, first name, sex, and salary.

-- Inner Join on employees & salaries
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s ON
s.emp_no=e.emp_no;

-- (2) List first name, last name, and hire date for employees who were
-- hired in 1986.

-- Filter using WHERE & EXTRACT year from hire_date and set equal to 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date)=1986
ORDER BY hire_date;

-- (3) List the manager of each department with the following information:
-- department number, department name, the manager's employee number,
-- last name, first name.

-- Complete Inner Join using dept_manager, departments & employees
-- Create aliases for each table
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM dept_manager m
INNER JOIN departments d ON
m.dept_no=d.dept_no
INNER JOIN employees e ON
m.emp_no=e.emp_no;

-- (4) List the department of each employee with the following 
-- information: employee number, last name, first name & department name.

-- Complete Inner Join using dept_emp, employees & departments
-- Create aliases for each table
-- Create a view for future filtering in question 6 & 7.
CREATE VIEW emp_depts AS
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
INNER JOIN employees e ON
de.emp_no=e.emp_no
INNER JOIN departments d ON
de.dept_no=d.dept_no;

-- (5) List first name, last name, and sex for employees whose first
-- name is "Hercules" and last names begin with "B."

-- Filter using WHERE and LIKE with a wildcard
SELECT first_name, last_name, sex
FROM employees
WHERE first_name='Hercules' AND last_name LIKE 'B%';

-- (6) List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.

-- Use the emp_depts view & WHERE to query
SELECT *
FROM emp_depts
WHERE dept_name='Sales';

-- (7) List all employees in the Sales and Development departments,
-- including their employee number, last name, first name, and 
-- department name.

-- Use the emp_depts view, WHERE & OR to query
SELECT *
FROM emp_depts
WHERE dept_name='Sales' OR dept_name='Development'
ORDER BY dept_name;

-- (8) List the frequency count of employee last names 
-- (i.e., how many employees share each last name) in descending order.

-- Use COUNT function, GROUP BY & ORDER BY
SELECT last_name, COUNT(last_name)
FROM emp_depts
GROUP BY last_name
ORDER BY last_name DESC;