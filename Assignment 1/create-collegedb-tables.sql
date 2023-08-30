CREATE TABLE student (
	sid INT NOT NULL PRIMARY KEY,
	sname VARCHAR(50),
	gender VARCHAR(1),
	gpa REAL
	);
	
CREATE TABLE department (
	dname VARCHAR(50) PRIMARY KEY,
	numphds INT NOT NULL
	);
	
CREATE TABLE professor (
	pname VARCHAR(50) PRIMARY KEY,
	dname VARCHAR(50) REFERENCES department(dname)
	);
	
CREATE TABLE course (
	cno INT NOT NULL,
	cname VARCHAR(50),
	dname VARCHAR(50) REFERENCES department(dname),
	PRIMARY KEY (cno, dname)
	);

CREATE TABLE major (
	dname VARCHAR(50) REFERENCES department(dname),
	sid INT NOT NULL REFERENCES student(sid)
	);
	
CREATE TABLE enroll (
	sid INT REFERENCES student(sid),
	grade REAL NOT NULL,
	dname VARCHAR(50) ,
	cno INT NOT NULL, foreign key (cno,dname) REFERENCES course(cno, dname)
	);