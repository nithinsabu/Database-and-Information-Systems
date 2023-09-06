--Q1
select max(enrollments), min(enrollments) from (select count(id) as enrollments from takes group by course_id,sec_id,semester,year) count_table;
--Q2
select course_id,sec_id,semester,year from takes group by  course_id,sec_id,semester,year having count(*)=(select max(enrollments) from (select count(id) as enrollments,course_id from takes group by course_id,sec_id,semester,year) count_table);
--Q3(a)
select max((select count(id) from takes where takes.course_id=section.course_id and takes.sec_id=section.sec_id and takes.semester=section.semester and takes.year=section.year)), min((select count(id) from takes where takes.course_id=section.course_id and takes.sec_id=section.sec_id and takes.semester=section.semester and takes.year=section.year)) from section; 
--Q3(b)
select max(enrollments), min(enrollments) from (select count(id) as enrollments from section left join takes on section.course_id=takes.course_id and section.sec_id=takes.sec_id and section.semester=takes.semester and section.year=takes.year group by section.course_id,section.sec_id,section.semester,section.year) count_table;
--Q4
select * from course where course_id like 'CS-1%';
--Q5(a)
select distinct i.id, i.name from instructor i where not exists (select course_id from course where course_id like 'CS-1%' except select course_id from teaches where teaches.id=i.id);
--Q5(b)
select i.id, i.name from instructor i join (select t.id, count(distinct t.course_id) as countc from teaches t where t.course_id like 'CS-1%' group by t.id) as cs1_inst on i.id=cs1_inst.id join (select count(distinct course_id) as countcs from course where course_id like 'CS-1%') cs1 on cs1.countcs=cs1_inst.countc;
--Q6 //(instructor not inserted if their id was already present in student table)
insert into student (select id,name,dept_name,0 from instructor where instructor.id not in (select id from student));
--Q7
delete from student where (id,name,dept_name) in (select id,name,dept_name from instructor) and tot_cred=0;
--Q8
update instructor i set salary=10000*(select count(*) from teaches group by id having teaches.id=i.id) where salary >29000;
--Q9
create view fail_grades as (select * from takes where grade='F');
--Q10
select id from fail_grades group by id having count(*) >=2;
--Q11
create table grade_table(grade varchar(1), point int);
--Q12
select s.id,s.name,sum(g.point*c.credits)/sum(c.credits) cgpa from student s  join takes on s.id=takes.id join course c on c.course_id=takes.course_id join grade_table g on g.grade=takes.grade group by s.id;
--Q13
select course_id,sec_id,semester,year,building,room_number,time_slot_id from section where (building,room_number,time_slot_id) in (select building,room_number,time_slot_id from section group by (building,room_number,time_slot_id) having count(*)>1);
--Q14
create view faculty as select id,name, dept_name from instructor;
--Q15
create view CSinstructors as select * from instructor where dept_name='Comp. Sci.';
--Q16
insert into faculty values('12102','Planck','Physics');
insert into CSinstructors values('12322','Neils','Physics');
--both were inserted without any error
--Q17
--(ran on terminal) createuser -U postgres newuser;
alter role newuser with password '123456';
grant select on table student to newuser;
