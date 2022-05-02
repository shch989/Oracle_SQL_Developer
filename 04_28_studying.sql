-- 검색(R)
-- * : ALL COLUMN ( DEPTNO, DNAME, LOC )
--SELECT * FROM DEPT;
SELECT DEPTNO, DNAME, LOC FROM DEPT;

-- 한 컬럼만 보기 ( DEPTNO )
SELECT DEPTNO FROM DEPT;

-- 다른 컬럼들도 한개씩 보기
SELECT DNAME FROM DEPT;

-- 다른 컬럼들도 한개씩 보기
SELECT LOC FROM DEPT;

-- 조건에 맞는 데이터 가져오기
-- WHERE [조건절] : 조건 문법
-- DEPT 테이블에 DNAME(부서이름) 이 'SALES' 인 데이터를 가져오세요
SELECT DNAME FROM dept WHERE DNAME = 'SALES';
-- DEPT 테이블에 DEPTNO(부서넘버) 가 10 인 데이터를 컬럼이(DEPTNO) 가져오세요

-- WHERE [조건컬럼] LIKE 'S%'
-- 조건컬럼에 S로 시작되는 문자열은 모두 가져오시요
SELECT ENAME FROM EMP WHERE ENAME LIKE 'S%';

-- EMP 테이블에서 JOB에 M로 시작되는 문자열을 가진 데이터는 모두 가져오세요
-- SELECT 들어가는 컬럼의 위치에 따라 데이터 출력 순서가 바뀜
SELECT JOB, ENAME FROM EMP WHERE JOB LIKE 'M%';

-- 내장함수 UPPER(문자열) : 대문자바꾸기
-- LOWER(문자열) : 소문자바꾸기
-- DB 테이블 데이터는 대소문자를 별개의 문자열로 인식함
SELECT ENAME, JOB FROM EMP WHERE JOB = UPPER('manager');

-- 정렬 : 오름차순
-- SELECT 문 끝에 ORDER BY [컬럼명] ASC;
-- DNAME(부서명) 을 오름차순으로 정렬해 주세요
SELECT * FROM DEPT ORDER BY DNAME ASC;

-- 정렬 : 내림차순
-- SELECT 문 끝에 ORDER BY [컬럼명] DESC;
-- DNAME(부서명) 을 내림차순으로 정렬해 주세요
SELECT * FROM DEPT ORDER BY DNAME DESC;

-- 정렬 : 오름차순
-- 문제 3) EMP 테이블에서 JOB이 'MANAGER' 애들의 데이터를 뽑아서 
-- ENAME(직원이름) 대상으로 오름차순으로 정렬해 주세요
SELECT * FROM EMP 
WHERE JOB = 'MANAGER' 
ORDER BY ENAME ASC;

-- 정렬 : 내림차순
-- 문제 3) EMP 테이블에서 JOB이 'CLERK' 애들의 데이터를 뽑아서 
-- ENAME(직원이름) 대상으로 내림차순으로 정렬해 주세요
SELECT * FROM EMP 
WHERE JOB = 'CLERK' 
ORDER BY ENAME DESC;

-- 도전 과제
--  EMP 테이블에서 JOB이 'CLERK' 애들의 데이터를 뽑아서 
-- ENAME(직원이름), EMPNO(직원번호) 대상으로 내림차순으로 정렬해 주세요
SELECT ENAME, EMPNO FROM EMP 
WHERE JOB = 'CLERK' 
ORDER BY ENAME DESC, EMPNO DESC;

--  EMP 테이블에서 JOB이 'CLERK' 애들의 데이터를 뽑아서 
-- ENAME(직원이름) 은 내림차순, EMPNO(직원번호)는 오름차순으로 정렬해 주세요
-- 복수 정렬은 각각의 컬럼에 대해 DESC/ASC 걸어주어야 함
SELECT ENAME, EMPNO FROM EMP 
WHERE JOB = 'CLERK' 
ORDER BY ENAME DESC, EMPNO; -- 오름차순 ASC 는 생략 가능