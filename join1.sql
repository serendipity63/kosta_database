-- JOIN

DROP TABLE test1;
CREATE TABLE test1(
A VARCHAR(10),
B VARCHAR(20));

DROP TABLE test2;
CREATE TABLE test2(
A VARCHAR(10),
C VARCHAR(20),
D VARCHAR(20));

INSERT INTO test1 VALUES('a1','b1');
INSERT INTO test1 VALUES('a2','b2');

INSERT INTO test2 VALUES('a3','c3', 'd3');
INSERT INTO test2 VALUES('a4','c4', 'd4');
INSERT INTO test2 VALUES('a5','c5', 'd5');

SELECT t1.A, t2.A,t2.C
FROM test1 t1, test2 t2
WHERE t1.A='a1';

SELECT e.empno, e.ENAME, d.dname
FROM emp e, dept d
WHERE e.DEPTNO=d.deptno AND e.DEPTNO=10; -- 행을 걸러내는건 where절

-- ANSI join(표준 join)
SELECT e.EMPNO, e.ENAME, d.Dname
FROM emp e INNER JOIN dept d -- INNER 생략 가능
ON e.DEPTNO=d.deptno
WHERE e.DEPTNO=10;

-- student, department 테이블을 이용하여 학번, 학생명, 제1학과명 조회
SELECT s.studno, s.name, d.dname
FROM student s, department d
WHERE s.deptno1=d.deptno;

SELECT s.studno, s.name, d.dname 
FROM student s JOIN department d
ON s.deptno1=d.deptno;

-- student, professor 테이블을 이용하여 학번, 학생명, 담당교수명을 조회
SELECT s.studno, s.name, p.name
FROM student s left JOIN professor p -- left join은왼쪽 테이블은 다 가지고옴
ON s.profno=p.profno;

SELECT s.studno, s.name, p.name
FROM student s right JOIN professor p 
ON s.profno=p.profno;

-- union: left+right
SELECT s.studno, s.name, p.name
FROM student s left JOIN professor p
ON s.profno=p.profno
UNION
SELECT s.studno, s.name, p.name
FROM student s right JOIN professor p 
ON s.profno=p.profno;

-- student, department, professor을 이용하여, 학번, 이름 제1전공명, 담당교수명 조회
SELECT s.studno, s.name, d.dname, p.name
FROM student s, department d, professor p
WHERE s.deptno1=d.deptno AND s.profno=p.profno;

SELECT s.studno, s.name, d.dname, p.name
FROM student s JOIN department d ON s.deptno1=d.deptno
LEFT JOIN professor p ON s.profno=p.profno;

-- student, exam_01 테이블을 이용하여 학번, 이름, 시험점수 조회
SELECT s.studno, s.name, e.total 
FROM student s, exam_01 e
WHERE s.studno=e.studno;

SELECT s.studno, s.name, e.total 
FROM student s JOIN exam_01 e
on s.studno=e.studno
ORDER BY 3 desc;

-- student, exam_01, hakjum 테이블을 이용하여 학번, 이름, 시험점수, 학점  조회
SELECT s.studno, s.name, e.total, h.grade
FROM student s, exam_01 e, hakjum h
where s.studno=e.studno AND (e.total BETWEEN h.min_point AND h.max_point);

SELECT s.studno, s.name, e.total, h.grade
from student s JOIN exam_01 e on s.studno=e.studno
JOIN hakjum h ON e.total BETWEEN h.min_point AND h.max_point
order BY 3 DESC;

-- gogak, gift 테이블을 이용하여 고객의 모든 정보와, 고객이 본인의 포인트로 받을 수 있는 가장 좋은 상품조회
SELECT go.*, gi.gname
FROM gogak go, gift gi
WHERE go.point BETWEEN gi.g_start AND gi.g_end 
ORDER BY go.point

SELECT go.*, gi.gname
FROM gogak go JOIN gift gi ON go.point BETWEEN gi.g_start AND gi.g_end
ORDER BY go.point

-- emp2, p_grade 테이블을 이용하여 이름, 직위, 급여, 같은 직급의 최소 급여, 최대급여 조회
SELECT e2.name, e2.pay, g.s_pay, g.e_pay  
FROM emp2 e2, p_grade g
WHERE e2.POSITION=g.position

SELECT e2.name, e2.pay, g.s_pay, g.e_pay  
FROM emp2 e2 join p_grade g
on e2.POSITION=g.position

-- emp2, p_grade 테이블을 이용하여 이름, 직위,나이, 본인의 나이에 해당하는 예상 직급 조회
SELECT e.NAME, e.POSITION, year(CURDATE())-year(e.birthday) 나이, g.position
FROM emp2 e, p_grade g
WHERE year(CURDATE())-year(e.birthday) BETWEEN g.s_age AND g.e_age
ORDER BY 3 DESC;

SELECT e.NAME, e.POSITION, year(CURDATE())-year(e.birthday) 나이, g.position 예상직급
FROM emp2 e join p_grade g
on year(CURDATE())-year(e.birthday) BETWEEN g.s_age AND g.e_age
ORDER BY 3 DESC;

-- gogak, gift 테이블을 이용하여 노트북을 받을 수 있는 고객의 이름, 포인트, 상품명 조회
SELECT go.gname, go.point, gi.gname
FROM gogak go, gift gi
WHERE gi.gname = '노트북' AND go.point>=gi.g_start;

SELECT go.gname, go.point, gi.gname
FROM gogak go JOIN gift gi ON go.point>=gi.g_start
WHERE gi.gname = '노트북';

-------------------------------------------------------------
--  self join
-------------------------------------------------------------
-- dept2 테이블을 이용하여 부서의 모든 정보와 각 부서의 상위 부서명을 조회
SELECT d.*, pd.DNAME
FROM dept2 d left join dept2 pd
on d.PDEPT=pd.DCODE;

-- emp 테이블을 이용하여 직원의 사번, 이름, 담당 매니저 사번과 이름 조회
SELECT e.EMPNO, e.ENAME, em.MGR, em.ENAME
FROM emp e, emp em
where e.mgr=em.empno;

SELECT e.EMPNO, e.ENAME, em.MGR, em.ENAME
FROM emp e join emp em
ON e.mgr=em.empno;

-- student, department 테이블을 이용하여, 학번, 이름, 제1전공명, 제2전공명 조회
SELECT s.studno, s.name, d1.dname 제1전공명, d2.dname 제2전공명
FROM student s JOIN department d1 ON s.deptno1=d1.deptno
LEFT JOIN department d2 ON s.deptno2=d2.deptno; 

-- student, department 테이블을 이용하여 컴퓨터 정보학부에 해당하는 학생의 학번, 이름, 학과번호, 학과명 조회
SELECT s.*, d.*
FROM student s, department d
WHERE s.deptno1=d.deptno AND d.part=100;

SELECT s.studno, s.name, s.deptno1, d1.dname, d2.dname
FROM student s JOIN department d1 ON s.deptno1=d1.deptno
JOIN department d2 ON d1.part= d2.deptno
WHERE d2.dname= '컴퓨터정보학부';

-- student, department 테이블을 이용하여 '전자제어관'에서 수업을 듣는 학생 조회
SELECT s.studno, s.name, d1.dname, d1.build, d2.deptno, d2.dname, d2.build
FROM student s JOIN department d1 ON s.deptno1=d1.deptno
left JOIN department d2 ON s.deptno2=d2.deptno
WHERE d1.build='전자제어관' OR d2.build='전자제어관';

-- emp 테이블을 이용하여 사번, 이름, 입사일, 자신보다 먼저 입사한 사람 인원수 조회
SELECT e1.EMPNO, e1.ENAME, e1.HIREDATE, COUNT(e2.HIREDATE) 입사선배수
FROM emp e1 left JOIN emp e2 ON e1.HIREDATE> e2.HIREDATE
GROUP BY e1.EMPNO, e1.ENAME
ORDER BY 4;

-- professor 테이블을 이용하여 교수번호, 교수이름, 입사일, 자신보다 먼저 입사한 사람 인원수 조회
SELECT p1.profno, p1.name, p1.hiredate, COUNT(p2.hiredate) 입사선배수
FROM professor p1 left JOIN professor p2 ON p1.hiredate> p2.hiredate
GROUP BY p1.profno
ORDER BY 4;

SELECT e.*, d.DNAME
FROM emp e JOIN dept d ON e.DEPTNO=d.DEPTNO;

SELECT e.*, d.DNAME
FROM emp e JOIN dept d USING(deptno); -- 두개의 칼럼명이 같을때 using 사용

SELECT e.*, d.DNAME
FROM emp e NATURAL JOIN dept d; -- NATURAL JOIN: NATURALLY JOIN THE SAME COLUMNS

-- full outer join과 같은 기능
SELECT s.*, p.name
FROM student s LEFT JOIN professor p ON s.profno=p.profno
UNION
SELECT s.*, p.name
FROM student s RIGHT JOIN professor p ON s.profno=p.profno;

