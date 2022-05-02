-- 연습문제 1)
-- 덧셈 연산자를 이용하여 모든 사원에 대해서 $300의 급여 인상을 계산한 후 
-- 사원의 이름, 급여, 인상된 급여를 출력하세요.
SELECT ENAME, SALARY, SALARY+300 AS 인상급여
FROM EMPLOYEE;

-- 연습문제 2)
-- 사원의 이름, 급여, 연간 총수입을 총 수입이 많은 것부터 작은 순으로 출력하세요.
-- ( 연간 총수입은 월급에 12를 곱한 후 $100의 상여금을 더해서 계산하세요 )
SELECT ENAME, SALARY, salary*12+100
FROM employee
ORDER BY salary*12+100 DESC;

-- 연습문제 3)
-- 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은 것부터 작은 순으로 출력하세요
SELECT ENAME, SALARY
FROM employee
WHERE SALARY > 2000
ORDER BY SALARY DESC;

-- 연습문제 4)
-- 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요
SELECT ENAME, DNO
FROM EMPLOYEE
WHERE ENO=7788;

-- 연습문제 5)
-- 급여가 2000에서 3000 사이에 포함되지 않는 사원의 이름과 급여를 출력하세요.
SELECT ENAME, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 2000 AND 3000;

-- 연습문제 6)
-- 1981년 2월 20일 부터 1981년 5월 1일 사이에 입사한 사원의 
-- 이름, 담당 업무, 입사일을 출력하세요
-- JOB 컬럼 : 담당업무
SELECT ENAME, JOB, HIREDATE
FROM employee
WHERE HIREDATE BETWEEN '81/02/20' AND '81/05/01';


-- 연습문제 7)
-- 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력하되
-- 이름을 기준으로 내림차순 출력하세요
-- DNO 컬럼 : 부서번호
SELECT ENAME, DNO
FROM EMPLOYEE
WHERE DNO IN (20, 30)
ORDER BY ENAME DESC;


-- 연습문제 8)
-- 사원의 급여가 2000에서 3000 사이에 포함되고 부서번호가 20 또는 30인 
-- 사원의 이름, 급여와 부서번호를 출력하되 이름순(오름차순)으로 출력하세요
SELECT ENAME, SALARY, DNO
FROM employee
WHERE SALARY BETWEEN 2000 AND 3000
AND DNO IN (20, 30)
ORDER BY ENAME;

-- 연습문제 9)
-- 1981년도에 입사한 사원의 이름과 입사일을 출력하세요
-- 단, LIKE 연산자와 와일드카드(%, _)를 사용하세요
SELECT ENAME, HIREDATE
FROM EMPLOYEE
WHERE HIREDATE LIKE '81%';

-- 연습문제 10)
-- 관리자가 없는 사원의 이름과 담당 업무를 출력하세요
-- MANAGER 컬럼 : 관리자 컬럼
SELECT ENAME, JOB
FROM EMPLOYEE
WHERE MANAGER IS NULL;

-- 연습문제 11)
-- COMMITION(상여금)을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되
-- 급여 및 커미션을 기준으로 내림차순 정렬하여 출력하세요
SELECT ENAME, SALARY, COMMISSION
FROM EMPLOYEE
WHERE COMMISSION IS NOT NULL
ORDER BY SALARY DESC, commission DESC; 

-- 연습문제 12)
-- 이름의 세번째 문자가 R인 사원의 이름을 표시하세요.
SELECT ENAME
FROM EMPLOYEE
WHERE ENAME LIKE '__R%';


-- 연습문제 13)
-- 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하세요.
SELECT ENAME
FROM EMPLOYEE
WHERE ENAME LIKE '%A%'
AND ENAME LIKE '%E%';


-- 연습문제 14)
-- 담당업무(JOB컬럼)가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서
-- 급여가 $1600, $950 또는 $1300이 아닌 
-- 사원의 이름, 담당업무, 급여를 출력하세요
SELECT ENAME, JOB, SALARY
FROM EMPLOYEE
WHERE JOB IN ('CLERK', 'SALESMAN')
AND SALARY NOT IN (1600, 950, 1300);

-- 연습문제 15)
-- 커미션(상여금)이 $500 이상인 사원의 이름과 급여 및 커미션(상여금)을 출력하세요
SELECT ENAME, SALARY, COMMISSION
FROM EMPLOYEE
WHERE COMMISSION >= 500;