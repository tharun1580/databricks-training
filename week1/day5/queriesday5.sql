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

    -- 61
    SELECT e.name, e.salary
    FROM Employee e
    WHERE e.salary >
    (
        SELECT AVG(e2.salary)
        FROM Employee e2
        WHERE e2.department_id = e.department_id
    );

| name        | salary  |
| ----------- | ------- |
| Jane Smith  | 60000.0 |
| Bob Brown   | 80000.0 |
| David Green | 70000.0 |
| Eve Black   | 55000.0 |

---
**Query #2**

    -- 62
    SELECT name
    FROM Employee
    WHERE hire_date =
    (
        SELECT hire_date
        FROM Employee
        ORDER BY age DESC
        LIMIT 1
    );

| name      |
| --------- |
| Bob Brown |

---
**Query #3**

    -- 63
    SELECT d.name,
           COUNT(p.project_id) AS total_projects
    FROM Department d
    LEFT JOIN Project p
    ON d.department_id = p.department_id
    GROUP BY d.name
    ORDER BY total_projects DESC;

| name      | total_projects |
| --------- | -------------- |
| IT        | 3              |
| Marketing | 2              |
| Finance   | 2              |
| HR        | 1              |

---
**Query #4**

    -- 64
    SELECT d.name AS department_name,
           e.name AS employee_name,
           e.salary
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    WHERE e.salary =
    (
        SELECT MAX(e2.salary)
        FROM Employee e2
        WHERE e2.department_id = e.department_id
    );

| department_name | employee_name | salary  |
| --------------- | ------------- | ------- |
| HR              | Jane Smith    | 60000.0 |
| IT              | Bob Brown     | 80000.0 |
| Marketing       | David Green   | 70000.0 |
| Finance         | Eve Black     | 55000.0 |

---
**Query #5**

    -- 65
    SELECT e.name, e.salary, e.age
    FROM Employee e
    WHERE e.age >
    (
        SELECT AVG(e2.age)
        FROM Employee e2
        WHERE e2.department_id = e.department_id
    );

| name        | salary  | age |
| ----------- | ------- | --- |
| Jane Smith  | 60000.0 | 34  |
| Bob Brown   | 80000.0 | 45  |
| David Green | 70000.0 | 38  |
| Eve Black   | 55000.0 | 40  |

---

[View on DB Fiddle](https://www.db-fiddle.com/)