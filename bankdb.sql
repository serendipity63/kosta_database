CREATE TABLE MEMBER(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100),
	PASSWORD VARCHAR(100),
	email VARCHAR(100),
	address VARCHAR(100));
	
DROP TABLE account;
CREATE TABLE account(
id VARCHAR(100) PRIMARY KEY,
NAME VARCHAR(100),
balance INT,
TYPE VARCHAR(100),
grade VARCHAR(100));

DROP TABLE board;

CREATE TABLE board(
	num INT AUTO_INCREMENT PRIMARY KEY,
	SUBJECT VARCHAR(255),
	content VARCHAR(255),
	writedate DATE,
	fileurl VARCHAR(255),
	writer VARCHAR(100) REFERENCES member(id)
	
);	

SELECT CURDATE();

ALTER TABLE board ADD viewcount INT DEFAULT 0;
ALTER TABLE board ADD likecount INT DEFAULT 0;

SELECT * FROM board WHERE SUBJECT LIKE '%제목%';
SELECT * FROM board WHERE content LIKE '%내용%';

SELECT * FROM board WHERE writer LIKE '%lee%';

CREATE TABLE boardlike(
	num INT AUTO_INCREMENT PRIMARY KEY,
	member_id VARCHAR(100) REFERENCES member(id),
	board_num INT REFERENCES board(num)
);
DROP TABLE map;
CREATE TABLE map(
num INT AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(255),
draw MEDIUMTEXT);

DROP TABLE patient;

CREATE TABLE patient(
 pidnum VARCHAR(100) PRIMARY KEY,
 pemail VARCHAR(100) UNIQUE KEY,
 ppassword VARCHAR(100),
 pname VARCHAR(100),
 ptel VARCHAR(100),
 proadaddress VARCHAR(100),
 ppostcode VARCHAR(100),
 pdetailaddress VARCHAR(100)
 );

CREATE TABLE hospital(
hname VARCHAR(100), 
comnum VARCHAR(100) PRIMARY KEY, 
htel VARCHAR(100),
department VARCHAR(100),
hpassword VARCHAR(100),
lunch VARCHAR(100),
clinic VARCHAR(100),
hroad VARCHAR(100),
hdetail VARCHAR(100),
hpostcode VARCHAR(100)
);	nearbydocnearbydocnearbydoc