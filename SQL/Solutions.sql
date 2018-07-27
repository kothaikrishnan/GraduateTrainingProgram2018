-- ProblemSet1, July 25 2018
-- Submission by <kothai.krishnan@accenture.com> 

/*Select the Employee with the top three salaries*/

select name,salary from employee where salary>=
(select max(salary) from employee where salary<
 (select max(salary) from employee where salary<
  (select max(salary) from employee)))order by salary desc;

record count-3

/*Select the Employee with the least salary*/

select e_id,name,salary from employee where salary in(select min(salary) as salary from employee);

record count-1

/*Select the Employee who does not have a manager in the department table*/

select e_id,name from employee where managerid not in(select e.e_id from employee e inner join dept d on e.name=d.depmanager);

record count-4

/*Select the Employee who is also a Manager*/

select e.e_id,e.name,e.managerid from employee e inner join dept d on e.name=d.depmanager;

record count-4

/*Select the Empolyee who is a Manager and has least salary*/

select e_id,name,min(salary) from employee where salary in(select e.salary from employee e inner join dept d on e.name=d.depmanager);

record count-1

/*Select the total number of Employees in Communications departments*/

select count(e.e_id) from employee e inner join dept d on e.dept_id=d.dept_id and d.depname='communications';

record count-1

/*Select the Employee in Finance Department who has the top salary*/

select e.e_id,e.name,e.dept_id,max(e.salary) from employee e inner join dept d on e.dept_id=d.dept_id and d.depname='finance';

record count-1

/*Select the Employee in product depatment who has the least salary*/

select e.e_id,e.name,e.dept_id,min(e.salary) from employee e inner join dept d on e.dept_id=d.dept_id and d.depname='product';

record count-1

/*Select the count of Empolyees in Health with maximum salary*/

select count(salary) from employee where salary in 
(select max(e.salary) from employee e inner join dept d on e.dept_id=d.dept_id and d.depname='health');
 
 record count-1
 
/*Select the Employees who report to Natasha Stevens*/
 
select e_id,name,managerid from employee where managerid=
(select e.e_id from employee e inner join dept d on e.name=d.depmanager and d.depmanager='natasha stevens' );
 
 record count-2
 
/*Display the Employee name,Employee count,Dep name,Dept manager in the Health department*/
  
  select count(e.e_id),d.depname,d.depmanager from employee e inner join dept d on e.dept_id=d.dept_id and d.depname='health';
  
  record count-6
  
/*Display the Department id,Employee ids and Manager ids for the Communications department*/
   
   select e.dept_id,e.e_id,e.managerid from employee e inner join dept d on e.dept_id=d.dept_id and d.depname='communications';
   
   record count-6
   
/*Select the Average Expenses for Each dept with Dept id and Dept name*/
 
 select avg(e.salary),e.dept_id,d.depname from employee e inner join dept d on e.dept_id=d.dept_id group by d.depname order by e.dept_id;
 
 record count-5
 
/*Select the total expense for the department finance*/
 
 select sum(e.salary) from employee e inner join dept d on e.dept_id=d.dept_id and d.depname='finance';
 
 record count-1
 
 /*Select the department which spends the least with Dept id and Dept manager name*/

select dept_id,depmanager,min(salary) from
(select d.dept_id,d.depmanager,sum(e.salary)as salary from dept d inner join employee e on d.dept_id=e.dept_id group by d.dept_id);

record count-1

/*Select the count of Employees in each department*/
 
 select count(e_id),dept_id from employee group by dept_id;
 
 record count-5
 
 /*Select the count of Employees in each department having salary <10000*/
  
  select count(e_id),dept_id from employee group by dept_id having salary<10000;
  
  record count-0
  
 /*Select the total number of Employees in Dept id D04*/
   
   select count(e_id) from employee where dept_id='D04';
   
   record count-2
   
/*Select all department details of the Department with Maximum Employees*/
  
   select dept_id,depmanager,max(e_id) from
   (select d.dept_id,d.depmanager,count(e.e_id)as e_id from dept d inner join employee e on d.dept_id=e.dept_id group by d.dept_id);
  
  record count-1
  
  /*Select the Employees who has Tim Cook as their manager*/
  
  select e_id,name,salary from
  (select e.e_id as e_id,e.name as name,e.salary as salary from employee e inner join dept d on e.dept_id=d.dept_id and d.depmanager='tim cook');   
  
  
record count-0
