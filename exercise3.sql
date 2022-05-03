-- 조인 연습문제
-- 1) = 조인을 이용해서 SCOTT 사원의 부서번호와 부서이름을 출력하시오.
SELECT E.ENAME, E.DNO, D.DNAME
FROM DEPARTMENT D, 
    EMPLOYEE E
WHERE E.DNO = D.DNO
AND E.ENAME = 'SCOTT';

-- 2) 모든 사원의 사원이름과 그 사원이 소속된 부서이름과 지역명을 출력하시오
SELECT ENAME, DNAME, LOC
FROM DEPARTMENT D, 
    EMPLOYEE E
WHERE D.DNO = E.DNO;

-- 3) 10번 부서에 속하는 사원에 대해 직급과 지역명을 출력하시오.
SELECT E.DNO, E.JOB, D.LOC
FROM DEPARTMENT D, 
    EMPLOYEE E
WHERE E.DNO = D.DNO
AND E.DNO = 10;


-- 4) 커미션을 받는 모든사원의 이름, 부서이름, 지역명을 출력하시오.
SELECT E.ENAME, D.DNAME, D.LOC
FROM DEPARTMENT D,
    EMPLOYEE E
WHERE D.DNO = E.DNO
AND e.commission IS NOT NULL
AND e.commission > 0;

-- 5) = 조인과 와일드카드(%)를 사용하여 이름에 A가 포함된 모든 사원의 이름과
--    부서명을 출력하시오.
SELECT E.ENAME, D.DNAME
FROM DEPARTMENT D, 
    EMPLOYEE E
WHERE E.DNO = D.DNO
AND ENAME LIKE '%A%';

-- 6) NEW YORK 에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오.
SELECT E.ENAME, E.JOB, D.DNO, D.DNAME
FROM DEPARTMENT D,
    EMPLOYEE E
WHERE D.DNO = E.DNO
AND D.LOC = 'NEW YORK';

-- 7) DDL(데이터 정의어) 실습
-- 1) 다음 표에 명시된 대로 DEPT 테이블을 생성하시오.
-- 컬럼명  데이터 타입  크기
--  DNO     NUMBER      2
-- DNAME    VARCHAR2   14
--  LOC     VARCHAR2   13
CREATE TABLE DEPT (
    DNO     NUMBER(2),
    DNAME    VARCHAR2(14),
    LOC     VARCHAR2(13)
);
DESC DEPT;

-- 8) 다음 표에 명시된 대로 EMP 테이블을 생성하시오.
-- 컬럼명    데이터 타입    크기
-- ENO      NUMBER         4
-- ENAME    VARCHAR2      10
-- DNO      NUMBER         2
CREATE TABLE EMP (
    ENO      NUMBER(4),
    ENAME    VARCHAR2(4),
    DNO      NUMBER(2)
);
DESC EMP;

-- 9) DDL(데이터 정의어) 실습
-- 긴 이름을 저장할 수 있도록 EMP 테이블을 수정하시오
-- ENAME VARCHAR2(10) -> VARCHAR2(25) 수정
ALTER TABLE EMP MODIFY ENAME VARCHAR2(25);
DESC EMP;

-- EMPLOYEE 테이블을 복사해서 EMPLOYEE2 테이블을 생성하되,
-- 사원번호, 이름, 급여, 부서번호 컬럼만 복사하세요.
CREATE TABLE EMPLOYEE2
AS
SELECT ENO, ENAME, SALARY, DNO
FROM employee;
DESC EMPLOYEE2;

-- 추가적으로 복사 시 컬럼명을 변경할 수 있음
CREATE TABLE EMPLOYEE2(ENO_ID, NAME, SAL, DEPT_ID)
AS
SELECT ENO, ENAME, SALARY, DNO
FROM EMPLOYEE;

DROP TABLE EMPLOYEE2;

-- EMP 테이블을 삭제하시오.
DROP TABLE EMP;

-- EMPLOYEE2 테이블 이름을 EMP로 변경하시오.
RENAME EMPLOYEE2 TO EMP;

-- DEPT 테이블에서 DNAME 컬럼을 제거하시오.
ALTER TABLE DEPT DROP COLUMN DNAME;
DESC DEPT;