-- 연습문제 1) 모든 사원의 급여 최고액, 최저액, 총액 및 평균 급여를 출력하세요.
--  컬럼의 별칭은 : 최고액, 최저액, 총액, 평균급여
-- 단 실수가 나오면 반올림 해주세요
-- 직원 테이블 : EMPLOYEE
-- 급여 컬럼 : SALARY
SELECT MAX(SALARY) AS "최고액",
     MIN(SALARY) AS "최저액",
     SUM(SALARY) AS "총액",
     ROUND(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE;


-- 연습문제 2) 각 담당 업무 유형별로 급여 최고액, 최저액, 총액 및 평균액을 출력하세요.
--  컬럼의 별칭은 : 최고액, 최저액, 총액, 평균급여
-- 단 실수가 나오면 반올림 해주세요
-- 직원 테이블 : EMPLOYEE
-- 급여 컬럼 : SALARY
SELECT JOB AS "담당 업무",
        MAX(SALARY) AS "최고액",
        MIN(SALARY) AS "최저액",
        SUM(SALARY) AS "총액",
        ROUND(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY JOB;

-- 연습문제 3) count(*) 함수를 이용하여 담당 업무가 동일한(담당업무별로) 사원 수를 출력하세요.
-- 직원 테이블 : EMPLOYEE
-- 담당업무 컬럼 : JOB
SELECT JOB, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB;

-- 연습문제 4) 관리자 수를 나열하시오. 
-- 직원 테이블 : EMPLOYEE
-- 직급 컬럼 : MANAGER
SELECT COUNT(MANAGER)
FROM EMPLOYEE;


-- 연습문제 5) 급여 최고액, 급여 최저액의 차액을 출력하세요.
-- 컬럼의 별칭은 "차액"으로 표기하세요
SELECT MAX(SALARY) - MIN(SALARY)
FROM EMPLOYEE;


-- 연습문제 6) 직급별 사원의 최저 급여를 출력하세요, 
-- 관리자를 알 수 없는 사원 및 최저 급여가 2000 미만인 그룹은 제외시키고
-- 결과를 급여에 대한 내림차순으로 정렬하여 출력하세요
SELECT JOB, MIN(SALARY)
FROM employee
WHERE MANAGER IS NOT NULL
GROUP BY JOB
HAVING NOT MIN(SALARY) < 2000
ORDER BY MIN(SALARY) DESC;

-- 연습문제 7) 각 부서에 대해 부서번호, 사원수, 
--  부서 내의 모든 사원의 평균 급여를 출력하세요(부서별 사원수, 평균급여 출력)
-- 컬럼별칭 부서번호, 사원수,  평균급여
-- 평균급여는 소수점 2째자리에서 반올림하세요
SELECT DNO,
    COUNT(*) AS "사원수",
    ROUND(AVG(SALARY), 2) AS "평균급여"
FROM EMPLOYEE
GROUP BY DNO;
    
-- 연습문제 8) 각 부서에 대해(부서별) 부서이름, 지역명, 사원수(O)
-- 부서별 사원의 평균 급여를(O) 출력하세요(DECODE, CASE WHEN)
-- 부서이름 및 지역명은 DEPARTMENT 의 DNAME, LOC 데이터를 참고하세요
-- 컬럼별칭 부서이름, 지역명, 사원수, 평균급여
-- 1) 1차 DECODE(CASE WHEN) 빼고 구하기
-- 2) 2차 DECODE(CASE WHEN) 합해서 구하기
SELECT DECODE(DNO,10, 'ACCOUNTING',
                  20, 'RESEARCH',
                  30, 'SALES',
                  40, 'OPERATIONS') AS 부서이름,
        DECODE(DNO,10, 'NEW YORK',
                  20, 'DALLAS',
                  30, 'CHICAGO',
                  40, 'BOSTON') AS 지역명,
        COUNT(*) AS "사원수",
        TRUNC(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DNO;