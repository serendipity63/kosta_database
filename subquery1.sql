-- SELECT COLUMN_LIST
-- FROM TABLE
-- WHERE 조건연산자 (SELECT COLUMN_LIST FROM TABLE WHERE 조건); -- query in another query

-- =, <>(!=), >, >=, <, <= : 단일행 서브쿼리 연산자
-- 16 + 16
SELECT ename, comm
FROM emp
WHERE comm < (SELECT comm FROM emp WHERE ename='WARD'); -- 단일 컬럼 섭쿼리

-- 16 * 16
SELECT e1.ENAME, e1.COMM
FROM emp e1, emp e2 
WHERE e2.ENAME='WARD' AND e1.COMM < e2.COMM; -- 같은 결과지만 이게 더 오래걸림

-- student, department 테이블을 이용하여 서진수 학생과 주전공이 동일한 학생들의 이름과 전공 조회
SELECT s.name, d.dname
FROM student s JOIN department d ON s.deptno1= d.deptno
WHERE deptno1 = (SELECT deptno1 FROM student WHERE NAME ='서진수'); -- subquery부터 먼저 만들고 다른거 하기

-- professor, department 테이블을 이용하여 박원범 교수보다 나중에 입사한 사람의 이름과 입사일, 학과명 조회
SELECT p.name, p.hiredate, d.dname
FROM professor p JOIN department d USING(deptno)        -- ON p.deptno=d.deptno
WHERE hiredate > (SELECT hiredate FROM professor WHERE NAME='박원범');

-- student 테이블에서 주전공이 201번인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게 조회
-- subquery: 주전공이 201번인 학과의 평균 몸무게
SELECT NAME, weight
FROM student
WHERE weight > (SELECT AVG(weight) FROM student WHERE deptno1= 201)
ORDER BY 2 DESC;

-- student 테이블에서 주전공이 전자공학과인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게 조회
SELECT NAME, weight
FROM student
WHERE weight > (SELECT AVG(weight) 
						FROM student s JOIN department d ON s.deptno1=d.deptno 
						WHERE d.dname='전자공학과')
ORDER BY 2 DESC;

-- gogak, gift 테이블을 이용하여 노트북을 받을 수 있는 고객의 이름, 포인트 조회
-- subquery: 노트북의 최저 포인트
SELECT gname, POINT
FROM gogak
WHERE POINT >= (SELECT g_start FROM gift WHERE gname = '노트북');
 
-- emp, dept 테이블을 이용하여 NEWYORK에서 근무하는 직원목록 조회
SELECT *
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE LOC= 'NEW YORK');

-- student, professor 테이블을 이용하여 박원범 교수가 담당한 학생 목록
SELECT *
FROM student
WHERE profno= (SELECT profno from professor WHERE NAME='박원범');

-- gogak, gift 테이블을 사용하여 안광훈 고객이 포인트로 받을 수 있는 상품 목록 조회
SELECT gname
FROM gift
WHERE g_start < (SELECT point FROM gogak WHERE gname = '안광훈');

-- emp, dept 테이블을 이용하여 sales 부서를 제외한 나머지 부서에 속한 직원의 사번, 이름, 부서명 조회
-- subquery: sales 부서번호 조회
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM emp e JOIN dept d USING(deptno)
WHERE deptno <> (SELECT deptno FROM dept WHERE dname = 'SALES');

-- student, exam_01, hakjum 테이블을 이용하여 학점이 B0 미만인 학생의 학번, 이름, 점수 조회
-- b0 min point 
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e USING (studno)
WHERE total < (SELECT min_point FROM hakjum WHERE grade= 'B0') -- 겹치는 칼럼 없을때는 alias 안써도 ㄱㄴ
ORDER BY 3;

-- student, exam_01, hakjum 테이블을 이용하여 학점이 A0인 학생의 학번, 이름, 점수 조회
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e USING (studno)
WHERE e.total BETWEEN  
						(SELECT min_point FROM hakjum WHERE grade = 'A0') AND -- subquery들을 같이 묶을 수 있음
						(SELECT max_point FROM hakjum WHERE grade = 'A0');


-- in, exists, >any, <any, <all, >all : 다중행 서브쿼리 연산자
-- 서브쿼리가 메인쿼리에 의존적일때는 그닥 효과적이지 않음
-- emp2, dept2 테이블을 이용하여 '포항본사'에서 근무하는 직원들의 사번, 이름, 직급, 부서명 조회
-- subquery: area가 '포항본사'인 dcode 조회
SELECT e.EMPNO, e.NAME, e.POSITION, dname
FROM emp2 e JOIN dept2 d ON e.DEPTNO=d.DCODE 
WHERE dcode IN (SELECT DCODE FROM dept2 WHERE AREA = '포항본사');

-- emp2 테이블을 이용하여 '과장' 직급의 최소연봉자보다 연봉이 높은 직원의 사번, 이름, 연봉 조회
SELECT EMPNO, NAME, POSITION, PAY
FROM emp2
WHERE pay >ANY (SELECT pay FROM emp2 WHERE POSITION = '과장'); -- 과장 직급의 연봉

SELECT EMPNO, NAME, POSITION, PAY
FROM emp2
WHERE pay > (SELECT min(pay) FROM emp2 WHERE POSITION = '과장')

-- 각 학년별 키가 가장 큰 학생의 이름과 학년 조회 (in 연산자: 입력된 값 중에 하나라도 일치하는게 있으면)
SELECT NAME, grade, height
FROM student
WHERE (grade, height) IN (SELECT grade, MAX(height) 
									FROM student 
									GROUP BY grade)
ORDER BY 2;

-- student 테이블에서 2학년 학생들의 체중에서 가장 적게 나가는 학생보다 적은 학생의 이름, 학년, 몸무게 조회 
SELECT NAME, grade, weight
FROM student
WHERE weight <ALL (SELECT weight FROM student WHERE grade = 2) ORDER BY 3;

-- emp2 테이블에서 본인이 속한 부서의 평균 연봉보다 적게 받는 직원의 이름, 연봉, 부서명 조회
SELECT e1.NAME, e1.PAY, d.DNAME
FROM emp2 e1 JOIN dept2 d ON e1.DEPTNO=d.DCODE
WHERE e1.PAY < (SELECT AVG(pay) FROM emp2 WHERE deptno=e1.DEPTNO) ORDER BY 2;

-- emp2, dept2 테이블에서 각 부서별 평균 연봉을 구하고 그 중에서 평균 연봉이 가장 적은 부서의 평균
-- 연봉보다 많이 받는 직원들의 직원명, 부서명, 연봉 조회
-- subquery: 부서별 평균 연봉
SELECT e.NAME, d.DNAME, e.PAY 
FROM emp2 e JOIN dept2 d ON e.DEPTNO= d.DCODE
WHERE pay >ANY (SELECT AVG(pay) FROM emp2 GROUP BY DEPTNO);

-- professor, department 테이블에서 각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름, 입사일, 학과명 조회
SELECT p.profno, p.name, p.hiredate, d.dname
FROM professor p join department d USING (deptno)
WHERE (deptno, hiredate) IN (SELECT deptno, min(hiredate) FROM professor GROUP BY deptno)
ORDER BY 3; 

-- emp2 테이블에서 직급별 최대 연봉을 받는 직원의 이름과 직급, 연봉 조회
SELECT NAME, POSITION, PAY
FROM emp2
WHERE (position, pay) IN (SELECT position, MAX(pay) 
									FROM emp2 
									GROUP BY POSITION);

-- student, exam_01, department 테이블에서 같은 학과 같은 학년 학생의 평균 점수보다 점수가 높은 학생의
-- 학번, 이름, 학과, 학년, 점수 조회
SELECT s1.studno, s1.name, s1.deptno1, d.dname, s1.grade, e1.total
FROM student s1 JOIN exam_01 e1 USING (studno)
JOIN department d ON s1.deptno1= d.deptno 
WHERE e1.total>=
		(SELECT AVG(total) 
			FROM student s2 join exam_01 e2 USING(studno) 
			WHERE s2.deptno1=s1.deptno1 AND s2.grade=s1.grade)
ORDER BY s1.deptno1, s1.grade;

SELECT deptno1, grade, AVG(total) 
FROM student s2 join exam_01 e2 USING(studno) 
GROUP by deptno1, grade;

-- emp2 테이블에서 직원들 중 자신의 직급의 평균연봉과 같거나 많이 받는 사람들의 이름, 직급, 연봉 조회
-- 단, 직급이 없으면 조회하지 않는다
SELECT e1.NAME, e1.POSITION, e1.PAY 
FROM emp2 e1
WHERE (e1.POSITION IS NOT NULL AND TRIM(e1.POSITION) <> '')
		AND e1.PAY >= (SELECT AVG(e2.pay) FROM emp2 e2 WHERE e2.position= e1.position);
		
-- student, professor 테이블에서 담당 학생이 있는 교수들의 교수번호, 교수명 조회
SELECT DISTINCT s.profno, p.name -- 더 효과적임
FROM student s JOIN professor p USING(profno)
WHERE profno IS NOT NULL;

SELECT p.profno, p.name
FROM professor p
WHERE EXISTS (SELECT * FROM student WHERE profno=p.profno); -- where절은 한행한행 비교한다

SELECT profno, p.name
FROM (SELECT DISTINCT profno FROM student) e JOIN professor p USING(profno); -- student에 있는 profno만 가져옴

-- student, professor 테이블에서 담당 학생이 없는 교수들의 교수번호, 교수명 조회
SELECT p.profno, p.name
FROM professor p
WHERE NOT EXISTS (SELECT * FROM student WHERE profno=p.profno);  -- select all from student where student profno= professor profno

-- emp, dept 테이블에서 직원이 한명도 소속되지 않은 부서의 부서번호와 부서명 조회
INSERT INTO dept VALUES(50,'MARKETING','HONGKONG');

SELECT d.DEPTNO, d.DNAME
FROM dept d
WHERE NOT EXISTS (SELECT * FROM emp e WHERE d.DEPTNO=e.DEPTNO);

-- limit
SELECT * 
FROM emp
ORDER BY sal DESC
LIMIT 0, 5; -- 첫번째(0)부터 5개

SELECT * 
FROM emp
ORDER BY sal DESC
LIMIT 5,5;

















