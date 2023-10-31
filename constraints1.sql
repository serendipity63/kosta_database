-- constraint : 제약조건
-- not null, unique, primary key, foreign key, check
CREATE TABLE temp(
	id INT PRIMARY KEY, -- 동일한 데이터 허용하지 않고, null값도 허용하지 않는다.(unique & not null)
	NAME VARCHAR(20) NOT NULL -- null값 허용하지 않는다.	
);

INSERT INTO temp VALUES(1, 'jang'); -- PRIMARY KEY 는 null도 허용하지 않는다
INSERT INTO temp VALUES(1, 'jung');
INSERT INTO temp VALUES(1, 'gong'); -- PRIMARY KEY error
INSERT INTO temp VALUES(2, 'null'); -- name null error

CREATE TABLE temp2(
	email VARCHAR(50) UNIQUE 
);

INSERT INTO temp2 VALUES(NULL); -- UNIQUE는 null 허용한다.
INSERT INTO temp2 VALUES('kosta@kosta.com'); -- null이 아닌 중복값은 허요;ㅇ하지 않는다.

CREATE TABLE temp3(
	NAME VARCHAR(20) NOT NULL,
	age INT DEFAULT 1 CHECK(age>0) -- 값의 범위 제한
);

INSERT INTO temp3 (NAME) VALUES('hong');
INSERT INTO temp3 VALUES('kang',-1); -- age 범위 오류

CREATE TABLE USER(
	id VARCHAR(20) PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL
);

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50),
	content VARCHAR(1000),
	writer VARCHAR(20) REFERENCES user(id)
);

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50),
	content VARCHAR(1000),
	writer VARCHAR(20)
);

INSERT INTO article (title,content) VALUES('제목','내용');
INSERT INTO article (title,content,writer) VALUES('제목','내용','hong'); -- error

INSERT INTO user VALUES('hong','홍길동');
INSERT INTO article (title,content,writer) VALUES('제목','내용','hong'); -- success

DELETE FROM user WHERE id='hong'; -- error: article 테이블에서 참조하고 있어서 삭제할 수 없다.
UPDATE user set id= 'kong' WHERE id= 'hong'; -- error: article 테이블에서 id를 참조하고 id 변경 불가
UPDATE user set name= '공길동' WHERE id= 'hong'; -- success: 참조되는 컬럼이 아닌 컬럼은 변경 가능

INSERT INTO user VALUES('song', '송길동');
DELETE FROM user WHERE id='song'; -- success: 참조하고 있지 않은 데이터는 삭제 가능

ALTER TABLE article DROP FOREIGN KEY article_ibfk_1; -- foreign key 삭제 가능
ALTER TABLE article ADD CONSTRAINT ARTICLE_USER_FK foreign KEY(writer) REFERENCES user(ID);
INSERT into article (title, content, writer) VALUES ('송제목','송내용','song');
ALTER TABLE article DROP CONSTRAINT ARTICLE_USER_FK;

DELETE FROM article WHERE writer='song';
ALTER TABLE article ADD CONSTRAINT ARTICLE_USER_FK foreign KEY(writer) REFERENCES user(ID) ON DELETE CASCADE;
-- on cascade: 참조하는 애까지 다 삭제됨
DELETE FROM user WHERE id='hong';





