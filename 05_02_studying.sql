-- 2022-05-02 실습
-- LPAD(컬럼명, 자리수, 채울문자)
-- 왼쪽(LEFT) 자리를 특정 기호로 채우는(PAD) 내장함수
SELECT LPAD(SALARY, 10, '*')
FROM EMPLOYEE;

-- RPAD(컬럼명, 자리수, 채울문자)
-- 오른쪽(RIGHT) 자리를 특정 기호로 채우는(PAD) 내장함수
SELECT RPAD(SALARY, 10, '*')
FROM EMPLOYEE;

-- LTRIM(문자열) : 왼쪽 공백 제거
-- RTRIM(문자열) : 오른쪽 공백 제거
-- TRIM(문자열) : 양쪽 공백 제거
SELECT ' Oracle mania ',
    LTRIM(' Oracle mania '),
    RTRIM(' Oracle mania '),
    TRIM(' Oracle mania ')
FROM DUAL;

-- 숫자 함수
-- ROUND(실수, 반올림할자리수(생략가능)) : 특정자리수에서 반올림하는 내장 함수
SELECT 98.7654,
    ROUND(98.7654), -- 첫째자리 반올림
    ROUND(98.7654, 2), -- 둘째자리 반올림( 매개변수에 2째자리 지정 )
    ROUND(98.7654, -1) -- 정수 1자리 반올림
FROM DUAL;

-- TRUNC : 특정 자릿수에서 버림
SELECT 98.7654,
    TRUNC(98.7654),-- 첫째자리에서 버림
    TRUNC(98.7654, 2), -- 둘째자리에서 버림
    TRUNC(98.7654, -1) -- 정수 1자리 버림
FROM DUAL;

-- MOD : 첫번째 값을 두번째 값으로 나눈 나머지를 반환(자바의 나머지 연산자 같음)
SELECT MOD(31, 2),
    MOD(31, 5),
    MOD(31, 8)
FROM DUAL;

-- 문제 1) 모든 사원의 급여를 500으로 나눈 나머지를 계산해서 출력해 보세요
-- 사원 테이블 : EMPLOYEE
-- 급여 컬럼 : SALARY
SELECT ENAME, SALARY,
    MOD(SALARY, 500)
FROM EMPLOYEE;

-- 날짜 함수
-- 시스템에 저장된 현재 날짜를 반환하는 변수
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

-- 날짜 연산
SELECT SYSDATE - 1 AS 어제,
    SYSDATE AS 오늘,
    SYSDATE + 1 AS 내일
FROM DUAL;

-- 도전과제) 사원들의 현재까지의 근무일수 구하기
-- 단, 실수로 나오면 반올림하기
-- 직원 테이블 : EMPLOYEE
-- 입사일 컬럼 : HIREDATE
SELECT ROUND(SYSDATE-HIREDATE) AS 근무일수
FROM EMPLOYEE;

-- MONTHS_BETWEEN(현재날짜, 과거날짜)
-- 날짜와 날짜 사이의 개월 수를 구하는 내장 함수
-- 근무일수를 개월수로 출력한 내용
SELECT ENAME, SYSDATE, HIREDATE,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS 개월수
FROM EMPLOYEE;

-- 입사한지 6개월 지난 날짜를 구하고 싶은 1인
-- ADD_MONTHS(날짜컬럼, 더할 개월수) : 날짜컬럼 + 6개월
SELECT ENAME, HIREDATE,
    ADD_MONTHS(HIREDATE, 6) AS "6개월후"
FROM EMPLOYEE;

-- 오늘을 기준으로 최초로 도래하는 토요일 구하기
-- NEXT_DAY(기준날짜, 요일)
SELECT SYSDATE,
    NEXT_DAY(SYSDATE, '토요일') AS "이번주 토요일",
    NEXT_DAY(SYSDATE, 7) AS "숫자로 이번주 토요일"
FROM DUAL;

-- 입사한 날의 마지막 날 구하기
-- LAST_DAY(날짜컬럼) : 그 달의 마지막 날을 반환
SELECT ENAME, HIREDATE,
    LAST_DAY(HIREDATE)
FROM EMPLOYEE;

-- 자료형 변환 함수
-- TO_CHAR : 날짜형 또는 숫자형을 문자형으로 변환하는 내장함수
-- TO_CHAR(날짜컬럼, 지정포맷) : 날짜를 지정된 포맷을 가진 문자열로 변환
SELECT ENAME, HIREDATE,
    TO_CHAR(HIREDATE,'YY-MM') AS "년도(2자리) 월",
    TO_CHAR(HIREDATE, 'YYYY/MM/DD DAY') AS "년도(4자리) 월 일 요일",
    TO_CHAR(HIREDATE, 'YYYY-MM-DD HH24:MI:SS') AS "자주쓰는 포맷"
FROM EMPLOYEE;

-- TO_CHAR : 숫자를 지정된 포맷을 가진 문자열로 변환
-- 9 : 자릿수를 나타냄, 자릿수가 맞지 않으면 공간을 채우지 않음
-- 0 : 자릿수를 나타냄, 자릿수가 맞지 않으면 0으로 채움
-- L : 각 지역별 통화 기호를 앞에 표시
-- , : 천 단위 자리 구분을 위해 표시
SELECT ENAME, SALARY,
      TO_CHAR(SALARY, 'L999,999') AS "돈 표시",
      TO_CHAR(SALARY, 'L000,000') AS "돈 표시2"
FROM EMPLOYEE;

-- TO_DATE : 문자를 날짜로 변환하는 내장 함수
-- 도전과제) 1981년 2월 20일 입사한 사원 검색하기
-- 사원 테이블 : EMPLOYEE
-- 입사일 컬럼 : HIREDATE
SELECT ENAME, HIREDATE
FROM EMPLOYEE
WHERE HIREDATE=TO_DATE('19810220');

-- 문자를 숫자로 바꾸는 내장 함수
-- TO_NUMBER(문자열숫자, 지정포맷) : 문자열을 지정된 포맷의 숫자로 바꾸기
SELECT TO_NUMBER('100,000','999,999') 
        - TO_NUMBER('50,000','999,999')
FROM DUAL;

-- 연습문제 1) SUBSTR함수를 사용하여 사원들의 입사한 년도와 입사한 달(월)만 출력하세요
-- 힌트 출력형태 : SELECT 년도, 달(월) FROM EMPLOYEE
SELECT  HIREDATE,
        SUBSTR(HIREDATE, 1, 2 ) AS "년도",
        SUBSTR(HIREDATE, 4, 2 ) AS "달"
FROM EMPLOYEE;

-- 연습문제 2) SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력하세요.
-- 사원테이블 : EMPLOYEE
-- 입사일 컬럼 : HIREDATE
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(HIREDATE, 4,2) = '04';

-- 연습문제 3) 
-- 사번이 짝수인 사원 출력하기
-- MOD 내장함수를 사용하세요
SELECT * 
FROM EMPLOYEE
WHERE MOD(ENO, 2) = 0;

-- 연습문제 4)
-- 올해 며칠이 지났는지 출력하시오. 
-- 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하시오
-- 단, TO_DATE 함수를 사용해서 형을 일치 시켜 계산하시오.
SELECT TRUNC(SYSDATE - TO_DATE('20220101', 'YYYYMMDD'))
FROM DUAL;

-- 일반 함수 *
-- NVL(NULL이 포함된 컬럼, 바꿀값) : NULL 이면 0 또는 다른 값으로 바꾸는 내장 함수
SELECT ENAME, SALARY,
    COMMISSION,
    NVL(COMMISSION, 0) AS "보너스",
    SALARY * 12 + NVL(COMMISSION, 0) AS "연봉"
FROM EMPLOYEE
ORDER BY JOB;

-- NVL2(컬럼값, 표현식1, 표현식2)
-- 컬럼값이 NULL이면 표현식2을 반환하고, NULL이 아니면 표현식1를 반환

SELECT ENAME, SALARY, COMMISSION,
        NVL2(COMMISSION, SALARY*12 + COMMISSION, SALARY*12)
FROM EMPLOYEE
ORDER BY JOB;

-- NULLIF(표현식1, 표현식2)
-- 표현식1 == 표현식2 NULL 출력 , 아니면 표현식1을 출력
SELECT NULLIF('A', 'A'),
    NULLIF('A', 'B')
FROM DUAL;

-- 오라클에서 IF/ ELSE IF/ ELSE 방법 *
-- DECODE(표현식, 조건1, 결과1
--               조건2, 결과2
--               조건3, 결과3
--               기본결과)
    
SELECT ENAME, DNO,
    DECODE(DNO, 10, '회계부',
                20, '연구소',
                30, '영업부',
                40, '운영팀',
                'DEFAULT') AS "부서이름"
FROM EMPLOYEE
ORDER BY DNO;

-- 또다른 방식 IF / ELSE IF / ELSE 방식 *
SELECT ENAME, DNO,
    CASE WHEN DNO = 10 THEN '회계부'
         WHEN DNO = 20 THEN '연구소'
         WHEN ENO = 30 THEN '영업부'
         WHEN ENO = 40 THEN '운영팀'
         ELSE 'DEFAULT' 
    END AS "부서이름"
FROM EMPLOYEE
ORDER BY DNO;

-- 연습문제 5) 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 NULL값 대신
-- 0을 출력하시오.
-- 사원테이블 : EMPLOYEE
-- 상관 컬럼 : MANAGER
SELECT ENO, ENAME,
    NVL2(MANAGER, MANAGER, 0) AS MANAGER,
    NVL(MANAGER, 0)
FROM EMPLOYEE;


-- 연습문제 6) (DECODE, CASE WHEN) 함수로 직급에 따라 급여를 인상하도록 하시오.
-- 직급이 'ANALYST' 인 사원은 200,
-- 직급이 'SALESMAN' 인 사원은 180
-- 직급이 'MANAGER' 인 사원은 150
-- 직급이 'CLERK' 인 사원은 100
SELECT ENO, ENAME, JOB, SALARY,
    DECODE(JOB, 'ANALYST', SALARY+200,
                'SALESMAN', SALARY+180,
                'MANAGER', SALARY+150,
                'CLERK', SALARY+100,
                SALARY) AS "급여 인상"
FROM EMPLOYEE;

-- 그룹함수
-- SUM : 누적합계를 반환
-- AVG : 그룹의 평균을 반환
-- COUNT : 그룹의 개수를 반환
-- MAX : 그룹의 최대값을 반환
-- MIN : 그룹의 최소값을 반환

SELECT SUM(SALARY) AS "급여 총액",
       TRUNC(AVG(SALARY)) AS "급여 평균",
       MAX(SALARY) AS "최대 급여",
       MIN(SALARY) AS "최소 급여"
FROM EMPLOYEE;

-- 문제 4) 최근에 입사한 사원과 가장 오래전에 입사한 사원의 입사일 출력하기
-- 사원 테이블 : EMPLOYEE
-- 입사일 컬럼 : HIREDATE
SELECT MAX(HIREDATE) AS 최근,
    MIN(HIREDATE) AS 오래전
FROM employee;

-- 그룹함수 VS NULL : NULL 내부적으로 제외하고 계산함
SELECT SUM(COMMISSION) AS "커미션 총액"
FROM employee;

-- COUNT : 건수 세기
SELECT COUNT(*)
FROM EMPLOYEE;

-- COMMISSION을 받는 사원의 수를 알고 싶은 1인
-- 그룹함수는 NULL을 제외하기 때문에 
-- 커미션받는 사람 개수를 구할 수 있음
SELECT COUNT(COMMISSION)
FROM employee;
-- 위와 동일
SELECT COUNT(COMMISSION)
FROM employee
WHERE COMMISSION IS NOT NULL;

-- 활용 예)
SELECT COUNT(JOB) AS "직업의 개수"
FROM EMPLOYEE;
-- 위의 예는 중복이 포함되어 있음
-- 중복 제거 직업 개수는 아래와 같음
SELECT COUNT(DISTINCT JOB) AS "중복 제거 직업의 개수" 
FROM  EMPLOYEE;

-- 그룹함수를 쓰실때 조심해야 할것
-- 일반컬럼과 같이 쓸 수 없음, 그룹함수 끼리 써야함
SELECT COUNT(ENO), MAX(SALARY)
FROM employee;

-- ** GROUP BY 절
-- 그룹함수 : 하나의 결과값을 보여줌(COUNT, MAX, SUM )
-- 예시) 부서별로 평균 급여를 알고 싶을 때
-- GROUP BY 컬럼명 => SELECT 컬럼명
SELECT DNO AS "부서번호",
      TRUNC(AVG(SALARY)) AS "평균 급여"
FROM EMPLOYEE
GROUP BY DNO; -- 부서번호로 그룹핑

-- 잘못된 쓰임 예시 : ENAME -> GROUP BY 절에 없는 컬럼임
SELECT DNO AS "부서번호",
        ENAME,
      TRUNC(AVG(SALARY)) AS "평균 급여"
FROM EMPLOYEE
GROUP BY DNO; -- 부서번호로 그룹핑

-- 도전과제) 부서별, 직급별 총급여를 계산하여 출력해 주세요
--          단, 부서별, 직급별로 오름차순으로 정렬해 주세요
-- 부서 컬럼 : DNO
-- 직급 컬럼 : JOB
-- 대상 테이블 : EMPLOYEE
SELECT DNO AS "부서번호",
      JOB,
      SUM(SALARY) AS "총 급여"
FROM EMPLOYEE
GROUP BY DNO, JOB; -- 부서번호로 그룹핑

-- GROUP BY 절에 조건걸기
-- HAVING 그룹함수(컬럼) > 조건값
-- 부서별로 최대 급여를 구하는데 3000이상 되는 것만 출력해 주세요
SELECT DNO, MAX(SALARY)
FROM employee
GROUP BY DNO
HAVING MAX(SALARY) > 3000;


-- 도전과제) 1) MANAGER를 제외하고 2) 급여 총액이 5000이상인 직급별 급여 총액(SUM)구하기
--         단, 급여 총액을 기준으로 오름차순으로 정렬하세요
-- 직원 테이블 : EMPLOYEE
-- 직급 컬럼 : JOB
-- 급여 컬럼 : SALARY
SELECT JOB, SUM(SALARY)
FROM employee
WHERE JOB NOT LIKE '%MANAGER%'
GROUP BY JOB
HAVING SUM(SALARY) >= 5000
ORDER BY SUM(SALARY);

-- 조인 *****
-- 사원번호가 7788인 직원의 부서명은?
SELECT DNO
FROM employee
WHERE ENO = 7788;

DESC employee;

SELECT DNAME
FROM department
WHERE dno = 20;

-- 상기 목적을 달성하려면 JOIN을 쓰면 한번에 조회가 가능함
-- 일반 JOIN(EQUAL JOIN, INNER JOIN) : 교집합 
SELECT A.DNO, A.DNAME, A.LOC
FROM DEPARTMENT A,
     employee B
WHERE B.DNO = A.DNO
AND B.ENO = 7788;