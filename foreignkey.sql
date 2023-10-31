DROP TABLE article;
DROP TABLE user;

CREATE TABLE USER(
	id VARCHAR(100),
	NAME VARCHAR(100)
);

-- auto_increment : 자동 증가< primary key 여야만 함
CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100)
);	
-- 외부에서 제약조건 생성
ALTER TABLE user ADD CONSTRAINT USER_PK PRIMARY KEY(id); 
ALTER TABLE article ADD CONSTRAINT Article_USER_FK FOREIGN KEY(writer) REFERENCES user(id);
-- 아티클에 외래키 들어감 제약조건 객체를 만듦 writer은 id를 참조함
-- primary key는 null 불가 but forein key is ok
INSERT into article VALUES(NULL, '제목','내용','hong');  -- error: 'hong'이 user 테이블에 없어서 (외래키 제약 조건 위배)
INSERT into article VALUES(NULL, '제목','내용',NULL); -- 단, null 값은 가능

INSERT into user VALUES('hong', '홍길동');
INSERT into article VALUES(NULL, '제목','내용','hong');  -- success: user에 'hong'을 넣어서 참조 가능 

DELETE FROM user WHERE id='hong'; -- error: hong 데이터를 article 테이블에서 참조하고 잇어서 삭제 불가
UPDATE user SET id='kong' WHERE id='hong'; -- error: hong 데이터를 article 테이블에서 참조하고 잇어서 변경  불가-- hong을 참조화고 있으니까 변경도 불가
UPDATE user SET NAME = '홍홍' WHERE id='hong'; -- success id가 홍인 애를 이름을 홍홍으로 바꾼다

-- 제약조건 삭제
ALTER TABLE article DROP CONSTRAINT Article_USER_FK; -- 외래키 제약 조건 삭제
INSERT INTO article VALUES(NULL, '송제목', '송내용','song'); -- success: 외래키 제약조건을 풀어서

ALTER TABLE article ADD CONSTRAINT Article_USER_FK FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE; -- 제약조건을 위배하는 데이터가 있어서(song)
-- 이거 애매함
UPDATE article SET writer='hong' WHERE writer<>'hong'; -- hong이 아니면 hong으로 바꿈

ALTER TABLE article ADD CONSTRAINT Article_USER_FK FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE; -- 성공
DELETE FROM user WHERE id='hong'; -- success : on delete cascade에 의해 참조하는 데이터도 같이 삭제 (article)

--------------------------------------------------------------
-- 제약조건 약식
--------------------------------------------------------------

CREATE TABLE USER(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL 
);

CREATE TABLE USER(
	id VARCHAR(100),
	NAME VARCHAR(100) NOT NULL,
	PRIMARY KEY(id)
);

-- auto_increment : 자동 증가< primary key 여야만 함
CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100) not NULL REFERENCES user(id)
);
CREATE TABLE article(
	num INT AUTO_INCREMENT,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100) NOT null,
	PRIMARY KEY(num),
	FOREIGN KEY(writer) REFERENCES user(id)
);

-- 외래키는 column 중 다른 테이블의 기본키를 참조하는 것

CREATE TABLE dept2(
DCODE VARCHAR(6) PRIMARY KEY,
DNAME VARCHAR(30) NOT NULL,
PDEPT VARCHAR(16),
AREA VARCHAR(26)
);


CREATE TABLE tcons(
	NO INT  -- PRIMARY KEY,
	NAME VARCHAR(20), -- NOT NULL, 
	jumin VARCHAR(13), -- not null UNIQUE,
	AREA INT, -- CHECK 1,2,3,4,
	deptno VARCHAR(6) -- FOREIGN KEY		
);

ALTER TABLE tcons ADD CONSTRAINT tcons_no_pk PRIMARY KEY (NO);
ALTER TABLE tcons MODIFY COLUMN NAME VARCHAR(20) NOT NULL;
ALTER TABLE tcons MODIFY COLUMN jumin VARCHAR(13) NOT NULL;
ALTER TABLE tcons ADD CONSTRAINT tcons_jumin_uk UNIQUE(jumin);
ALTER TABLE tcons ADD CONSTRAINT tcons_area_ck CHECK(AREA IN(1,2,3,4));
ALTER TABLE tcons ADD CONSTRAINT tcons_deptno_fk FOREIGN KEY(deptno) REFERENCES dept2(dcode);

 









