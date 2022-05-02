-- DESC 테이블명
-- 테이블의 구조를 보여주는 명령어
-- NUMBER : 정수, 실수를 표기하는 자료형(*)
-- NUMBER(4) : 4 는 숫자 4자리
-- NUMBER(7,2) : 7 는 정수자리수 7자리 , 2는 소수점자리수 2자리
-- VARCHAR2 : 문자열을 표기하는 자료형(*)
-- UTF8 설정 : 영어(한글자) 1BYTE, 한글(한글자) 3BYTE 
-- 참고)KSC5601 : 영어(한글자) 1BYTE, 한글(한글자) 2BYTE
-- VARCHAR2(10) : 10 자리수
-- DATE : 날짜를 표기하는 자료형
DESC EMPLOYEE;

-- SELECT 절에 컬럼 * 12 사칙연산이 가능
SELECT ENAME, SALARY, SALARY*12 FROM employee;

-- SELECT 절에 컬럼 + 다른컬럼 => 계산이 가능
-- 컬럼 + 다른컬럼(NULL값이 있으면) = NULL(해당 데이터)
-- SALARY : 월급
-- SALARY * 12 : 연봉
-- SALARY * 12 + COMMISSION(보너스) : 최종 1년치 연봉
SELECT ENAME, SALARY, JOB, DNO, COMMISSION, 
       SALARY*12, SALARY*12 + COMMISSION 
FROM employee;

-- 문제점) 상기 값에 (COMMISSION)NULL이 있어서 
--        제대로 최종 1년치 연봉 나오지 않음
-- 해결) NVL(컬럼명, 변경값) : NULL컬럼을 변경값으로 변환
-- SELECT 절에 AS 별칭(Alias) 줄수 있음
SELECT ENAME, SALARY, JOB, DNO, NVL(COMMISSION,0),
       SALARY*12 AS 연봉 , SALARY*12 + NVL(COMMISSION,0) AS 최종연봉
FROM employee;

-- 컬럼에 별칭(Alias)주기 #2
select ENAME, 
       SALARY, 
       job, 
       DNO, 
       NVL(COMMISSION,0) as 보너스,
       SALARY*12 as "연___봉" , 
       SALARY*12 + NVL(COMMISSION,0) as 최종연봉
from EMPLOYEE;

-- DISTINCT : 컬럼에 중복제거하고 보기(테이블 데이터는 영향 없음)
SELECT DISTINCT DNO AS 부서번호
FROM EMPLOYEE;

-- 테스트용 , 간이 계산용 내장테이블 소개
-- 테이블 명 : DUAL
DESC DUAL;

SELECT 10*4/3 FROM DUAL;

-- 현재 시간, 날짜 출력하기 내장함수
SELECT SYSDATE FROM DEPARTMENT;

-- DUAL : 데이터가 1건인 간이 테이블임
SELECT SYSDATE FROM DUAL;

-- 조건 : 범위 검색
-- SALARY(월급) 1500이상인 직원 데이터 뽑기
-- = : 같다, > : 보다 크다, < : 보다 작다, <> : 같지 않다 
SELECT * FROM EMPLOYEE
WHERE SALARY >= 1500;

-- 문제 1) 직원(EMPLOYEE) 테이블에서 
--        부서번호가 20보다 큰 직원을 모두 출력하세요
SELECT * FROM EMPLOYEE
WHERE DNO >= 20;

-- 문자열 검색 : 홑따옴표 쓰기('')
SELECT * FROM EMPLOYEE
WHERE ENAME = 'SCOTT';

-- 날짜 데이터 검색
SELECT * FROM EMPLOYEE
WHERE HIREDATE <= '1981/01/01';

-- 날짜 포맷을 변경해서 문자열로 출력하는 내장 함수 
-- TO_CHAR(컬럼명, 변경포맷) : 날짜, 날짜컬럼 => 문자열로 변경(지정된 포맷)
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;

-- 문자열을 날짜 데이터형식으로 변경하는 내장 함수
SELECT TO_DATE('2022-04-29 17:10:00','YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-- 논리연산자 : AND(동시에 참), OR(둘중에 하나가 참이면 참), NOT(반대)

-- 문제 2) 부서번호가 10이고 직급이 'MANAGER' 인 사원만 출력하기
-- DNO : 부서번호
-- JOB : 직급
-- 대상테이블 : EMPLOYEE
SELECT * FROM employee
WHERE DNO = 10 AND JOB = 'MANAGER';

-- 문제 3) 부서번호가 10이거나 직급이 'MANAGER' 인 사원만 출력하기
SELECT * FROM employee
WHERE DNO = 10 OR JOB = 'MANAGER';

-- 문제 4) 10번 부서에 소속된 사원만 제외하고 나머지 사원의 정보를 출력하세요
SELECT * FROM employee
WHERE NOT DNO = 10;

SELECT * FROM employee
WHERE DNO <> 10;

-- 문제 5) 급여가 1000에서 1500사이의 사원을 출력하세요
-- 대상 테이블 : EMPLOYEE
-- 급여 컬럼명 : SALARY
SELECT * FROM EMPLOYEE
WHERE SALARY >= 1000 AND SALARY <= 1500;

-- 문제 6) 급여가 1000 미만이거나 1500 초과인 사원을 출력하세요
SELECT * FROM EMPLOYEE
WHERE SALARY < 1000 OR SALARY > 1500;

-- 문제 7) 커미션이 300이거나 500이거나 1400인 사원을 출력하세요
SELECT * FROM EMPLOYEE
WHERE COMMISSION=300 OR COMMISSION=500 OR COMMISSION=1400;

-- 범위 검색 2
SELECT * FROM EMPLOYEE
WHERE SALARY >= 1000 AND SALARY <= 1500;
-- 위랑 동일한 문법
-- WHERE절 컬럼명 BETWEEN 초기값 AND 끝값 
-- 초기값 ~ 끝값 사이의 값을 출력하기
SELECT * FROM EMPLOYEE
WHERE SALARY BETWEEN 1000 AND 1500;

SELECT * FROM EMPLOYEE
WHERE SALARY < 1000 OR SALARY > 1500;
-- 위랑 동일한 문법
-- WHERE절 컬럼명 NOT BETWEEN 초기값 AND 끝값
-- 초기값보다 작거나 끝값보다 큰값
SELECT * FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 1000 AND 1500;

-- 문제 8) 1982년도에 입사한 사원 출력하기
-- BETWEEN AND 써서 출력해 보세요
-- 입사일 컬럼명 : HIREDATE
SELECT * FROM employee
WHERE HIREDATE BETWEEN '82/01/01' AND '82/12/31';

-- commission(보너스) 300이거나 500이거나 1400 인 직원 출력
SELECT * FROM employee
WHERE commission = 300 OR commission = 500 OR commission = 1400;
-- 위와 동일한 결과를 보여주는 문법
SELECT * FROM employee
WHERE commission IN (300, 500, 1400);

-- commission(보너스) 300이 아니고 500도 아니고 1400도 아닌 직원 출력
SELECT * FROM employee
WHERE commission <> 300 AND commission <> 500 AND commission <> 1400;
-- 위와 동일한 결과를 보여주는 문법
SELECT * FROM employee
WHERE commission NOT IN (300,500,1400);

-- LIKE 용법 심층해서 검토
-- 어떤 문자가 있는 데이터는 모두 뽑기
-- 1) WHERE 컬럼명 LIKE '문자%'
SELECT * FROM EMPLOYEE
WHERE ENAME LIKE 'F%';

-- 2) WHERE 컬럼명 LIKE '%문자%'
SELECT * FROM EMPLOYEE
WHERE ENAME LIKE '%M%';

-- 문제 9) 이름이 'N'으로 끝나는 사원 검색하기
-- 이름 컬럼명 : ENAME
SELECT * FROM EMPLOYEE
WHERE ENAME LIKE '%N';

-- % : 문자가 없거나 하나 이상의 문자가 어떤 값이 와도 상관없음
-- _ : 하나의 문자가 어떤 값이 와도 상관없음
SELECT * FROM EMPLOYEE
WHERE ENAME LIKE '_A%';

-- 이름의 세번째 글자가 A인 사원 출력하기
SELECT * FROM EMPLOYEE
WHERE ENAME LIKE '__A%';

-- 직원이름 중에 A가 안들어가는 직원의 정보를 출력하세요
SELECT * FROM EMPLOYEE
WHERE ENAME NOT LIKE '%A%';

-- NULL : 아무값도 없고, 공간도 없는 것
-- NULL 과 연산을 하시면 NULL 됨
-- IS NULL : NULL 인 데이터만 뽑기
SELECT * FROM EMPLOYEE
WHERE commission IS NULL;

-- IS NOT NULL : NULL이 아닌 데이터만 뽑기
SELECT * FROM EMPLOYEE
WHERE commission IS NOT NULL;

-- 문제 10) 보너스(COMMISSION) 이 NULL 값 중에서 
--          월급(SALARY)가 1000보다 큰 직원의 정보를 출력하세요
SELECT * FROM employee
WHERE commission IS NULL
AND SALARY >= 1000;

-- 문제 11) 직원 테이블에서 날짜 정보를 내림차순으로 정렬하여 출력하세요
SELECT * FROM EMPLOYEE
ORDER BY HIREDATE DESC;

-- 문제 12) 동일한 급여을 받는 사원에 대해서 이름의 순서가 빠른 사람부터 출력해 주세요
-- 사원테이블 : EMPLOYEE
SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC, ENAME ASC;

-- 오라클 내장 함수
-- 1) UPPER(문자열)/LOWER(문자열)/INITCAP(문자열)
SELECT 'Oracle mania',
    UPPER('Oracle mania') AS 대문자,
    LOWER('Oracle mania') AS 소문자,
    INITCAP('Oracle mania') AS "첫글자 대문자"
FROM DUAL;

-- 직원 테이블 
SELECT ENAME,
    LOWER(ENAME),
    JOB,
    INITCAP(JOB)
FROM EMPLOYEE;

-- scott 사원 검색하기
-- 컬럼의 데이터를 일괄 소문자로 변경해서 비교할 수도 있음
-- 성능은 않좋음
SELECT ENO, ENAME, DNO
FROM employee
WHERE LOWER(ENAME) = 'scott';

-- 참고
SELECT ENO, ENAME, DNO
FROM employee
WHERE INITCAP(ENAME) = 'Scott';

-- 내장함수 2) 문자길이를 반환하는 함수
-- LENGTH(문자열) : 한글/영어 상관없이 문자개수를 세어서 반환
SELECT LENGTH('OracleMania'), 
    LENGTH('오라클매니아')
FROM DUAL;

-- 내장함수 3) 문자 조작 함수
-- CONCAT : 문자의 값을 연결하는 함수(문자열 붙이기)
-- 참고) 문자열 || 문자열 : 문자열 붙이기가 됨
SELECT 'Oracle', 
    'mania',
    CONCAT('Oracle', 'mania'),
    'Oracle' || 'mania'
FROM DUAL;

-- 내장함수 4) 문자 조작 함수
-- 문자열 자르기
-- SUBSTR(대상컬럼(문자), 시작위치, 개수) : 인덱스가 1부터 시작
SELECT SUBSTR('Oracle mania', 4, 3),
    SUBSTR('Oracle mania', -1, 1)
FROM DUAL;

-- 문제 12) 이름이 N으로 끝나는 사원 표시하기
-- 대상 테이블 : EMPLOYEE
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(ENAME, -1, 1) = 'N';

-- 문제 13) 87년도에 입사한 사원 표시하기
-- 대상 테이블 : EMPLOYEE
-- 단, SUBSTR() 쓰기
-- WHERE절에 내장함수를 쓰면 성능에 않좋음
SELECT *
FROM employee
WHERE SUBSTR(HIREDATE, 1, 2) = '87';

-- SUBSTRB(대상컬럼(문자),시작위치,개수) : 문자 BYTE 기준으로 잘라서 출력
-- 영문(1BYTE) : SUBSTR / SUBSTRB 결과가 동일
-- 한글(3BYTE) : SUBSTR / SUBSTRB 결과가 틀림

-- 내장함수 5) 문자열에서 대상 문자 찾아서 인덱스 번호 반환
-- 오라클에서는 인덱스번호가 1부터 시작함
-- INSTR(대상컬럼(문자), 찾을글자, 시작위치, 몇번째 발견)
SELECT INSTR('Oracle mania', 'a')
FROM DUAL;

-- 대상문자열에 'a'의 위치를 5번째위치부터 찾기 시작하고,
-- 두번째 'a'를 찾았을때의 인덱스번호를 반환
SELECT INSTR('Oracle mania', 'a', 5, 2)
FROM DUAL;

-- 문제 14) 사원(직원) 테이블에서 세 번째 자리가 'R'인 
--       사원을 검색하는 쿼리문을 작성하세요
-- 단, INSTR을 사용하세요
-- EMPLOYEE : 사원 테이블
-- ENAME 컬럼 : 사원이름 컬럼
-- 몰라도 되겠습니다. WHERE 절에 내장함수를 씌우면 성능이 않좋음
SELECT *
FROM employee
WHERE INSTR(ename, 'R', 3, 1) = 3;