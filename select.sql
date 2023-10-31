-- select from : 테이블의 데이트를 조회할 때 사용
SELECT * FROM emp; -- *의 의미는 전체 컬럼을 의미
-- SELECT 와 FROM 사이에는 조회하고자 하는 컬럼을 쓴다
SELECT empno, ename FROM emp;

-- dept 테이블에서 전체 컬럼 조회
SELECT * FROM dept;
-- dept 테이블에서 deptno, dname 조회
SELECT deptno, dname FROM dept;

-- student 테이블에서 학번, 이름 생일 전화번호 조회
SELECT studno, name, birthday,tel FROM student;

-- where : 행에 대한 조건문(조건에 만족하는 행만 조회할 때 사용)
SELECT * 
FROM emp 
WHERE deptno=10;

SELECT empno, ename, deptno FROM emp WHERE deptno=10;
-- emp 테이블에서 deptno가 10보다 큰 직원의 사번, 이름, 직무, 부서번호를 조회하시오.
SELECT empno, ename, job, deptno FROM emp WHERE deptno>10;

-- student 테이블에서 4학년 학생들의 학번, 이름, 생일, 전화번호, 학년을 조회하시오.
SELECT studno, NAME, birthday, tel, grade FROM student WHERE grade=4;

-- where 절 연산자
-- student 테이블에서 2학년 또는 3학년 학생의 정보를 조회하시오.
SELECT * FROM student WHERE grade=2 OR grade=3;
SELECT * FROM student WHERE grade>=2 and grade<=3;
SELECT * FROM student WHERE grade IN(2,3);

-- student 테이블에서 1학년 또는 2학년 또는 3학년인 학생의 정보를 조회하시오
SELECT * FROM student WHERE NOT grade=4;
SELECT * FROM student WHERE grade NOT IN(4);

-- emp 테이블에서 직무가 CLERK 이거나 SALESMAN인 직원의 사번, 이름, 직무를 조회하시오.
SELECT empno, ename, job FROM emp WHERE job='CLERK' OR job='SALESMAN'; -- 문자열을 작은 따옴표로 묶는다

-- alias : 칼럼명을 바꿔서 조회 -- 큰따옴표는 alias에서만 쓴다, 하지만 스페이스 없으면 안 써도 된다
SELECT empno AS 사번, ename "이 름", job 직무  FROM emp WHERE job='CLERK' OR job='SALESMAN'; -- as 생략 가능

-- student 테이블에서 4학년 학생들의 학번, 이름, 학년을 조회하시오. 컬럼명: 학번, 이름 ,학년
SELECT studno 학번, NAME 이름, grade 학년 FROM student WHERE grade=4;
SELECT studno 학번, NAME 이름, grade 학년 FROM student WHERE grade!=4;

-- professor 테이블에서 홈페이지가 널인 교수 목록 조회
SELECT * FROM professor WHERE hpage is NULL; -- 컬럼값 비교할때 null은 is로 비교한다(=로 비교하지 않는다)
SELECT * FROM professor WHERE hpage is not NULL;

-- 날짜 형식도 비교 연산자가 가능하다. (최신 날짜일수록 크다)
SELECT * FROM emp WHERE hiredate>='1985-01-01';

-- student 테이블에서 1976년생 학생 조회
SELECT * FROM student WHERE birthday>='1976-01-01' AND birthday <='1976-12-31';

-- emp 테이블에서 부서번호가 10이고 급여가 2000 이상인 직원의 목록 조회
SELECT * FROM emp WHERE deptno=10 AND sal>=2000;

-- professor 테이블에서 학과번호가 101이고 정교수인 조회
SELECT * FROM professor WHERE deptno=101 AND POSITION ='정교수';

-- student 테이블에서 전공이나 부전공이 101인 학생 조회
SELECT * FROM student WHERE deptno1=101 OR deptno2=101;

-- student 테이블에서 전공이나 부전공이 101인 학생중 1학년 또는 2학년 학생 조회
SELECT * FROM student WHERE (deptno1=101 OR deptno2=101) AND grade IN(1,2);
 
-- emp2 테이블에서 정규직 중 연봉이 5000만원 이상인 직원의 이름과 직급 연봉 조회
SELECT NAME, position, pay FROM emp2 WHERE emp_type = '정규직' and pay>=50000000;  

-- 컴퓨터정보학부에 소속된 교수의 이름, 직급, 소속학과 조회
SELECT NAME, POSITION, deptno FROM professor WHERE deptno IN (101,102,103);
SELECT NAME, POSITION, deptno FROM professor WHERE deptno=101 OR deptno=102 or deptno=103;

-- 조인형 교수를 담당교수로 하는 학생의 학번, 이름 학년, 학과번호, 교수번호 조회
SELECT studno, NAME, grade, deptno1, profno FROM student where profno=1001; 

-- 노트북을 선물로 받을 수 있는 고객의 고객번호, 이름, 포인트 조회
SELECT gno, gname, POINT FROM gogak WHERE POINT>=600001;

-- exam_01 테이블에서 학점이 B0,B+인 학생의 학번과 점수 조회
SELECT studno, total FROM exam_01 WHERE total>=80 AND total<=89;
SELECT studno, total FROM exam_01 WHERE total BETWEEN 80 AND 89;

-- student 테이블에서 1976년생 학생 조회(between A and B 사용)
SELECT * FROM student WHERE birthday BETWEEN '1976-01-01' AND '1976-12-31';

-- order by: 정렬
SELECT * FROM emp ORDER BY sal ASC; -- 오름차순 (기본)
SELECT * FROM emp ORDER BY sal DESC;-- 내림차순
SELECT * FROM emp WHERE deptno=10 ORDER BY sal DESC;

SELECT studno, NAME FROM student ORDER BY 2; -- Name순으로 정렬 왜냐면 select절에서 두번째 있으니까
SELECT studno, NAME FROM student ORDER BY name;

-- student 테이블에서 4학년 학생들의 학번, 이름, 생일, 학과번호를 생일순으로 정렬하여 조회
SELECT studno, NAME, birthday, deptno1 FROM student WHERE grade =4 ORDER BY 3;

SELECT * FROM emp ORDER BY deptno asc, sal DESC;

-- student 테이블에서 학년순 정렬, 같은 학년은 키가 큰 학생을 앞에 조회
SELECT studno, NAME, grade, height FROM student ORDER BY grade, height DESC;

-- DISTINCT : 중복 행 제거
SELECT distinct(deptno1) FROM student;

-- Like 연산자: 컬럼의 문자열에 특정 문자열이 포함된 것을 거를때 사용
-- 이름의 성이 '서'인 학생 조회
SELECT * FROM student WHERE NAME LIKE '서%'; -- 서 포함 '%서%';

SELECT * FROM emp WHERE job LIKE '%man%';

SELECT * FROM emp WHERE Ename LIKE '_L%'; -- 두번째 글자가 캐릭터가 '?'인걸 찾으시오

-- student테이블에서 9월 생일인 학생의 학번, 이름, 학년, 주민번호 조회
SELECT studno,NAME, grade, jumin FROM student WHERE jumin LIKE '__09%';

-- professor 테이블에서 보너스가 있는 교수들의 교수번호, 이름, 급여, 보너스 조회
SELECT profno, NAME, pay, bonus,pay+bonus FROM professor WHERE bonus IS NOT NULL;

-- ifnull : 해당하는 컬럼이 null일 경우 대체하는 값 지정
SELECT profno, NAME, pay, bonus,pay+ifnull(bonus,0) FROM professor; -- bonus가 null인 경우는 0으로 대체

-- emp 테이블에서 sal이 1000보다 크고 comm이 1000보다 작거나 없는 직원의 사번, 급여, 커미션 조회
SELECT empno, eNAME, sal, comm FROM emp WHERE sal>1000 AND (comm<1000 OR comm IS NULL);