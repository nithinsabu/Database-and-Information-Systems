--Q1
select act_fname as first_name, act_lname as last_name from actor union select dir_fname as first_name, dir_lname as last_name from director;
--Q2
select rev_name,mov_title,rev_stars from reviewer , rating,movie where reviewer.rev_id=rating.rev_id and rating.mov_id=movie.mov_id and rev_stars>=7;
--Q3
SELECT mov_title FROM movie  LEFT JOIN rating  ON movie.mov_id = rating.mov_id WHERE  rating.mov_id IS NULL;
--Q4
select mov_title, mov_year,mov_duration,mov_rel_date,mov_rel_country from movie where mov_rel_country!='USA';
--Q5
select rev_name from reviewer, rating where rating.rev_id=reviewer.rev_id and rev_stars is null; 
--Q6
select rev_name,mov_title,rev_stars from reviewer, movie, rating where reviewer.rev_id=rating.rev_id and rating.mov_id=movie.mov_id and rev_stars is not null and rev_name is not null;
--Q7
select re.rev_name, m.mov_title from reviewer as re, rating as ra, movie as m where 1< (select count(*) from rating as q where q.rev_id=re.rev_id group by rev_id) and ra.mov_id=m.mov_id and re.rev_id=ra.rev_id;
--Q8
select distinct(m.mov_title) from movie as m, rating as ra, reviewer as re where not exists (select * from reviewer as ree, rating as raa, movie as mm where raa.rev_id=ree.rev_id and m.mov_id=raa.mov_id and ree.rev_name='Paul Monks' and m.mov_title=mm.mov_title);
--Q9
select re.rev_name, m.mov_title, ra.rev_stars from reviewer as re, movie as m, rating as ra where ra.rev_stars= (select min(rev_stars) from rating) and m.mov_id=ra.mov_id and ra.rev_id=re.rev_id;
--Q10
select m.mov_title from movie as m, director as d, movie_direction as md where md.dir_id=d.dir_id and md.mov_id=m.mov_id and d.dir_fname='James' and d.dir_lname='Cameron';
--Q11
select re.rev_name from reviewer as re, rating as ra where re.rev_id=ra.rev_id and ra.rev_stars is null;
--Q12
select a.act_fname,a.act_lname from actor as a, movie_cast as mc, movie as m where a.act_id=mc.act_id and mc.mov_id=m.mov_id and (mov_year >=2000 or mov_year <=1990);
--Q13
select d.dir_fname, d.dir_lname, g.gen_title,count(*) from director as d, movie_direction as md, movie_genres as mg, genres as g where d.dir_id=md.dir_id and md.mov_id=mg.mov_id and mg.gen_id=g.gen_id group by d.dir_fname,d.dir_lname, g.gen_title order by d.dir_fname,d.dir_lname;
--Q14
select mov_title, mov_year,gen_title, dir_fname,dir_lname from movie natural join director natural join  movie_direction natural join movie_genres natural join genres;
--Q15
select gen_title, avg(mov_duration),count(*) from movie natural join movie_genres natural join genres group by gen_id,gen_title;
--Q16
select mov_title, mov_year, dir_fname,dir_lname,act_fname, act_lname, role from movie natural join director natural join actor natural join movie_cast natural join movie_direction where mov_duration=(select min(mov_duration) from movie);
--Q17
select rev_name, mov_title, rev_stars from reviewer natural join rating natural join movie;
--Q18
select mov_title, dir_fname, dir_lname, rev_stars from movie natural join director natural join rating natural join movie_direction where rev_stars is not null;
--Q19
select act_fname, act_lname, mov_title, role from actor natural join movie natural join movie_cast natural join director natural join movie_direction where (act_fname, act_lname)=(dir_fname,dir_lname);
--Q20
select act_fname, act_lname from actor natural join movie_cast natural join movie where mov_title='Chinatown';
--Q21
select mov_title from movie natural join movie_cast natural join actor where act_fname='Harrison' and act_lname='Ford';
--Q22
select mov_title, mov_year, rev_stars from movie natural join rating natural join movie_genres natural join genres where gen_title='Mystery' and rev_stars=(select max(rev_stars) from rating natural join movie natural join movie_genres natural join genres where gen_title='Mystery' group by gen_id);
--Q23
select mov_title, act_fname, act_lname, mov_year, role, gen_title, dir_fname, dir_lname, mov_rel_date, rev_stars from movie natural join actor natural join director natural join movie_direction natural join movie_cast natural join movie_genres natural join genres natural join rating where act_gender='F';
--Q24
select act_fname, act_lname from actor natural join movie natural join movie_cast where mov_year in (select mov_year from movie natural join movie_direction natural join director where (dir_fname,dir_lname)=('Stanley','Kubrick'));