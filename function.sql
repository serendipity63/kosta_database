-------------------------------------------------------------
-- 문자열 함수-
-------------------------------------------------------------
-- concat : 문자열을 이을때 사용
SELECT CONCAT(ename,'(',job,')') AS 'ename_job' FROM emp;

-- SMITH's sal is $800
SELECT CONCAT(ename,'''s sal is $',sal) as info from emp; -- 따옴표를 인식하게 하려면 두개 쓴다

-- format : #,###,###.## 숫자형 데이터의 포맷 지정
SELECT FORMAT(250500.1254,2);
SELECT empno, ename, sal FROM emp;
SELECT empno, ename, format(sal,0) FROM emp; -- 문자열 타입으로 바뀐다

-- insert : 문자열 내의 지정된 위치에 특정 문자 수만큼 문자열을 변경한다.
SELECT INSERT('http://naver.com',8,5,'kosta'); -- naver를 kosta로 변경

-- student 테이블에서 주민번호 뒤 7자리를 *로 대체하여 학생정보 조회
-- (학번, 이름, 주민번호, 학년)
SELECT studno 학번, NAME 이름, INSERT(jumin,7,7,'*******') 주민번호, grade 학년 FROM student;

-- gogak 테이블의 고객번호와 이름 조회(단, 이름은 가운데 글자를 *로 대체)
SELECT gno 고객번호, insert(gNAME,2,1,'*') 이름  FROM gogak;

-- instr : 문자열 내에서 특정 문자의 위치를 구한다.
SELECT INSTR('http://naver.com', 'n');

-- student 테이블의 tel에서 )의 위치 구하기
SELECT INSTR(tel, ')') FROM student;

-- substr : 문자열 내에서 부분 문자열 추출
SELECT SUBSTR('http://naver.com', 8,5);
SELECT SUBSTR('http://naver.com', 8);

SELECT INSTR(tel,')') FROM student;
SELECT SUBSTR(tel,1,INSTR(tel, ')')-1) FROM student;

-- student 테이블에서 전화번호의 가운데자리수만 추출
SELECT SUBSTR(tel,INSTR(tel,')')+1,INSTR(tel,'-')-INSTR(tel,')')-1) 국번 FROM student;

-- student 테이블에서 주민번호 생년월일이 9월인 학생 조회
SELECT studno, NAME, jumin from student WHERE SUBSTR(jumin, 3,2)='09';

-- length : 문자열의 바이트 수 구하기(영문한글자:1byte, 한글한글자:3byte)
SELECT LENGTH(tel) FROM student;

-- professor 테이블에서 이메일에 @ 뒤에 오는 길이 구하기
SELECT LENGTH(email) FROM professor;
SELECT email, INSTR(email,'@') FROM professor;
SELECT email, SUBSTR(email, INSTR(email,'@')+1), LENGTH(SUBSTR(email, INSTR(email,'@')+1)) LENGTH FROM professor;
SELECT email, INSERT(email, INSTR(email,'@')+1,length(SUBSTR(email,INSTR(email,'@')+1)), 'kosta.com') length FROM professor; 

-- char_length: 문자열의 글자수 구하기
SELECT ename, char_LENGTH(ename) FROM emp;
SELECT NAME, char_LENGTH(NAME) FROM student;

-- substring : = substr
SELECT SUBSTR('http://naver.com',8,5);
SELECT SUBSTRING('http://naver.com',8,5);

-- 소문자로 변경: LOWER, LCASE
SELECT eNAME, LOWER(ename) FROM emp;
SELECT eNAME, LCASE(ename) FROM emp;

-- 대문자로 변경: UPPER, UCASE
SELECT id, UPPER(id) FROM professor;
SELECT id, UCASE(id) FROM professor;

-- trim: 앞 뒤 공백 제거
SELECT LENGTH('     test           '), length(TRIM('    test     '));
SELECT LENGTH('t e s t'), length(TRIM('t e s t'));

-- ltrim: 왼쪽 공백 제거
SELECT LENGTH('     test           '), length(LTRIM('    test     '));

-- rtrim: 오른쪽 공백 제거
SELECT LENGTH('     test           '), LENGTH(RTRIM('    test     '));

SELECT sal, ename FROM emp; -- 문자열은 왼쪽에 숫자는 오른쪽에 정렬(기본)

-- lpad: 왼쪽을 특정 문자로 채워넣기
SELECT sal, LPAD(ename,20,' ') 이름 FROM emp;
SELECT LPAD(email,20, '123456789') FROM professor;

-- rpad: 오른쪽을 특정 문자로 채워넣기
SELECT sal, RPAD(ename,20,'*') 이름 FROM emp;



-------------------------------------------------------------
--  날짜 함수
-------------------------------------------------------------
-- curdate,current date
SELECT CURDATE();
SELECT CURRENT_DATE();

SELECT CURDATE()+1;

-- ADDDATE, DATE_ADD : 연, 월, 일을 더하거나 뺀다
SELECT ADDDATE(CURDATE(), INTERVAL -1 YEAR); -- DATE MONTH YEAR 다 할 수 있다
SELECT DATE_ADD(CURDATE(), INTERVAL -1 year);

-- emp 테이블에서 각 직원의 입사일과 10년 기념일을 조회
SELECT hiredate, ADDDATE(hiredate, INTERVAL 10 YEAR) 10년 기념일  FROM emp;
SELECT hiredate, ADDDATE(hiredate, 2)FROM emp; -- 기본은 day다

-- curtime(), currrent_time
SELECT CURTIME(), CURRENT_TIME();
SELECT CURTIME(), ADDTIME(CURTIME(),'1:10:5'); -- 1 hr 10min 5sec 

-- now() : 현재 날짜 & 시간
SELECT NOW();
SELECT NOW(), ADDTIME(NOW(),'2 1:10:5'); -- 2days 1hr 10min 5sec

-- DATEDIFF: 날짜 간격 계산
SELECT hiredate, DATEDIFF(CURDATE(),hiredate) FROM emp;
SELECT DATEDIFF(CURDATE(),'1972-04-03') FROM emp;

-- DATE_FORMAT
SELECT DATE_FORMAT('2017-06-15',"%M %D %Y");
SELECT DATE_FORMAT('2017-06-15',"%m %d %y");
SELECT DATE_FORMAT(NOW(), "%M %d %Y %H: %i: %s %W");
-- 월 : %M(September),  %b(Sep), %m(09), %c(9)
-- 연 : %Y(2023), %y(23)
-- 일 : %d(05), %e(5)
-- 요일: %W(Tuesday), %a(Tue)
-- 시간: %H(13), %(1)
-- %r : hh:mm:ss AM,PM
-- 분 :%i
-- 초 :%S

-- DATE_SUB: 날짜 빼기
SELECT CURDATE(),DATE_SUB(CURDATE(),INTERVAL 10 DAY);
SELECT CURDATE(),ADDDATE(CURDATE(),INTERVAL -10 DAY);

-- DAY, DAYOFMONTH : 날짜에서 일 추출
SELECT hiredate, DAY(hiredate) FROM emp;
SELECT hiredate, DAYofmonth(hiredate) FROM emp;

SELECT hiredate, YEAR(hiredate) FROM emp;
SELECT hiredate, MONTH(hiredate) FROM emp;

SELECT NOW(), HOUR(NOW());
SELECT NOW(), MINUTE(NOW());
SELECT NOW(), SECOND(NOW());

-- DAYNAME, DAYOFWEEK(숫자로 표시) : 날짜에서 요일 추출
SELECT hiredate, DAYNAME(hiredate), DAYOFWEEK(hiredate) FROM emp;
SELECT CURDATE(), DAYOFWEEK(CURDATE()) FROM emp; -- 일요일: 1, 월요일: 2,...

-- EXTRACT 
SELECT CURDATE(), EXTRACT(MONTH FROM CURDATE()) AS MONTH;
SELECT CURDATE(), EXTRACT(YEAR FROM CURDATE()) AS YEAR;
SELECT CURDATE(), EXTRACT(WEEK FROM CURDATE()) AS WEEK;
SELECT CURDATE(), EXTRACT(DAY FROM CURDATE()) AS DAY;
SELECT CURDATE(), EXTRACT(QUARTER FROM CURDATE()) AS QUARTER;
SELECT CURDATE(), EXTRACT(YEAR_MONTH FROM CURDATE()) AS "YEAR_MONTH";
SELECT NOW(), EXTRACT(HOUR FROM NOW()) AS HOUR;
SELECT NOW(), EXTRACT(MINUTE FROM NOW()) AS MINUTE;
SELECT NOW(), EXTRACT(SECOND FROM NOW()) AS SECOND;

-- TIME_T0_SEC 시간을 초로 변환
SELECT CURTIME(), TIME_TO_SEC(CURTIME());

-- TIMEDIFF
SELECT CURTIME(), TIMEDIFF(CURTIME(),'08:48:27');
SELECT TIME_TO_SEC(TIMEDIFF(CURTIME(),'08:48:27'));

-------------------------------------------------------------
--  숫자 함수
-------------------------------------------------------------
-- count: 조건에 만족하느 레코드(행) 수
SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp; -- 컬럼명이 매개변수로 사용시 null인 레코드는 제오히

SELECT COUNT(*) FROM emp WHERE deptno=10;

-- sum
SELECT SUM(sal) FROM emp;
SELECT SUM(sal) FROM emp WHERE deptno=10;

-- avgtestdb
SELECT SUM(sal), COUNT(*), sum(sal)/COUNT(*), AVG(sal) FROM emp;
SELECT SUM(comm), COUNT(comm), COUNT(*), sum(comm)/COUNT(*), sum(comm)/count(comm),AVG(comm) FROM emp;
SELECT SUM(comm), SUM(comm)/COUNT(*),AVG(IFNULL(comm,0)) FROM emp;

-- max
SELECT MAX(sal) FROM emp;

-- min
SELECT Min(sal) FROM emp;

-- professor 테이블에서 각 교수들의 연봉을 조회하시오
-- 교수번호, 이름, 월급여, 보너스, 연봉
SELECT profno 교수번호, NAME 이름, pay 월급여, ifnull(bonus,0) 보너스, pay*12+ifnull(bonus,0) 연봉 
FROM professor;

-- group by
SELECT deptno, job, COUNT(*), SUM(sal) FROM emp
GROUP BY deptno, job;

-- student 테이블에서 메인 학과별 학생 수 조회
SELECT deptno1, COUNT(*) FROM student GROUP BY deptno1;

-- student 테이블에서 학년별 평균 키 조회
SELECT grade, format(avg(height),1) FROM student GROUP BY grade;

SELECT deptno no, MAX(sal) FROM emp GROUP BY NO; -- alias를 사용해도 가능

-- 그루핑한 것에 대한 조건은 HAVING 절을 사용
-- emp 테이블에서 평균 급여가 2000 이상인 부서의 부서번호와 평균급여 조회
SELECT deptno, avg(sal) FROM emp 
GROUP BY deptno
HAVING AVG(sal)>=2000;

-- student 테이블에서 각 학과와 학년별 평균 몸무게, 최대, 최소 몸무게를 조회하시오 평균이 50 이상
SELECT deptno1, grade, COUNT(*), AVG(weight), MAX(weight), MIN(weight) 
FROM student 
GROUP BY deptno1, grade
HAVING AVG(weight)>50
ORDER BY deptno1, grade; 