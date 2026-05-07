**Schema (MySQL v5.7)**

    -- Create Department table
    CREATE TABLE Department (
        department_id INT PRIMARY KEY,
        name VARCHAR(50) NOT NULL
    );
    
    -- Create Employee table
    CREATE TABLE Employee (
        emp_id INT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        age INT,
        salary DECIMAL(10, 2),
        department_id INT,
        hire_date DATE,
        FOREIGN KEY (department_id) REFERENCES Department(department_id)
    );
    
    -- Create Project table
    CREATE TABLE Project (
        project_id INT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        department_id INT,
        FOREIGN KEY (department_id) REFERENCES Department(department_id)
    );
    
    -- Insert data into Department table
    INSERT INTO Department (department_id, name) VALUES
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance'),
    (4, 'Marketing');
    
    -- Insert data into Employee table
    INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
    (1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
    (2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
    (3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
    (4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
    (5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
    (6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
    (7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');
    
    -- Insert data into Project table
    INSERT INTO Project (project_id, name, department_id) VALUES
    (1, 'Project Alpha', 1),
    (2, 'Project Beta', 2),
    (3, 'Project Gamma', 1),
    (4, 'Project Delta', 3),
    (5, 'Project Epsilon', 4),
    (6, 'Project Zeta', 4),
    (7, 'Project Eta', 3);
    
    
    -- Insert additional data into Department table (if needed)
    -- No additional departments needed for this data set
    
    -- Insert additional data into Employee table to test edge cases for joins and nested queries
    INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
    (8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
    (9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
    (10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');
    
    -- Insert additional data into Project table to test edge cases for joins
    INSERT INTO Project (project_id, name, department_id) VALUES
    (8, 'Project Theta', 1),
    (9, 'Project Iota', NULL);  -- Project without a department

---

**Query #1**

    -- 1
    SELECT * FROM Employee;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #2**

    -- 2
    SELECT name, salary FROM Employee;

| name        | salary  |
| ----------- | ------- |
| John Doe    | 50000.0 |
| Jane Smith  | 60000.0 |
| Bob Brown   | 80000.0 |
| Alice Blue  | 45000.0 |
| Charlie P.  | 50000.0 |
| David Green | 70000.0 |
| Eve Black   | 55000.0 |
| Frank White | 48000.0 |
| Grace Kelly | 65000.0 |
| Hannah Lee  | 53000.0 |

---
**Query #3**

    -- 3
    SELECT * FROM Employee
    WHERE age > 30;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |

---
**Query #4**

    -- 4
    SELECT name FROM Department;

| name      |
| --------- |
| IT        |
| HR        |
| Finance   |
| Marketing |

---
**Query #5**

    -- 5
    SELECT * FROM Employee
    WHERE department_id = (
        SELECT department_id FROM Department
        WHERE name = 'IT'
    );

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |

---
**Query #6**

    -- 6
    SELECT * FROM Employee
    WHERE name LIKE 'J%';

| emp_id | name       | age | salary  | department_id | hire_date  |
| ------ | ---------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000.0 | 1             | 2020-01-15 |
| 2      | Jane Smith | 34  | 60000.0 | 2             | 2019-07-23 |

---
**Query #7**

    -- 7
    SELECT * FROM Employee
    WHERE name LIKE '%e';

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #8**

    -- 8
    SELECT * FROM Employee
    WHERE name LIKE '%a%';

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #9**

    -- 9
    SELECT * FROM Employee
    WHERE LENGTH(name) = 9;

| emp_id | name      | age | salary  | department_id | hire_date  |
| ------ | --------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown | 45  | 80000.0 | 1             | 2018-02-12 |
| 7      | Eve Black | 40  | 55000.0 | 3             | 2021-08-30 |

---
**Query #10**

    -- 10
    SELECT * FROM Employee
    WHERE name LIKE '_o%';

| emp_id | name      | age | salary  | department_id | hire_date  |
| ------ | --------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe  | 28  | 50000.0 | 1             | 2020-01-15 |
| 3      | Bob Brown | 45  | 80000.0 | 1             | 2018-02-12 |

---
**Query #11**

    -- 11
    SELECT * FROM Employee
    WHERE YEAR(hire_date) = 2020;

| emp_id | name       | age | salary  | department_id | hire_date  |
| ------ | ---------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000.0 | 1             | 2020-01-15 |
| 10     | Hannah Lee | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #12**

    -- 12
    SELECT * FROM Employee
    WHERE MONTH(hire_date) = 1;

| emp_id | name     | age | salary  | department_id | hire_date  |
| ------ | -------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe | 28  | 50000.0 | 1             | 2020-01-15 |

---
**Query #13**

    -- 13
    SELECT * FROM Employee
    WHERE hire_date < '2019-01-01';

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |

---
**Query #14**

    -- 14
    SELECT * FROM Employee
    WHERE hire_date >= '2021-03-01';

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |

---
**Query #15**

    -- 15
    SELECT * FROM Employee
    WHERE hire_date >= CURDATE() - INTERVAL 2 YEAR;

There are no results to be displayed.

---
**Query #16**

    -- 16
    SELECT SUM(salary) AS total_salary
    FROM Employee;

| total_salary |
| ------------ |
| 576000.0     |

---
**Query #17**

    -- 17
    SELECT AVG(salary) AS average_salary
    FROM Employee;

| average_salary |
| -------------- |
| 57600.0        |

---
**Query #18**

    -- 18
    SELECT MIN(salary) AS minimum_salary
    FROM Employee;

| minimum_salary |
| -------------- |
| 45000.0        |

---
**Query #19**

    -- 19
    SELECT department_id, COUNT(*) AS employee_count
    FROM Employee
    GROUP BY department_id;

| department_id | employee_count |
| ------------- | -------------- |
|               | 1              |
| 1             | 3              |
| 2             | 2              |
| 3             | 2              |
| 4             | 2              |

---
**Query #20**

    -- 20
    SELECT department_id, AVG(salary) AS average_salary
    FROM Employee
    GROUP BY department_id;

| department_id | average_salary |
| ------------- | -------------- |
|               | 48000.0        |
| 1             | 65000.0        |
| 2             | 55000.0        |
| 3             | 50000.0        |
| 4             | 61500.0        |

---
**Query #21**

    -- 21
    SELECT department_id, SUM(salary) AS total_salary
    FROM Employee
    GROUP BY department_id;

| department_id | total_salary |
| ------------- | ------------ |
|               | 48000.0      |
| 1             | 195000.0     |
| 2             | 110000.0     |
| 3             | 100000.0     |
| 4             | 123000.0     |

---
**Query #22**

    -- 22
    SELECT department_id, AVG(age) AS average_age
    FROM Employee
    GROUP BY department_id;

| department_id | average_age |
| ------------- | ----------- |
|               | 32.0        |
| 1             | 33.3333     |
| 2             | 31.5        |
| 3             | 32.5        |
| 4             | 34.0        |

---
**Query #23**

    -- 23
    SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
    FROM Employee
    GROUP BY YEAR(hire_date);

| hire_year | employee_count |
| --------- | -------------- |
| 2018      | 2              |
| 2019      | 2              |
| 2020      | 2              |
| 2021      | 3              |
| 2022      | 1              |

---
**Query #24**

    -- 24
    SELECT department_id, MAX(salary) AS highest_salary
    FROM Employee
    GROUP BY department_id;

| department_id | highest_salary |
| ------------- | -------------- |
|               | 48000.0        |
| 1             | 80000.0        |
| 2             | 60000.0        |
| 3             | 55000.0        |
| 4             | 70000.0        |

---
**Query #25**

    -- 25
    SELECT department_id, AVG(salary) AS avg_salary
    FROM Employee
    GROUP BY department_id
    ORDER BY avg_salary DESC
    LIMIT 1;

| department_id | avg_salary |
| ------------- | ---------- |
| 1             | 65000.0    |

---
**Query #26**

    -- 26
    SELECT department_id, COUNT(*) AS employee_count
    FROM Employee
    GROUP BY department_id
    HAVING COUNT(*) > 2;

| department_id | employee_count |
| ------------- | -------------- |
| 1             | 3              |

---
**Query #27**

    -- 27
    SELECT department_id, AVG(salary) AS avg_salary
    FROM Employee
    GROUP BY department_id
    HAVING AVG(salary) > 55000;

| department_id | avg_salary |
| ------------- | ---------- |
| 1             | 65000.0    |
| 4             | 61500.0    |

---
**Query #28**

    -- 28
    SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
    FROM Employee
    GROUP BY YEAR(hire_date)
    HAVING COUNT(*) > 1;

| hire_year | employee_count |
| --------- | -------------- |
| 2018      | 2              |
| 2019      | 2              |
| 2020      | 2              |
| 2021      | 3              |

---
**Query #29**

    -- 29
    SELECT department_id, SUM(salary) AS total_salary
    FROM Employee
    GROUP BY department_id
    HAVING SUM(salary) < 100000;

| department_id | total_salary |
| ------------- | ------------ |
|               | 48000.0      |

---
**Query #30**

    -- 30
    SELECT department_id, MAX(salary) AS max_salary
    FROM Employee
    GROUP BY department_id
    HAVING MAX(salary) > 75000;

| department_id | max_salary |
| ------------- | ---------- |
| 1             | 80000.0    |

---
**Query #31**

    -- 31
    SELECT * FROM Employee
    ORDER BY salary ASC;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |

---
**Query #32**

    -- 32
    SELECT * FROM Employee
    ORDER BY age DESC;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |

---
**Query #33**

    -- 33
    SELECT * FROM Employee
    ORDER BY hire_date ASC;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |

---
**Query #34**

    -- 34
    SELECT * FROM Employee
    ORDER BY department_id, salary;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |

---
**Query #35**

    -- 35
    SELECT department_id, SUM(salary) AS total_salary
    FROM Employee
    GROUP BY department_id
    ORDER BY total_salary;

| department_id | total_salary |
| ------------- | ------------ |
|               | 48000.0      |
| 3             | 100000.0     |
| 2             | 110000.0     |
| 4             | 123000.0     |
| 1             | 195000.0     |

---
**Query #36**

    -- 36
    SELECT e.name AS employee_name, d.name AS department_name
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id;

| employee_name | department_name |
| ------------- | --------------- |
| John Doe      | IT              |
| Bob Brown     | IT              |
| Grace Kelly   | IT              |
| Jane Smith    | HR              |
| Charlie P.    | HR              |
| Alice Blue    | Finance         |
| Eve Black     | Finance         |
| David Green   | Marketing       |
| Hannah Lee    | Marketing       |

---
**Query #37**

    -- 37
    SELECT p.name AS project_name, d.name AS department_name
    FROM Project p
    JOIN Department d
    ON p.department_id = d.department_id;

| project_name    | department_name |
| --------------- | --------------- |
| Project Alpha   | IT              |
| Project Gamma   | IT              |
| Project Theta   | IT              |
| Project Beta    | HR              |
| Project Delta   | Finance         |
| Project Eta     | Finance         |
| Project Epsilon | Marketing       |
| Project Zeta    | Marketing       |

---
**Query #38**

    -- 38
    SELECT e.name AS employee_name, p.name AS project_name
    FROM Employee e
    JOIN Project p
    ON e.department_id = p.department_id;

| employee_name | project_name    |
| ------------- | --------------- |
| John Doe      | Project Alpha   |
| Bob Brown     | Project Alpha   |
| Grace Kelly   | Project Alpha   |
| Jane Smith    | Project Beta    |
| Charlie P.    | Project Beta    |
| John Doe      | Project Gamma   |
| Bob Brown     | Project Gamma   |
| Grace Kelly   | Project Gamma   |
| Alice Blue    | Project Delta   |
| Eve Black     | Project Delta   |
| David Green   | Project Epsilon |
| Hannah Lee    | Project Epsilon |
| David Green   | Project Zeta    |
| Hannah Lee    | Project Zeta    |
| Alice Blue    | Project Eta     |
| Eve Black     | Project Eta     |
| John Doe      | Project Theta   |
| Bob Brown     | Project Theta   |
| Grace Kelly   | Project Theta   |

---
**Query #39**

    -- 39
    SELECT e.name AS employee_name, d.name AS department_name
    FROM Employee e
    LEFT JOIN Department d
    ON e.department_id = d.department_id;

| employee_name | department_name |
| ------------- | --------------- |
| John Doe      | IT              |
| Bob Brown     | IT              |
| Grace Kelly   | IT              |
| Jane Smith    | HR              |
| Charlie P.    | HR              |
| Alice Blue    | Finance         |
| Eve Black     | Finance         |
| David Green   | Marketing       |
| Hannah Lee    | Marketing       |
| Frank White   |                 |

---
**Query #40**

    -- 40
    SELECT d.name AS department_name, e.name AS employee_name
    FROM Department d
    LEFT JOIN Employee e
    ON d.department_id = e.department_id;

| department_name | employee_name |
| --------------- | ------------- |
| IT              | John Doe      |
| IT              | Bob Brown     |
| IT              | Grace Kelly   |
| HR              | Jane Smith    |
| HR              | Charlie P.    |
| Finance         | Alice Blue    |
| Finance         | Eve Black     |
| Marketing       | David Green   |
| Marketing       | Hannah Lee    |

---

[View on DB Fiddle](https://www.db-fiddle.com/)
