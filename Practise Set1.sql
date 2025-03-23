create database PractiseDB;
use PractiseDB;

--Creating Tables
create table Employees(emp_id int identity(1,1) primary key,
name varchar(25) not null,
age int check (age>18),
department varchar(50),
salary decimal(10,2),
email varchar(50) unique);

create table departments(dept_id int identity(1,1) primary key,
dept_name varchar(50) unique);

-- Relationship table
create table employee_department(emp_id int foreign key references Employees(emp_id),
dept_id int foreign key references departments(dept_id));

--Inserting Values
-- Employee Table
insert into Employees values ('Alice',30,'IT',70000,'alice@example.com'),
('Evan',32,'HR',65000,'evan@example.com'),
('Bob',25,'HR',50000,'bob@example.com'),
('Charlie',28,'FINANCE',60000,'charlie@example.com'),
('David',35,'IT',80000,'david@example.com');


--Department Table
insert into departments values ('IT'),('HR'),('Finance'),('Marketing');

--Employee_department Table
insert into employee_department values(1,1),(2,2),(3,2),(4,4),(5,1);

-- Starting Point
select * from Employees;
select * from departments;
select * from employee_department;

--SELECT
select name,department,salary from Employees where salary>60000 order by salary desc;

--Update
update Employees set salary = 70000 where name = 'Alice';

--Deleting from foriegn key constraint(nested query)
delete from employee_department where emp_id = (select emp_id from Employees where name ='Evan');
delete from Employees where name ='Evan';

--Dropping and altering constraint
alter table Employees drop constraint [CK__Employees__age__25869641];

alter table employee_department add constraint [CK__Employees__age__25869642] 
foreign key (emp_id) references Employees(emp_id) on delete cascade;

delete from Employees where name ='Charlie';

--Groupby , Having Clause
select department, SUM(salary) as 'Total Expense' from Employees 
group by department;

select department,  Count(*) as 'Employee Count' from Employees
group by department having count(*)>1;

--Applying Joins
select e.name , d.dept_name 
from Employees e 
join employee_department ed on e.emp_id = ed.emp_id
left join departments d on ed.emp_id = d.dept_id;


--Indexing 
create index index_department on Employees(department);

--Creating a View
create view HighSalaryEmployees as 
select name,salary from Employees where salary > 60000;

select * from HighSalaryEmployees;

--Using Transaction(Commit, Rollback)
begin transaction;
update Employees set salary = salary - 5000 where department = 'IT';

-- Saving Transaction (Cannot Rollback once Commit)
save transaction savepoint1;

select * from Employees;

--Rollback 
Rollback transaction;
commit transaction;
select * from Employees;


-- Using Windows Function (Rank, Rownumber, lead, lag)
select name,salary,
rank() over (order by salary desc) as ranking,
row_number() over (order by salary) as row_num
from Employees;

select name,salary,
lag(salary,1) over (order by salary) as previous_salary,
lead(salary,1) over (order by salary) as next_salary
from Employees;

--Constraints and Integrity
alter table Employees add constraint check_salary check (salary > 30000);

--Constraint Fails
insert into Employees values ('Charlie',30,'IT',25000,'charlie@example.com');

alter table Employees drop constraint check_salary;

--Union and Union ALL

select name from Employees where department = 'IT'
UNION
select name from Employees where department = 'HR'

select name from Employees where department = 'IT'
UNION ALL
select name from Employees where department = 'HR'

--Finding Second Highest Salary
select max(salary) from Employees;
select max(salary) from Employees where salary<(select max(salary) from Employees);

-- Finding second lowest salary
select min(salary) from Employees;
select min(salary) from Employees where salary>(select min(salary) from Employees);


--Cumalative Sum Query
select name, salary,
sum(salary) over (order by salary) as cumalative_salary
from Employees;

--retention query
select emp_id, count(*) as repeat_order
from employee_department
group by emp_id having count(*)>0;

