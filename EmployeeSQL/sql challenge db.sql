--Creating tables and all that jazz

create table titles (
    title_id varchar not null,
    title varchar not null,
    primary key (title_id)
   ); 
---
create table employees (
    employee_no int not null,
    employee_title_id varchar not null,
    birth_date date not null,
    first_name varchar not null,
    last_name varchar not null,
    sex varchar not null,
    hire_date date not null,
	primary key (employee_no),
    foreign key (employee_title_id) references titles (title_id)
    );	
---	
create table departments (
    depart_no varchar not null,
    depart_name varchar not null,
    primary key (depart_no)
    );	
---
create table depart_manager (
    depart_no varchar not null,
    employee_no int not null,
	primary key (employee_no, depart_no),
    foreign key (employee_no) references employees (employee_no),
    foreign key (depart_no) references departments (depart_no)
    );
---
create table depart_employee (
    employee_no int not null,
    depart_no varchar not null,
	primary key (employee_no, depart_no),
    foreign key (employee_no) references employees (employee_no),
    foreign key (depart_no) references departments (depart_no)
    );
--- 
create table salaries (
    employee_no int not null,
    salary int not null,
	primary key (employee_no),
    foreign key (employee_no) references employees (employee_no)
    );

-------------------------------------  

---1. List the employee number, last name, first name, sex, and salary of each employee.
select emp.employee_no, emp.last_name, emp.first_name, emp.sex, sal.salary
from employees emp
join salaries sal on emp.employee_no = sal.employee_no;

---2. List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date 
from employees
where extract(year from hire_date) = 1986;

---3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
select emp.employee_no, emp.last_name, emp.first_name, deparman.depart_no, depar.depart_name
from employees emp
join depart_manager deparman on emp.employee_no = deparman.employee_no
join departments depar on deparman.depart_no = depar.depart_no

---4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select emp.employee_no, emp.last_name, emp.first_name, deparemp.depart_no, depar.depart_name
from employees emp
join depart_employee deparemp on emp.employee_no = deparemp.employee_no
join departments depar on deparemp.depart_no = depar.depart_no

---5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name, last_name,  sex
from employees
where first_name = 'Hercules'
and last_name like 'B%';

---6. List each employee in the Sales department, including their employee number, last name, and first name.
select emp.employee_no, emp.last_name, emp.first_name, depar.depart_name
from employees emp
join depart_employee deparemp on emp.employee_no = deparemp.employee_no
join departments depar on deparemp.depart_no = depar.depart_no
where depar.depart_name like 'Sales'

---7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select emp.employee_no, emp.last_name, emp.first_name, depar.depart_name
from employees emp
join depart_employee deparemp on emp.employee_no = deparemp.employee_no
join departments depar on deparemp.depart_no = depar.depart_no
where depar.depart_name in ('Sales', 'Development')

---8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name, count(*) as name_count
from employees
group by last_name
order by name_count desc







