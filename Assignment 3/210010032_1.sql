--PART 1
--Q1
select pname from professor natural join department where numphds<50;
--Q2
select sname from student where gpa=(select max(gpa) from student);
--Q3
select cno, avg(gpa) from course natural join enroll natural join student where dname='Computer Sciences' group by cno;
--Q4
select sid, sname from enroll natural join student group by sid,sname having count(*)=(select max(total_course) from (select count(*) as total_course from enroll group by sid) count);
--Q5
select dname from professor group by dname having count(*)=(select max(prof) from (select count(*) as prof from professor group by dname) count);
--Q6
select sname,major.dname from course natural join enroll natural join student inner join major on major.sid=student.sid where cname='Thermodynamics';
--Q7
select dname from department where dname not in (select major.dname from enroll natural join course inner join major on enroll.sid=major.sid where cname='Compiler Construction');
--Q8
select distinct(sname) from enroll natural join student where sid in (select sid from enroll group by sid,dname having count(*) >=1 and dname='Civil Engineering') and sid in (select sid from enroll group by sid,dname having count(*) <=2 and dname='Mathematics');
--Q9
select distinct(major.dname) from enroll join major on enroll.sid=major.sid where exists (select 1 from enroll where dname=major.dname and grade<1.5);
--Q10
select sid, sname, grade from enroll natural join student where dname='Civil Engineering';

--PART 2
--Q1 (ran on terminal): createdb salesdb
--Q2 \i tableSales.sql
--Q3 \i dataSales.sql
--Q4
select cust_name from customer where grade=2;
--Q5
select ord_num, ord_date, ord_description from orders order by ord_date;
--Q6
select ord_num, ord_date, ord_amount from orders where ord_amount>=800 order by ord_amount desc;
--Q7
select * from customer order by working_area, cust_name desc;
--Q8
select cust_name from customer where cust_name like 'S%';
--Q9
select ord_num from orders where extract(month from ord_date)=3 and extract(year from ord_date)=2008;
--Q10
select ord_amount*1.1 as new_ord_amount from orders;
--Q11
select ord_num, ord_amount - advance_amount as balance_amount from orders where ord_amount between 2000 and 4000;
--Q12 Assumed to include orders by 'C00022'
select ord_num, cust_code, ord_amount from orders where ord_amount in (select ord_amount from orders natural join customer where cust_code='C00022');
--Q13
select agent_name, agent_code from agents where commission > all(select commission from agents where working_area='Bangalore');
--Q14
select agent_name from agents where commission > some(select commission from agents where working_area='Bangalore');
--Q15
select agent_code from agents where agent_code in (select agent_code from orders);
--Q16
select cust_name from customer where cust_code not in (select cust_code from orders);
--Q17
select agent_code from agents natural join orders where ord_amount>=800;
--Q18
select distinct(agent_code) from agents natural join orders where ord_amount>=800;
--Q19
select cust_name, cust_code from customer where cust_city='Paris' or cust_city='New York' or cust_city='Bangalore';
--Q20
select agent_name from agents natural join orders where ord_amount=1000;
--Q21
select sum(ord_amount) as total_order_amount, avg(ord_amount) as average_order_amount, min(ord_amount) as min_order, max(ord_amount) as max_order from orders;
--Q22
select count(*) as number_of_customers_in_New_York from customer group by cust_city having cust_city='New York';
--Q23
select count(distinct ord_amount) as Distinct_Order_Amounts from orders;
--Q24
select agent_name, agent_code from agents natural join orders group by agent_code having count(*)>=2;
--Q25
select working_area,count(*) as agent_present_in_each_working_area from agents group by working_area;
--Q26
select agent_name from agents natural join orders group by agent_code having count(ord_num)>=2;
--Q27
select agent_name,avg(ord_amount) from orders natural join agents group by agent_code,agent_name;
--Q28 (multiple queries because of foreign key constraint in orders and customer table)
delete from orders where agent_code in (select agent_code from agents where working_area='Bangalore');
delete from customer where agent_code in (select agent_code from agents where working_area='Bangalore');
delete from agents where working_area='Bangalore';
--Q29 (multiple queries: creating a new column and adding an entry for customer C00013)
alter table customer add Address varchar(50) default null;
update customer set address='Address of C00013' where cust_code='C00013';
--Q30
alter table agents drop country;
--Q31
truncate table orders;
--Q32
drop table customer cascade;